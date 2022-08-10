import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MyHomeScreen extends StatefulWidget {
  const MyHomeScreen({Key? key}) : super(key: key);

  @override
  State<MyHomeScreen> createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<MyHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SvgPicture.asset("./assets/images/icons8-twitter.svg"),
        centerTitle: true,
        backgroundColor: Colors.black26,
        leading: GestureDetector(
          onTap: () async {
            await FirebaseAuth.instance.signOut();
            Navigator.pushNamed(context, "/start");
          },
          child: Container(
            padding: const EdgeInsets.only(left: 7),
            child: const CircleAvatar(
                radius: 50,
                backgroundImage:
                    NetworkImage("https://i.stack.imgur.com/l60Hf.png")),
          ),
        ),
        leadingWidth: 32.0,
      ),
    );
  }
}
