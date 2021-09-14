import 'package:centraldb/helpers/colors.dart';
import 'package:centraldb/helpers/fonts.dart';
import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  TextInput(
      {@required this.hintText,
      @required this.textInputAction,
      this.controller,
      this.onFieldSubmitted});
  final String hintText;
  final TextInputAction textInputAction;
  final TextEditingController controller;
  final Function(String) onFieldSubmitted;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textInputAction: textInputAction,
      keyboardType: TextInputType.text,
      controller: controller,
      style: TextStyle(
          fontSize: pixel14,
          color: hoverBlack,
        ),
      onFieldSubmitted: onFieldSubmitted,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          fontSize: pixel14,
        ),
        fillColor: greyOfBlack,
        filled: true,
        contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: transparent,
            width: 0.8,
            style: BorderStyle.solid,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: green,
            width: 0.8,
            style: BorderStyle.solid,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: transparent,
            width: 0.8,
            style: BorderStyle.solid,
          ),
        ),
      ),
    );
  }
}
