import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cyber_cypher_healthcare/presentation/splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class GetDoctorDataScreen extends StatefulWidget {
  const GetDoctorDataScreen({super.key});

  @override
  State<GetDoctorDataScreen> createState() => _GetDoctorDataScreenState();
}

class _GetDoctorDataScreenState extends State<GetDoctorDataScreen> {
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _clinicAddressController = TextEditingController();
  final TextEditingController _specializationController = TextEditingController();
  final TextEditingController _experienceController = TextEditingController();
  var firestore = FirebaseFirestore.instance;
  var auth = FirebaseAuth.instance;
  String _gender = "Male";

  void _saveDoctorData() {
    firestore.collection("users").doc(auth.currentUser!.uid).collection("data").doc("data").set({
      "age": _ageController.text,
      "address": _clinicAddressController.text,
      "specialization": _specializationController.text,
      "experience": _experienceController.text,
      "gender": _gender,
    });
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const SplashScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blue,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Form(
              child: Padding(
                padding: const EdgeInsets.all(48.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Please fill in your details',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.yellow,
                      ),
                    ),
                    const Padding(padding: EdgeInsets.all(10)),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _ageController,
                            decoration: const InputDecoration(
                              hintText: 'Age',
                              hintStyle: TextStyle(
                                color: Colors.grey,
                              ),
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                                borderSide: BorderSide(
                                  color: Colors.white,
                                ),
                              ),
                              fillColor: Colors.white,
                            ),
                          ),
                        ),
                        const Padding(padding: EdgeInsets.all(10)),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: DropdownButtonFormField(
                                hint: const Text("Gender"),
                                items: const [
                                  DropdownMenuItem(
                                    value: "Male",
                                    child: Text("Male"),
                                  ),
                                  DropdownMenuItem(
                                    value: "Female",
                                    child: Text("Female"),
                                  ),
                                ],
                                onChanged: (value) {
                                  setState(() {
                                    _gender = value!;
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Padding(padding: EdgeInsets.all(10)),
                    TextFormField(
                      controller: _clinicAddressController,
                      maxLines: null,
                      decoration: const InputDecoration(
                        hintText: 'Clinic Address',
                        hintStyle: TextStyle(
                          color: Colors.grey,
                        ),
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                          borderSide: BorderSide(
                            color: Colors.white,
                          ),
                        ),
                        fillColor: Colors.white,
                      ),
                    ),
                    const Padding(padding: EdgeInsets.all(10)),
                    TextFormField(
                      controller: _specializationController,
                      decoration: const InputDecoration(
                        hintText: 'Specialization',
                        hintStyle: TextStyle(
                          color: Colors.grey,
                        ),
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                          borderSide: BorderSide(
                            color: Colors.white,
                          ),
                        ),
                        fillColor: Colors.white,
                      ),
                    ),
                    const Padding(padding: EdgeInsets.all(10)),
                    TextFormField(
                      controller: _experienceController,
                      decoration: const InputDecoration(
                        hintText: 'Experience',
                        hintStyle: TextStyle(
                          color: Colors.grey,
                        ),
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                          borderSide: BorderSide(
                            color: Colors.white,
                          ),
                        ),
                        fillColor: Colors.white,
                      ),
                    ),
                    const Padding(padding: EdgeInsets.all(10)),
                    Container(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.yellow,
                          foregroundColor: Colors.black,
                        ),
                        onPressed: () {
                          _saveDoctorData();
                        },
                        child: const Text('Submit'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
