// ignore_for_file: avoid_print, nullable_type_in_catch_clause

import 'package:firebase_auth/firebase_auth.dart' as auth;
import "package:cloud_firestore/cloud_firestore.dart";
import 'package:instagram/utils/errorhandler.dart';

class DataBase {
  SignUpUsers(context, List credentials) async {
    print(credentials);

    try {
      if (credentials[0]['data'][0]['Email'] != "" &&
          credentials[0]['data'][0]['Password'] != "" &&
          credentials[0]['data'][0]['Username'] != "" &&
          credentials[0]['dob'] != "") {
        if (credentials[0]['data'][0]['Password'] !=
            credentials[0]['data'][0]['confirm Password']) {
          CustomError().passwordDoesnotMatchError();
        } else {
          auth.UserCredential Cred = await auth.FirebaseAuth.instance
              .createUserWithEmailAndPassword(
                  email: credentials[0]['data'][0]['Email'],
                  password: credentials[0]['data'][0]['Password']);
          print("auth success");
          try {
            if (Cred.user != null) {
              await FirebaseFirestore.instance
                  .collection("users")
                  .doc(Cred.user!.uid)
                  .set({
                "username": credentials[0]['data'][0]['Username'],
                "bio": credentials[0]['bio'],
                "dateofbirth": credentials[0]['dob'],
                "follower": [],
                "following": []
              });
              print("databse success");
            }
          } catch (er) {
            print(er);
            return er;
          }
        }
      }
      return "succes";
      // ignore: empty_catches
    } catch (e) {
      print(e);
      return e;
    }
  }
}
