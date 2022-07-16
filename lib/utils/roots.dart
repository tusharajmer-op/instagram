// ignore_for_file: non_constant_identifier_names, camel_case_types

import 'dart:ffi';

import 'package:flutter/material.dart';
class roots{
   login(context) {
      Navigator.pushNamed(context, "/login");
    }
    signup(context) {
      Navigator.pushNamed(context, "/signup");
    }
    ProfilePicture(context,List data){
    Navigator.pushNamed(context, "/ProfilePictureSelect",arguments: data);
    }

}