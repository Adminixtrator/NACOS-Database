import 'dart:convert';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:centraldb/components/buttonGreen.dart';
import 'package:centraldb/components/dropdownWidget.dart';
import 'package:centraldb/components/emailInput.dart';
import 'package:centraldb/components/phoneInput.dart';
import 'package:centraldb/components/textInput.dart';
import 'package:centraldb/helpers/colors.dart';
import 'package:centraldb/helpers/fonts.dart';
import 'package:centraldb/models/session.dart';
import 'package:centraldb/provider/appState.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class AddStudent extends StatefulWidget {
  @override
  _AddStudentState createState() => _AddStudentState();
}

class _AddStudentState extends State<AddStudent> {
  final TextEditingController surname = TextEditingController();
  final TextEditingController firstName = TextEditingController();
  final TextEditingController lastName = TextEditingController();
  final TextEditingController matricNo = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController address = TextEditingController();
  final TextEditingController phone = TextEditingController();
  @override
  void initState() {
    super.initState();
    this.fetchSession();
  }

  List<Session> sessionIds = [];
  List<String> sessions = [];
  int sessionId = 4;
  String gender = "M";
  bool loading = false;

  Future fetchSession() async {
    String url = Provider.of<AppState>(context, listen: false).url;
    String token = Provider.of<AppState>(context, listen: false).token;

    var response = await http.get(url + 'session', headers: {
      'Authorization': "Bearer " + token,
    });
    // print(response.body);

    jsonDecode(response.body)["data"].forEach((e) {
      sessions.add(Session.fromJson(e).year);
      sessionIds.add(Session.fromJson(e));
    });
  }

  Future addStudent() async {
    String url = Provider.of<AppState>(context, listen: false).url;
    String token = Provider.of<AppState>(context, listen: false).token;
    setState(() => loading = true);
    var response = await http.post(url + 'student', headers: {
      'Authorization': "Bearer " + token,
      'Connection': 'keep-alive',
    }, body: {
      "surname": surname.text,
      "firstName": firstName.text,
      "lastName": lastName.text,
      "gender": gender,
      "matricNo": matricNo.text,
      "session_id": sessionId.toString(),
      "email": email.text,
      "address": address.text,
      "phone": phone.text
    });
    print(response.body);
    setState(() => loading = false);
    if (response.statusCode == 200 || response.statusCode == 201) {
      Fluttertoast.showToast(
          msg: "Success!", textColor: white, backgroundColor: green);
      Future.delayed(
          Duration(seconds: 1), () => Navigator.pushNamed(context, 'home'));
    } else {
      Fluttertoast.showToast(
          msg: "An error occured!", textColor: white, backgroundColor: green);
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
          body: SingleChildScrollView(
            padding: EdgeInsets.only(top: 30, left: 20, right: 20, bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Add Student",
                  style: TextStyle(
                    color: hoverBlack,
                    fontSize: pixel26,
                    fontWeight: semiBold,
                  ),
                ),
                SizedBox(height: 30),
                Container(
                  height: 55,
                  child: DropdownWidget(
                    title: "2021/2022",
                    iconPadding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.6),
                    padding: EdgeInsets.only(right: 5, left: 5),
                    altColor: green.withAlpha(100),
                    altTextColor: hoverBlack,
                    altArrowColor: hoverBlack,
                    altDropdownColor: white,
                    textSize: pixel14,
                    callback: (value) {
                      setState(() =>
                          sessionId = sessionIds[sessions.indexOf(value)].id);
                    },
                    store: sessions,
                    borderRadius: BorderRadius.circular(10),
                    arrowSize: 15,
                  ),
                ),
                SizedBox(height: 15),
                TextInput(
                    controller: surname,
                    hintText: "Last name",
                    textInputAction: TextInputAction.next),
                SizedBox(height: 15),
                TextInput(
                    hintText: "First name",
                    controller: firstName,
                    textInputAction: TextInputAction.next),
                SizedBox(height: 15),
                TextInput(
                    hintText: "Middle name",
                    controller: lastName,
                    textInputAction: TextInputAction.next),
                SizedBox(height: 15),
                EmailInput(
                    controller: email,
                    hintText: "Email",
                    textInputAction: TextInputAction.next),
                SizedBox(height: 15),
                TextInput(
                    controller: matricNo,
                    hintText: "Matric number",
                    textInputAction: TextInputAction.next),
                SizedBox(height: 15),
                Container(
                  height: 55,
                  child: DropdownWidget(
                    title: "M",
                    iconPadding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.75),
                    padding: EdgeInsets.only(right: 5, left: 5),
                    altColor: green.withAlpha(100),
                    altTextColor: hoverBlack,
                    altArrowColor: hoverBlack,
                    altDropdownColor: white,
                    textSize: pixel14,
                    callback: (value) {
                      setState(() => gender = value);
                    },
                    store: ["M", "F"],
                    borderRadius: BorderRadius.circular(10),
                    arrowSize: 15,
                  ),
                ),
                SizedBox(height: 15),
                TextInput(
                    controller: address,
                    hintText: "Address",
                    textInputAction: TextInputAction.next),
                SizedBox(height: 15),
                PhoneInput(
                    controller: phone,
                    hintText: "Phone number",
                    onFieldSubmitted: (value) {
                      addStudent();
                    },
                    textInputAction: TextInputAction.go),
                SizedBox(height: 30),
                ButtonGreen(
                  title: "Add student",
                  onPressed: addStudent,
                  color: green,
                  enabled: true,
                  textStyle: TextStyle(
                      fontSize: pixel14, fontWeight: semiBold, color: white),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
