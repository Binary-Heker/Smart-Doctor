import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants/app_colors.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var auth = FirebaseAuth.instance;
  var firestore = FirebaseFirestore.instance;
  final TextEditingController _doctorEmailController = TextEditingController();
  Map<String, dynamic> _userData = {
    "name": "",
    "phone": "",
    "address": "",
    "age": "",
    "medicalRecords": [],
  };

  void _refreshData() {
    firestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .get()
        .then((value) {
      setState(() {
        _userData["name"] = value.data()!["name"];
        _userData["phone"] = value.data()!["phone"];
      });
    });
    firestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection("data")
        .doc("data")
        .get()
        .then((value) {
      setState(() {
        _userData.addAll(value.data()!);
      });
    });
    firestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection("medical_records")
        .get()
        .then((value) {
      if (value.docs.isEmpty) return;
      setState(() {
        _userData["medicalRecords"] = [];
        for (var doc in value.docs) {
          var data = doc.data();
          data["id"] = doc.id;
          _userData["medicalRecords"].add(data);
        }
      });
      debugPrint(_userData.toString());
    });
  }

  void _shareWithDoctor(String url, String name, String email) {
    firestore
        .collection("users")
        .where("email", isEqualTo: email)
        .get()
        .then((value) {
      if (value.docs.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("No doctor found with this email."),
          ),
        );
        return;
      }
      if (value.docs.first.data()["role"] != "doctor") {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("No doctor found with this email."),
          ),
        );
        return;
      }
      firestore
          .collection("users")
          .doc(value.docs.first.id)
          .collection("shared_documents")
          .doc()
          .set({
        "url": url,
        "name": name,
        "patient": auth.currentUser!.uid,
      }).then((value) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Medical report shared successfully."),
          ),
        );
        Navigator.of(context).pop();
      });
    });
  }

  @override
  void initState() {
    _refreshData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
            child: Column(
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.person,
                      size: 100,
                    ),
                    Expanded(
                      child: Text(
                        _userData["name"],
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                Card(
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "Account Details",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.email,
                              size: 40,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              auth.currentUser!.email!,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Padding(padding: EdgeInsets.all(5)),
                      Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.phone,
                              size: 40,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              _userData["phone"],
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Padding(padding: EdgeInsets.all(5)),
                      Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.location_on,
                              size: 40,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              _userData["address"],
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Padding(padding: EdgeInsets.all(5)),
                      Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.calendar_today,
                              size: 40,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              _userData["age"],
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const Padding(padding: EdgeInsets.all(10)),
                const Text(
                  "Medical Reports",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Padding(padding: EdgeInsets.all(10)),
                Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      FilePicker.platform.pickFiles().then((value) {
                        if (value != null) {
                          var file = File(value.files.single.path!);
                          var fileName = value.files.single.name;
                          var ref = FirebaseStorage.instance
                              .ref()
                              .child("medicalReports")
                              .child(auth.currentUser!.uid)
                              .child(fileName);
                          ref.putFile(file).then((value) {
                            ref.getDownloadURL().then((value) {
                              firestore
                                  .collection("users")
                                  .doc(auth.currentUser!.uid)
                                  .collection("medical_records")
                                  .doc()
                                  .set({
                                "url": value,
                                "name": fileName,
                              });
                              _refreshData();
                            });
                          });
                        }
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.blue,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text("Upload Medical Report"),
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _userData["medicalRecords"].length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                        _userData["medicalRecords"][index]["name"],
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text("Delete"),
                                    content: const Text(
                                        "Are you sure you want to delete this medical report?"),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text("Cancel"),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          firestore
                                              .collection("users")
                                              .doc(auth.currentUser!.uid)
                                              .collection("medical_records")
                                              .doc(_userData["medicalRecords"]
                                                  [index]["id"])
                                              .delete()
                                              .then((value) {
                                            FirebaseStorage.instance
                                                .refFromURL(
                                                    _userData["medicalRecords"]
                                                        [index]["url"])
                                                .delete();
                                          }).then((value) {
                                            _refreshData();
                                            Navigator.of(context).pop();
                                          });
                                        },
                                        child: const Text("Delete"),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text("Share"),
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Text(
                                            "Share this medical report with your doctor."),
                                        const Padding(
                                            padding: EdgeInsets.all(10)),
                                        TextField(
                                          controller: _doctorEmailController,
                                          decoration: const InputDecoration(
                                            hintText: "Doctor's Email",
                                            border: OutlineInputBorder(),
                                          ),
                                        ),
                                      ],
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text("Cancel"),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          _shareWithDoctor(
                                            _userData["medicalRecords"][index]
                                                ["url"],
                                            _userData["medicalRecords"][index]
                                                ["name"],
                                            _doctorEmailController.text,
                                          );
                                        },
                                        child: const Text("Share"),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            icon: const Icon(
                              Icons.share,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text("View"),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Text("Download the file to view it."),
                                  const Padding(padding: EdgeInsets.all(10)),
                                  ElevatedButton(
                                    onPressed: () {
                                      launchUrl(
                                        Uri.parse(_userData["medicalRecords"]
                                        [index]["url"]),
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.blue,
                                      foregroundColor: Colors.white,
                                    ),
                                    child: const Text("Download"),
                                  ),
                                ],
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text("Close", style: TextStyle(color: Colors.black),),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
