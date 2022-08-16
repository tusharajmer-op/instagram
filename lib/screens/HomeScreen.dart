import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:instagram/screens/TweetScreen.dart';
import 'package:instagram/utils/database.dart';

class MyHomeScreen extends StatefulWidget {
  const MyHomeScreen({Key? key}) : super(key: key);

  @override
  State<MyHomeScreen> createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<MyHomeScreen> {
  late DocumentSnapshot _userData;
  bool loader = false;
  getuser() async {
    _userData = await DataBase.getdata();
    print(_userData.get('profile_picture'));
    if (_userData.get('profile_picture') != "https://i.stack.imgur.com/l60Hf.png") {
      print(_userData.get('profile_picture'));
      setState(() {
        loader = true;
      });
    }
  }

  @override
  void initState() {
    getuser();
    super.initState();
  }

  int _pageno = 0;
  void _changeItems(int page) {
    setState(() {
      _pageno = page;
    });
  }

  static const List<Widget> pagewidget = [
    TweetScreen(),
    Text("search"),
    Text("Tranding"),
    Text("notifications"),
    Text("settings"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: SvgPicture.asset("./assets/images/icons8-twitter.svg"),
        centerTitle: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leading: GestureDetector(
            onTap: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pushReplacementNamed(context, "/start");
            },
            child: Container(
              padding: const EdgeInsets.only(left: 7),
              child: Hero(
                tag: "avtar",
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: loader
                      ? NetworkImage(_userData.get('profile_picture'))
                      : const NetworkImage("https://i.stack.imgur.com/l60Hf.png"),
                ),
              ),
            )),
        leadingWidth: 32.0,
      ),
      body: SafeArea(
        child: pagewidget.elementAt(_pageno),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home_outlined,
              color: (_pageno == 0) ? Colors.blue[300] : Colors.white,
            ),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.search_outlined,
              color: (_pageno == 1) ? Colors.blue[300] : Colors.white,
            ),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.mic_outlined,
              color: (_pageno == 2) ? Colors.blue[300] : Colors.white,
            ),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.notifications_outlined,
              color: (_pageno == 3) ? Colors.blue[300] : Colors.white,
            ),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.mail_outline,
              color: (_pageno == 4) ? Colors.blue[300] : Colors.white,
            ),
            label: "",
          ),
        ],
        currentIndex: _pageno,
        onTap: _changeItems,
        elevation: 1.0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
