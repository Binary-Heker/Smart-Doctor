import 'package:cyber_cypher_healthcare/constants/app_colors.dart';
import 'package:cyber_cypher_healthcare/presentation/register_screen.dart';
import 'package:cyber_cypher_healthcare/presentation/splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  var auth = FirebaseAuth.instance;

  void _login() {
    auth
        .signInWithEmailAndPassword(
      email: _emailController.text,
      password: _passwordController.text,
    )
        .then((value) {
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
        child: Padding(
          padding: const EdgeInsets.all(48.0),
          child: Form(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(child: Container()),
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
                Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      _login();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.yellow,
                      foregroundColor: Colors.black,
                    ),
                    child: const Text('Login'),
                  ),
                ),
                Expanded(child: Container()),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RegisterPage(),
                        ),
                      );
                    },
                    child: const Text(
                      'New User? Register here',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
