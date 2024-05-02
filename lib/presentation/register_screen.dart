import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import 'splash_screen.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  var auth = FirebaseAuth.instance;
  var firestore = FirebaseFirestore.instance;
  String _role = 'patient';

  void _register() {
    auth
        .createUserWithEmailAndPassword(
      email: _emailController.text,
      password: _passwordController.text,
    )
        .then((value) {
      firestore.collection('users').doc(value.user!.uid).set({
        'name': _nameController.text,
        'email': _emailController.text,
        'phone': _phoneController.text,
        'role': _role,
      });
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const SplashScreen(),
        ),
      );
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error.toString()),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blue,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(48.0),
            child: Form(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Welcome!',
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: Colors.yellow,
                          ),
                        ),
                        Text(
                          "Your health is our priority",
                          style: TextStyle(
                            fontSize: 19,
                            color: Colors.yellow,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Padding(padding: EdgeInsets.all(10)),
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      hintText: 'Name',
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
                    controller: _emailController,
                    decoration: const InputDecoration(
                      hintText: 'Email',
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
                    controller: _phoneController,
                    decoration: const InputDecoration(
                      hintText: 'Phone Number',
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
                    controller: _passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      hintText: 'Password',
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
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _role = 'patient';
                            });
                            _register();
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: _role == 'patient'
                                      ? Colors.yellow
                                      : Colors.transparent,
                                  width: 2,
                                ),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              child: const Column(children: [
                                Icon(
                                  Icons.person,
                                  color: Colors.white,
                                  size: 75,
                                ),
                                Text(
                                  'Patient',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ]),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _role = 'doctor';
                            });
                            _register();
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: _role == 'doctor'
                                      ? Colors.yellow
                                      : Colors.transparent,
                                  width: 2,
                                ),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              child: const Column(
                                children: [
                                  Icon(
                                    Icons.medical_services,
                                    color: Colors.white,
                                    size: 75,
                                  ),
                                  Text(
                                    'Doctor',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
