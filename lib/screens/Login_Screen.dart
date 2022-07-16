// ignore: file_names
import "package:flutter/material.dart";
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram/utils/roots.dart';
import 'package:instagram/widgets/Buttons.dart';

class Loginscreen extends StatefulWidget {
  const Loginscreen({Key? key}) : super(key: key);

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  roots root = roots();
  @override
  Widget build(BuildContext context) {
    

    return Scaffold(
      body: SafeArea(
        child: Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SvgPicture.asset("./assets/images/icons8-twitter.svg"),
                Container(
                  alignment: const Alignment(-1, -1),
                  child: const Text(
                    "See what's\nhappening in the\nworld right now.",
                    style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 58.0),
                  child: Column(
                    children: [
                      Mybuttons(
                        texts: "login",
                        func: roots().login,
                      
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: Container(
                            margin: const EdgeInsets.only(left: 10),
                            child: const Divider(
                              height: 1,
                              thickness: 0.5,
                              color: Colors.white,
                            ),
                          )),
                          Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: const Text(
                                "or",
                                style: TextStyle(fontSize: 10),
                              )),
                          Expanded(
                              child: Container(
                            margin: const EdgeInsets.only(right: 10),
                            child: const Divider(
                              height: 1,
                              thickness: 0.5,
                              color: Colors.white,
                            ),
                          ))
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Mybuttons(
                        texts: "sign up",
                        func: roots().signup,
                        clr: Colors.white,
                        tclr: Colors.blue,
                        // objects: {},
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: const Text(
                          "By signing up you agree to our terms and conditons privacy policy and cookies",
                          style: TextStyle(fontSize: 10),textAlign: TextAlign.center,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
