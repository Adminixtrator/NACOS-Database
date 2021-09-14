import 'package:centraldb/helpers/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PhoneInput extends StatelessWidget {
  PhoneInput(
      {@required this.hintText,
      @required this.textInputAction,
      this.inputFormatters,
      this.maxLength,
      this.autofocus,
      this.altMessage,
      this.controller,
      this.onFieldSubmitted,
      this.obscureText,
      this.isSecret,
      this.validator,
      this.altWarningColor});
  final String hintText;
  final List<TextInputFormatter> inputFormatters;
  final TextInputAction textInputAction;
  final int maxLength;
  final bool autofocus;
  final Color altWarningColor;
  final String altMessage;
  final TextEditingController controller;
  final Function(String) onFieldSubmitted;
  final bool obscureText;
  final bool isSecret;
  final Function(String) validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textInputAction: textInputAction,
      keyboardType: TextInputType.phone,
      autofocus: autofocus ?? false,
      maxLength: maxLength,
      onFieldSubmitted: onFieldSubmitted,
      controller: controller,
      obscureText: obscureText ?? false,
      inputFormatters: inputFormatters ?? [],
      style: isSecret == null
          ? Theme.of(context).textTheme.overline
          : TextStyle(
              color: Theme.of(context).textTheme.overline.color,
              fontSize: 16,
              letterSpacing: 6,
              fontWeight: FontWeight.bold),
      validator: validator ??
          (value) {
            String message;
            if (altWarningColor == null) if (maxLength !=
                null) if (value.length != maxLength)
              message = "Length must be $maxLength";
            if (altMessage != null) if (value.length != maxLength)
              message = altMessage;
            return message;
          },
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: isSecret == null
            ? Theme.of(context).textTheme.caption
            : TextStyle(
                color: Theme.of(context).textTheme.overline.color,
                fontSize: 16,
                letterSpacing: 6,
                fontWeight: FontWeight.bold),
        fillColor: greyOfBlack,
        filled: true,
        helperStyle: TextStyle(color: transparent),
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
