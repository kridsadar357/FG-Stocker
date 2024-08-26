// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors_in_immutables, prefer_const_constructors

import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final FocusNode? focusNode;
  final ValueChanged<String>? onFieldSubmitted; // Added onFieldSubmitted

  CustomTextField({
    required this.controller,
    required this.hintText,
    this.obscureText = false,
    this.focusNode,
    this.onFieldSubmitted, // Added onFieldSubmitted
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(hintText: hintText),
      style: TextStyle(
        fontFamily: 'K2D',
        fontSize: 20,
      ),
      focusNode: focusNode,
      onFieldSubmitted: onFieldSubmitted, // Added onFieldSubmitted
    );
  }
}

