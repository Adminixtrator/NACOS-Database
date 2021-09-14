import 'package:flutter/material.dart';
import 'package:centraldb/helpers/colors.dart';

class BackButtonGreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Container(
        height: 35,
        width: 35,
        alignment: Alignment.center,
        child: Container(
          height: 18.33,
          width: 18.75,
          padding: EdgeInsets.only(left: 3),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: green,
            borderRadius: BorderRadius.circular(2),
          ),
          child: Icon(
            Icons.arrow_back_ios,
            color: white,
            size: 13,
          ),
        ),
      ),
    );
  }
}
