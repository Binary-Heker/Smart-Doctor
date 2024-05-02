import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cyber_cypher_healthcare/presentation/splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class GetUserDataScreen extends StatefulWidget {
  const GetUserDataScreen({super.key});

  @override
  State<GetUserDataScreen> createState() => _GetUserDataScreenState();
}

class _GetUserDataScreenState extends State<GetUserDataScreen> {
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _allergiesController = TextEditingController();
  final TextEditingController _disabilitiesController = TextEditingController();
  final TextEditingController _surgeriesController = TextEditingController();
  final TextEditingController _ongoingTreatmentsController =
      TextEditingController();
  String _gender = "Male";
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  var auth = FirebaseAuth.instance;

  void _saveData() {
    firestore
        .collection("users")
        .doc(auth.currentUser!.uid)
        .collection("data")
        .doc("data")
        .set({
      "age": _ageController.text,
      "height": _heightController.text,
      "weight": _weightController.text,
      "gender": _gender,
      "address": _addressController.text,
      "allergies": _allergiesController.text,
      "disabilities": _disabilitiesController.text,
      "surgeries": _surgeriesController.text,
      "ongoing_treatments": _ongoingTreatmentsController.text,
    });
    debugPrint("Data saved");
    Navigator.pushReplacement(
      context,
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
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _heightController,
                            decoration: const InputDecoration(
                              hintText: 'Height (in cm)',
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
                          child: TextFormField(
                            controller: _weightController,
                            decoration: const InputDecoration(
                              hintText: 'Weight (in kg)',
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
                      ],
                    ),
                    const Padding(padding: EdgeInsets.all(10)),
                    TextFormField(
                      controller: _addressController,
                      maxLines: null,
                      decoration: const InputDecoration(
                        hintText: 'Address',
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
                      controller: _allergiesController,
                      maxLines: null,
                      decoration: const InputDecoration(
                        hintText: 'Allergies',
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
                      controller: _disabilitiesController,
                      maxLines: null,
                      decoration: const InputDecoration(
                        hintText: 'Disabilities',
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
                      controller: _surgeriesController,
                      maxLines: null,
                      decoration: const InputDecoration(
                        hintText: 'Surgeries',
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
                      controller: _ongoingTreatmentsController,
                      maxLines: null,
                      decoration: const InputDecoration(
                        hintText: 'Ongoing Treatments',
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
                        onPressed: () {
                          _saveData();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.yellow,
                          foregroundColor: Colors.black,
                        ),
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
