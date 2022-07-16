import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:instagram/screens/LoginScreen.dart';
import 'package:instagram/screens/Login_Screen.dart';
import 'package:instagram/screens/ProfilePictureSelector.dart';
import 'package:instagram/screens/Sign_up.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      initialRoute: "/",
      routes: ({
        "/": (context) => const Loginscreen(),
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
