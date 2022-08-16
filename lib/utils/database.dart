// ignore_for_file: avoid_print, nullable_type_in_catch_clause

import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart' as auth;
import "package:cloud_firestore/cloud_firestore.dart";
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagram/utils/Global.dart';
import 'package:instagram/utils/roots.dart';
import 'package:uuid/uuid.dart';

import '../widgets/MyAlertBox.dart';

class DataBase {
  late Reference _profilePicPath;

  SignUpUsers(List credentials) async {
    String res = "Some Error Occured!";
    print(credentials);

    try {
      if (credentials[0]['data'][0]['Email'] != "" &&
          credentials[0]['data'][0]['Password'] != "" &&
          credentials[0]['data'][0]['Username'] != "" &&
          credentials[0]['dob'] != "") {
        auth.UserCredential Cred = await auth.FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: credentials[0]['data'][0]['Email'],
                password: credentials[0]['data'][0]['Password']);
        print("auth success");
        try {
          if (Cred.user != null) {
            try {
              print(Cred.user!.uid);
              print(credentials[0]['Profile_Picture']);

              if (credentials[0]['Profile_Picture'] !=
                  "https://i.stack.imgur.com/l60Hf.png") {
                _profilePicPath = FirebaseStorage.instance
                    .ref("profilePictures")
                    .child(Cred.user!.uid);
                await _profilePicPath
                    .putData(credentials[0]['Profile_Picture']);
              }
            } catch (e) {
              print(e.toString());
            }
            await FirebaseFirestore.instance
                .collection("users")
                .doc(Cred.user!.uid)
                .set({
              "username": credentials[0]['data'][0]['Username'],
              "bio": credentials[0]['bio'],
              "dateofbirth": credentials[0]['dob'],
              "follower": [],
              "following": [],
              "profile_picture": (credentials[0]['Profile_Picture'] !=
                      "https://i.stack.imgur.com/l60Hf.png")
                  ? await _profilePicPath.getDownloadURL()
                  : "https://i.stack.imgur.com/l60Hf.png",
            });
            print("success");
            res = "User Created";
            return res;
          }
        } catch (er) {
          print(er);
          return er.toString();
        }
      }
      return "succes";
      // ignore: empty_catches
    } catch (e) {
      print(e);
      return e.toString();
    }
  }

  SignInUser(context, Map credi) async {
    try {
      auth.UserCredential cred = await auth.FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: credi["email"], password: credi["password"]);
      if (cred.user != null) {
        roots.HomePage(context);
      }
    } on auth.FirebaseAuthException catch (e) {
      if (e.code == "invalid-email") {
        MyAlertBox().MyalertBox(context, e.message.toString(), "error");
      } else if (e.code == "user-not-found") {
        MyAlertBox().MyalertBox(context, e.message.toString(), "error");
      } else if (e.code == "wrong-password") {
        MyAlertBox().MyalertBox(context, e.message.toString(), "error");
      }
    } catch (e) {
      MyAlertBox().MyalertBox(context, "error", "error while loging in ");
    }
  }

  static Future getdata() async {
    DocumentSnapshot data = await FirebaseFirestore.instance
        .collection("users")
        .doc(auth.FirebaseAuth.instance.currentUser!.uid)
        .get();
    Global.Updateuser(data.get("username"), data.get("profile_picture"));
    return data;
  }

  Future<bool> Createtweets(tweets, hasImage, im) async {
    try {
      if (hasImage) {
        Reference tweetsPath = FirebaseStorage.instance
            .ref("tweetImages")
            .child(Global.user)
            .child(tweets['imagePath']);
        print("done1");
        await tweetsPath.putData(im);
        tweets['imagePath'] = await tweetsPath.getDownloadURL();
        print("done2");
      }
      await FirebaseFirestore.instance
          .collection("tweets")
          .doc(Global.email)
          .collection("tWEETS")
          .doc(const Uuid().v4())
          .set(tweets);
      print("done3");
      return false;
    } catch (e) {
      print(e.toString());

      // throw e;
    }

    return true;
  }

  static Stream<QuerySnapshot> gettweets() {
    Stream<QuerySnapshot> tweets;
    try {
      tweets = FirebaseFirestore.instance
          .collection("tweets")
          .doc(Global.email)
          .collection("tWEETS")
          .snapshots();
      return tweets;
    } catch (e) {
      print(e);
      throw e;
    }
  }
}
