import 'package:flutter/material.dart';
import 'package:instagram/widgets/MyAlertBox.dart';

class CustomError implements Exception {
  Future<void> passwordDoesnotMatchError(context) async {
    return MyAlertBox().MyalertBox(context,"Password does not match","Your confirm password does not match with your password ");
  }
}
