import 'package:flutter/material.dart';

class MytextField extends StatelessWidget {
  const MytextField(
      {required this.controller,
      required this.label,
      this.obscure = false,
      this.keybordtype = TextInputType.text});

  final TextEditingController controller;
  final bool obscure;
  final String label;
  final TextInputType keybordtype;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: TextField(
        controller: controller,
        keyboardType: keybordtype,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
          contentPadding: const EdgeInsets.symmetric(horizontal: 25),
          
        ),
        obscureText: obscure,
        
      ),
    );
  }
}
