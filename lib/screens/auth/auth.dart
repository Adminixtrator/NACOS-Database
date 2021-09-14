import 'package:centraldb/components/buttonGreen.dart';
import 'dart:convert';
import 'package:centraldb/components/emailInput.dart';
import 'package:centraldb/components/passwordInput.dart';
import 'package:centraldb/components/textInput.dart';
import 'package:centraldb/helpers/colors.dart';
import 'package:centraldb/provider/appState.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:centraldb/helpers/fonts.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class Auth extends StatefulWidget {
  @override
  _AuthState createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  bool loading = false;

  Future authenticateUser() async {
    String url = Provider.of<AppState>(context, listen: false).url;
    setState(() => loading = true);

    var response = await http.post(url + 'auth/login', headers: {
      'Connection': 'keep-alive',
    }, body: {
      'email': email.text,
      'password': password.text,
    }).catchError((e) {
      setState(() => loading = false);
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text("$e",
            style: TextStyle(
              color: white,
              fontSize: pixel14,
              fontWeight: semiBold,
            )),
        backgroundColor: green,
      ));
    });
    // print(response.statusCode);
    setState(() => loading = false);
    if (response.statusCode == 200) {
      var responseJson = jsonDecode(response.body)["data"];
      Fluttertoast.showToast(
          msg: "Signed in!", textColor: white, backgroundColor: green);

      await Provider.of<AppState>(context, listen: false)
          .setFirstName(responseJson["firstName"]);
      await Provider.of<AppState>(context, listen: false)
          .setLastName(responseJson["lastName"]);
      await Provider.of<AppState>(context, listen: false)
          .setEmail(responseJson["email"]);
      await Provider.of<AppState>(context, listen: false)
          .setTitle(responseJson["title"]);
      await Provider.of<AppState>(context, listen: false)
          .setToken(responseJson["token"]);
      await Provider.of<AppState>(context, listen: false)
          .setPhoneNumber(responseJson["phone"]);
      await Provider.of<AppState>(context, listen: false).setSignedIn(true);

      Navigator.pushNamedAndRemoveUntil(context, "home", (route) => false);
    } else {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text("${jsonDecode(response.body)['message']}",
            style: TextStyle(
              color: white,
              fontSize: pixel14,
              fontWeight: semiBold,
            )),
        backgroundColor: green,
      ));
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: LoadingOverlay(
        isLoading: loading,
        color: green,
        opacity: 0.15,
        progressIndicator: SpinKitChasingDots(
          color: green,
          size: 40,
        ),
        child: Scaffold(
          key: _scaffoldKey,
          body: SingleChildScrollView(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 80),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 20),
                  alignment: Alignment.centerLeft,
                  child: Image.asset("assets/icons/kwasu-logo.png", height: 60),
                ),
                Text(
                  "Let's sign you in.",
                  style: TextStyle(
                      color: hoverBlack,
                      fontSize: pixel40 - 5,
                      fontWeight: semiBold,
                      height: 2.0),
                  textAlign: TextAlign.left,
                ),
                Text(
                  "Welcome back.",
                  style: TextStyle(
                      color: hoverBlack,
                      fontSize: pixel24,
                      fontWeight: regular,
                      height: 1.5),
                  textAlign: TextAlign.left,
                ),
                SizedBox(height: 50),
                EmailInput(
                    controller: email,
                    hintText: "Email",
                    textInputAction: TextInputAction.next),
                SizedBox(height: 15),
                PasswordInput(
                    controller: password,
                    onFieldSubmitted: (value) => authenticateUser(),
                    hintText: "Password",
                    textInputAction: TextInputAction.go),
                SizedBox(height: 40),
                ButtonGreen(
                  title: "Sign In",
                  onPressed: authenticateUser,
                  enabled: true,
                  color: green,
                  textStyle: TextStyle(
                      color: white, fontSize: pixel14, fontWeight: semiBold),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
