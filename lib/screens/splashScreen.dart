import 'package:centraldb/helpers/colors.dart';
import 'package:centraldb/provider/appState.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:centraldb/helpers/fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    this.serializaAndNavigate();
  }

  Future serializaAndNavigate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool signedIn = prefs.getBool("signedIn");

    Future.delayed(
      Duration(seconds: 3),
      () => signedIn?? false
          ? Navigator.pushNamedAndRemoveUntil(context, 'home', (route) => false)
          : Navigator.pushNamedAndRemoveUntil(
              context, 'auth', (route) => false),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/icons/kwasu-logo.png",
                  height: 120,
                ),
                SizedBox(height: 50),
                SpinKitDoubleBounce(color: green, size: 30),
              ],
            ),
            Text(
              "Adedeji Stephen Adedokun\n17/67AA/163",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: hoverBlack.withAlpha(300),
                fontSize: pixel14,
                height: 2.0,
                fontWeight: semiBold,
              ),
            )
          ],
        ),
      ),
    );
  }
}
