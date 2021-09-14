import 'dart:ui';
import 'package:centraldb/helpers/colors.dart';
import 'package:centraldb/helpers/fonts.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class EmailInput extends StatelessWidget {
  EmailInput({
    @required this.hintText,
    @required this.textInputAction,
    this.controller,
    this.onFieldSubmitted,
  });
  final String hintText;
  final TextInputAction textInputAction;
  final TextEditingController controller;
  final Function(String) onFieldSubmitted;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textInputAction: textInputAction,
      keyboardType: TextInputType.emailAddress,
      style: TextStyle(
          fontSize: pixel14,
          color: hoverBlack,
        ),
      onFieldSubmitted: onFieldSubmitted,
      cursorColor: green,
      controller: controller,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) =>
          EmailValidator.validate(value) ? null : "Please enter a valid email",
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
