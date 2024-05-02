import 'package:animations/animations.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cyber_cypher_healthcare/constants/app_colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'chat_bot_screen.dart';
import 'doctors_screen.dart';
import 'profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var auth = FirebaseAuth.instance;
  var firestore = FirebaseFirestore.instance;
  String _userName = "";
  List<Map<String, dynamic>> specializations = [
    {
      "name": "Cardiologist",
      "image": "assets/images/heart.png",
    },
    {
      "name": "Pulmonologist",
      "image": "assets/images/lungs.png",
    },
    {
      "name": "Hepatologist",
      "image": "assets/images/liver.png",
    },
    {
      "name": "Neurologist",
      "image": "assets/images/brain.png",
    },
    {
      "name": "Blood Pressure",
      "image": "assets/images/blood_pressure.png",
    },
    {
      "name": "Neurologist",
      "image": "assets/images/brain.png",
    },
  ];

  @override
  void initState() {
    firestore
        .collection("users")
        .doc(auth.currentUser!.uid)
        .get()
        .then((value) {
      debugPrint(value.data()!.toString());
      setState(() {
        _userName = value.data()!["name"];
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              alignment: Alignment.center,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const Padding(padding: EdgeInsets.all(30)),
                    Text(
                      'Welcome, $_userName!',
                      style: const TextStyle(
                        fontSize: 25,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Padding(padding: EdgeInsets.all(10)),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: CarouselSlider(
                        items: [
                          GestureDetector(
                            onTap: () {
                              launchUrl(
                                Uri.parse(
                                    "https://www.who.int/news-room/fact-sheets/detail/coronavirus-disease-(covid-19)#symptoms"),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: AppColors.blue,
                              ),
                              child: const Center(
                                child: Row(
                                  children: [
                                    Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
                                      child: Image(
                                        image: AssetImage(
                                            "assets/images/person_coughing.png"),
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        "Symptoms of Covid-19",
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              launchUrl(
                                Uri.parse(
                                    "https://www.who.int/news-room/fact-sheets/detail/dengue-and-severe-dengue"),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: AppColors.blue,
                              ),
                              child: const Center(
                                child: Row(
                                  children: [
                                    Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
                                      child: Image(
                                        image: AssetImage(
                                            "assets/images/person_dengue.png"),
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        "5 Symptoms of Dengue",
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              launchUrl(
                                Uri.parse(
                                    "https://www.who.int/news-room/fact-sheets/detail/coronavirus-disease-(covid-19)#prevention"),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: AppColors.blue,
                              ),
                              child: const Center(
                                child: Row(
                                  children: [
                                    Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
                                      child: Image(
                                        image: AssetImage(
                                            "assets/images/person_coughing.png"),
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        "5 Precautions against Covid-19",
                                        maxLines: 3,
                                        softWrap: true,
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                        options: CarouselOptions(
                          scrollDirection: Axis.vertical,
                          autoPlay: true,
                          autoPlayInterval: const Duration(seconds: 3),
                          autoPlayAnimationDuration:
                              const Duration(milliseconds: 800),
                          enlargeCenterPage: true,
                        ),
                      ),
                    ),
                    const Padding(padding: EdgeInsets.all(10)),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                      child: Row(
                        children: [
                          Stack(
                            alignment: AlignmentDirectional.center,
                            children: <Widget>[
                              Center(
                                child: SizedBox(
                                  width: 130,
                                  height: 130,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 10,
                                    value: 0.75,
                                    color: AppColors.blue,
                                  ),
                                ),
                              ),
                              const Center(
                                child: Text(
                                  "75%",
                                  style: TextStyle(fontSize: 24),
                                ),
                              ),
                            ],
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                const Text(
                                  "Medication",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600),
                                ),
                                const Padding(padding: EdgeInsets.all(5)),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      "Last taken: 12:00 PM",
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ),
                                ),
                                const Padding(padding: EdgeInsets.all(5)),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      "Next dose: 6:00 PM",
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    const Padding(padding: EdgeInsets.all(10)),
                    const Text(
                      "Find your specialist",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                    const Padding(padding: EdgeInsets.all(5)),
                    Container(
                      height: 400,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
                        child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                          ),
                          itemCount: specializations.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => DoctorsScreen(specialization: specializations[index]["name"], image: specializations[index]["image"],),
                                    ),
                                  );
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: index % 2 == 0
                                        ? AppColors.lightBlue
                                        : AppColors.yellow.withOpacity(0.8),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Expanded(
                                          child: Image(
                                            image: AssetImage(
                                                specializations[index]
                                                    ["image"]),
                                            fit: BoxFit.contain,
                                            color: index % 2 == 0
                                                ? Colors.white
                                                : AppColors.blue,
                                          ),
                                        ),
                                        Text(
                                          specializations[index]["name"],
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: index % 2 == 0
                                                ? Colors.white
                                                : AppColors.blue,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ProfileScreen(),
                      ),
                    );
                  },
                  child: CircleAvatar(
                    radius: 25,
                    backgroundColor: AppColors.blue,
                    child: const Icon(
                      Icons.person,
                      size: 40,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: OpenContainer(
        closedColor: AppColors.blue,
        closedElevation: 6,
        closedShape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        closedBuilder: (context, action) {
          return FloatingActionButton.extended(
            onPressed: action,
            backgroundColor: AppColors.blue,
            label: const Text(
              "ShaktiBot",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            icon: const Icon(
              Icons.chat,
              size: 30,
              color: Colors.white,
            ),
          );
        },
        openBuilder: (context, action) {
          return const ChatBotScreen();
        },
      ),
    );
  }
}
