import 'package:centraldb/helpers/colors.dart';
import 'package:centraldb/helpers/fonts.dart';
import 'package:flutter/material.dart';

class Auth extends StatefulWidget {
  @override
  _AuthState createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: false,
        child: Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Container(
              //   width: double.infinity,
              //   padding: EdgeInsets.symmetric(horizontal: 30, vertical: 40),
              //   child: Image.asset("name"),
              // ),
              Image.asset("name"),
              Text(
                "Enterprise team collaboration.",
                style: TextStyle(
                    color: hoverBlack, fontSize: pixel40, fontWeight: semiBold),
                textAlign: TextAlign.center,
              ),

              Text(
                "Enterprise team collaboration.",
                style: TextStyle(
                    color: hoverBlack, fontSize: pixel40, fontWeight: semiBold),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ));
  }
}
