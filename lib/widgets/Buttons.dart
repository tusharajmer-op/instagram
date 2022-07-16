//widget for buttons
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Mybuttons extends StatelessWidget {
  Mybuttons(
      {required this.texts,
      required this.func,
      this.clr = Colors.blue,
      this.tclr = Colors.white,
      this.bclr = Colors.black,
      });
  final String texts;
  final Function func;
  final Color clr;
  final Color tclr;
  final Color bclr;


  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () => func(context),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        padding: const EdgeInsets.symmetric(vertical: 12),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: bclr),
          color: clr,
        ),
        child: Text(
          texts,
          textAlign: TextAlign.center,
          style: TextStyle(color: tclr),
        ),
      ),
    );
  }
}
