import 'package:flutter/material.dart';
class MyAlertBox{
Future<void> MyalertBox(context,String discription, String title) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return  AlertDialog(
          title: Text(title),
          content: Text(
              discription),
          actions: [TextButton(onPressed: ()=>Navigator.of(context).pop(), child: const Text("done"))],
        );
      });
  }
}
