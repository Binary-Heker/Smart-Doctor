import 'package:cyber_cypher_healthcare/firebase_options.dart';
import 'package:cyber_cypher_healthcare/providers/chat_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'presentation/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Gemini.init(apiKey: "AIzaSyBflrPPlY1Zn4hJKRdg9zlsU8ohJh7-rJk");
  await dotenv.load(fileName: ".env");
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(RootApp());
}

class RootApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ChatContextProvider()),
      ],
      child: MaterialApp(
        title: 'Healthcare App',
        theme: ThemeData(
          fontFamily: GoogleFonts.montserrat().fontFamily,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
