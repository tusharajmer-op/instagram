// ignore_for_file: avoid_print, nullable_type_in_catch_clause



import 'package:firebase_auth/firebase_auth.dart' as auth;
import "package:cloud_firestore/cloud_firestore.dart";
import 'package:instagram/utils/roots.dart';

import '../widgets/MyAlertBox.dart';

class DataBase {
  SignUpUsers(context, List credentials) async {
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
            await MyAlertBox().MyalertBox(
                context, "Success", "USER ADDED TO DATABASE SUCCESSFULLY");
          }
        } catch (er) {
          print(er);
          return er;
        }
      }
      return "succes";
      // ignore: empty_catches
    } catch (e) {
      print(e);
      return e;
    }
  }

  SignInUser(context, Map credi) async {
    try {
      auth.UserCredential cred = await auth.FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: credi["email"], password: credi["password"]);
      if (cred.user != null) {
        roots().HomePage(context);
      }
    } on auth.FirebaseAuthException catch (e){
      if(e.code=="invalid-email"){
        MyAlertBox().MyalertBox(context, e.message.toString(),"error");
        
      }
      else if(e.code=="user-not-found"){
        MyAlertBox().MyalertBox(context, e.message.toString(),"error");

      }
      else if(e.code=="wrong-password"){
        MyAlertBox().MyalertBox(context, e.message.toString(),"error");

      }
    }
    catch (e) {
      MyAlertBox().MyalertBox(context, "error", "error while loging in ");
    }
  }
}
