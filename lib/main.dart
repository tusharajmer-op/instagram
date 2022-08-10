import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:instagram/screens/HomeScreen.dart';
import 'package:instagram/screens/LoginScreen.dart';
import 'package:instagram/screens/Login_Screen.dart';
import 'package:instagram/screens/ProfilePictureSelector.dart';
import 'package:instagram/screens/Sign_up.dart';
// import 'package:firebase_auth/firebase_auth.dart' as auth;

bool dis = false;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseAuth.instance.authStateChanges().listen((User? user) {
    if (user != null) {
      dis = true;
    }
  });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.hasData) {
              return MyHomeScreen();
            } else
              return Loginscreen();
          } else if (snapshot.connectionState == ConnectionState.none) {
            return const Center(child: Text("server error"));
          }
          return Loginscreen();
        }),
      ),
      routes: ({
        "/start": (context) => const Loginscreen(),
        "/homepage": (context) => const MyHomeScreen(),
        "/login": (context) => const LoginScreens(),
        "/signup": (context) => const Signup(),
        "/ProfilePictureSelect": ((context) => const ProfilePicture())
      }),
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color.fromARGB(231, 21, 20, 20),
      ),
    );
  }
}
