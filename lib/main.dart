import 'package:book_a_hall/Models/hall_book_model.dart';
import 'package:book_a_hall/authentication/login_screen.dart';
import 'package:book_a_hall/constants/consonants.dart';
import 'package:book_a_hall/Screens/landing_screen.dart';
import 'package:book_a_hall/provider/chat_provider.dart';
import 'package:book_a_hall/provider/hall_book_provider.dart';
import 'package:book_a_hall/provider/hall_provider.dart';
import 'package:book_a_hall/provider/user_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UserProvider>(
            create: (context) => UserProvider()),
        ChangeNotifierProvider<HallProvider>(
            create: (context) => HallProvider()),
        ChangeNotifierProvider<ChatProvider>(
            create: (context) => ChatProvider()),
        ChangeNotifierProvider<HallBookProvider>(
            create: (context) => HallBookProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            inputDecorationTheme: const InputDecorationTheme(
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: greenColor, width: 2)),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: greenColor, width: 2),
          ),
          border: UnderlineInputBorder(
            borderSide: BorderSide(color: greenColor, width: 2),
          ),
        )),
        home: FirebaseAuth.instance.currentUser == null
            ? const LoginScreen()
            : const LandingPage(),
      ),
    );
  }
}
