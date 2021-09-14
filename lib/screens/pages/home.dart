import 'package:centraldb/helpers/colors.dart';
import 'dart:convert';
import 'package:centraldb/helpers/fonts.dart';
import 'package:centraldb/models/student.dart';
import 'package:centraldb/provider/appState.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    this.fetchRecent();
  }

  List<Student> students = [];
  bool loading = true;

  Future fetchRecent() async {
    String url = Provider.of<AppState>(context, listen: false).url;
    String token = Provider.of<AppState>(context, listen: false).token;

    var response = await http.get(url + 'student', headers: {
      'Authorization': "Bearer " + token,
      'Connection': 'keep-alive',
    });

    print(response.body);

    setState(() => loading = false);

    jsonDecode(response.body)["data"].forEach(
      (m) => students.add(Student.fromJson(m)),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: double.infinity,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: 50),
            color: Colors.transparent,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 6,
                              spreadRadius: 2,
                              color: Colors.grey[300],
                              offset: Offset(0, 3.0))
                        ],
                        image: DecorationImage(
                          image: AssetImage("assets/images/user.png"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Container(
                              height: 30,
                              alignment: Alignment.center,
                              child: RaisedButton(
                                color: green,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 0),
                                onPressed: () =>
                                    Navigator.pushNamed(context, 'studentsList'),
                                child: Text(
                                  "Student list",
                                  style: TextStyle(
                                    fontSize: pixel12,
                                    fontWeight: FontWeight.bold,
                                    color: white,
                                  ),
                                ),
                              )), 
                              SizedBox(width: 20),
                              GestureDetector(
                                onTap: () => Navigator.pushNamedAndRemoveUntil(context, 'auth', (route) => false),
                                child: Icon(Icons.logout, color: hoverBlack, size: 20),
                              ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          Container(
            width: double.infinity,
            color: Colors.transparent,
            margin: EdgeInsets.only(top: 20),
            padding: EdgeInsets.symmetric(horizontal: 20),
            alignment: Alignment.centerLeft,
            child: RichText(
              text: TextSpan(
                style: TextStyle(fontFamily: 'Montserrat'),
                children: [
                  TextSpan(
                      text: "Hi,",
                      style: TextStyle(
                        color: hoverBlack,
                        fontSize: pixel26,
                        fontWeight: semiBold,
                      )),
                  TextSpan(
                      text: "\n " +
                          Provider.of<AppState>(context, listen: false).name,
                      style: TextStyle(
                        color: hoverBlack,
                        fontSize: pixel20,
                        fontWeight: regular,
                      )),
                ],
              ),
            ),
          ),
          SizedBox(height: 15),
          Container(
            height: 60,
            margin: EdgeInsets.symmetric(horizontal: 20),
            width: double.infinity,
            alignment: Alignment.topLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Email: " + Provider.of<AppState>(context, listen: false).email, style: TextStyle(
                  color: hoverBlack,
                  fontSize: pixel14 +1,
                  fontWeight: semiBold,
                )),
                SizedBox(height: 15),
                Text("Phone: " + Provider.of<AppState>(context, listen: false).phoneNumber, style: TextStyle(
                  color: hoverBlack,
                  fontSize: pixel14 +1,
                  fontWeight: semiBold,
                )),
              ],
            )
          ),
          SizedBox(height: 15),
          Container(
                height: 0.8,
                margin: EdgeInsets.symmetric(horizontal: 20),
                width: double.infinity,
                color: Colors.grey[300],
              ),
          SizedBox(height: 30),
          Expanded(
            child: Container(
              color: Colors.transparent,
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // recentTransactions.isEmpty
                    //     ? SizedBox()
                    //     :
                    students.isEmpty || loading
                        ? SizedBox()
                        : Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Recent Additions",
                                  style: TextStyle(
                                      color: inputGrey,
                                      fontSize: pixel14,
                                      fontWeight: regular),
                                ),
                                GestureDetector(
                                  onTap: () => Navigator.pushNamed(
                                      context, 'studentsList'),
                                  child: Container(
                                    color: transparent,
                                    padding: EdgeInsets.only(
                                        left: 15, top: 5, bottom: 15),
                                    child: Text(
                                      "See all",
                                      style: TextStyle(
                                        color: inputGrey,
                                        fontSize: pixel14,
                                        fontWeight: regular,
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                    loading
                        ? Container(
                            margin: EdgeInsets.only(top: 50),
                            width: 32,
                            alignment: Alignment.center,
                            child: SpinKitDoubleBounce(
                              color: green,
                              size: 30,
                            ))
                        : students.isEmpty
                            ? Container(
                                height: 200,
                                width: double.infinity,
                                alignment: Alignment.topCenter,
                                child: Text(
                                  "No student records",
                                  style: Theme.of(context).textTheme.subtitle1,
                                ),
                                padding: EdgeInsets.only(top: 60))
                            : Container(
                                width: double.infinity,
                                height: 60.0 * students.length,
                                alignment: Alignment.topCenter,
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                decoration: BoxDecoration(
                                  color: white,
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey[100],
                                        blurRadius: 2,
                                        spreadRadius: 1,
                                        offset: Offset(0, -2))
                                  ],
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(30),
                                    topRight: Radius.circular(30),
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 15),
                                    Container(
                                      height: 4,
                                      width: 30,
                                      decoration: BoxDecoration(
                                        color: green,
                                        borderRadius: BorderRadius.circular(2),
                                      ),
                                    ),
                                    // SizedBox(height: 10),
                                    ListView.builder(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount: students.length,
                                      itemBuilder: (context, index) =>
                                          Container(
                                        padding: EdgeInsets.only(
                                            top: index > 0 ? 10 : 0,
                                            bottom: 15),
                                        color: transparent,
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Icon(Icons.bookmark,
                                                    color: green, size: 16),
                                                SizedBox(width: 15),
                                                RichText(
                                                  text: TextSpan(
                                                    children: [
                                                      TextSpan(
                                                        text: students[index]
                                                            .name,
                                                        style: TextStyle(
                                                          color: hoverBlack,
                                                          fontSize: pixel14,
                                                          fontWeight: regular,
                                                        ),
                                                      ),
                                                      TextSpan(
                                                        text: '\n\n' +
                                                            students[index]
                                                                .email,
                                                        style: TextStyle(
                                                            color: Colors
                                                                .grey[400],
                                                            fontSize: pixel10,
                                                            height: 0,
                                                            fontWeight:
                                                                regular),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            RichText(
                                              textAlign: TextAlign.right,
                                              text: TextSpan(
                                                children: [
                                                  TextSpan(
                                                      text: students[index]
                                                          .matricNumber
                                                          .toUpperCase(),
                                                      style: TextStyle(
                                                          color: green,
                                                          fontSize: pixel12,
                                                          fontWeight:
                                                              semiBold)),
                                                  TextSpan(
                                                    text: '\n\n\t' +
                                                        students[index].gender,
                                                    style: TextStyle(
                                                      color: Colors.grey[400],
                                                      fontSize: pixel10,
                                                      height: 0.0,
                                                      fontWeight: regular,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
