import 'package:centraldb/components/backButtonGreen.dart';
import 'package:centraldb/components/dropdownWidget.dart';
import 'package:centraldb/helpers/colors.dart';
import 'package:centraldb/helpers/fonts.dart';
import 'package:centraldb/models/session.dart';
import 'package:centraldb/models/student.dart';
import 'package:centraldb/provider/appState.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class StudentsList extends StatefulWidget {
  @override
  _StudentsListState createState() => _StudentsListState();
}

class _StudentsListState extends State<StudentsList> {
  @override
  void initState() {
    super.initState();
    this.fetchSession();
    this.fetchRecent();
  }

  List<Student> students = [];
  List<Session> sessionIds = [];
  List<String> sessions = [];
  int sessionId = 7;
  bool loading = true;

  Future fetchSession() async {
    String url = Provider.of<AppState>(context, listen: false).url;
    String token = Provider.of<AppState>(context, listen: false).token;

    var response = await http.get(url + 'session', headers: {
      'Authorization': "Bearer " + token,
      'Content-type': 'keep-alive'
    });
    print(response.body);
    // sessions = [];
    // sessionIds = [];
    jsonDecode(response.body)["data"].forEach((e) {
      sessions.add(Session.fromJson(e).year);
      sessionIds.add(Session.fromJson(e));
    });
  }

  Future fetchRecent() async {
    String url = Provider.of<AppState>(context, listen: false).url;
    String token = Provider.of<AppState>(context, listen: false).token;
    setState(() => loading = true);
    
    var response = await http.get(
        url + "${sessionId > 0 ? 'student?session=$sessionId' : 'student'}",
        headers: {
          'Authorization': "Bearer " + token,
          'Connection': 'keep-alive',
        });
    print(response.body);

    setState(() => loading = false);
    students = [];
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
    return SafeArea(
      top: false,
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.only(top: 70, left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                BackButtonGreen(),
                Text(
                  "Students List",
                  style: TextStyle(
                    color: hoverBlack,
                    fontSize: pixel26,
                    fontWeight: semiBold,
                  ),
                ),
                SizedBox(width: 20),
              ]),
              SizedBox(height: 30),
              Container(
                height: 30,
                width: 110,
                child: DropdownWidget(
                  title: "2021/2022",
                  iconPadding: EdgeInsets.only(left: 20),
                  padding: EdgeInsets.only(right: 5, left: 5),
                  altColor: green,
                  altTextColor: white,
                  altArrowColor: white,
                  altDropdownColor: green,
                  callback: (value) {
                    setState(() =>
                        sessionId = sessionIds[sessions.indexOf(value)].id);
                    this.fetchRecent();
                  },
                  store: sessions,
                  borderRadius: BorderRadius.circular(5),
                  arrowSize: 15,
                ),
              ),
              SizedBox(height: 30),
              Container(
                height: 1,
                width: double.infinity,
                color: Colors.grey[300],
              ),
              loading
                  ? Container(
                      margin: EdgeInsets.only(top: 50),
                      width: double.infinity,
                      alignment: Alignment.center,
                      child: SpinKitChasingDots(
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
                      : Expanded(
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: BouncingScrollPhysics(),
                            itemCount: students.length,
                            itemBuilder: (context, index) => Container(
                              padding: EdgeInsets.only(
                                  top: index > 0 ? 10 : 0, bottom: 15),
                              color: transparent,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                              text: students[index].name,
                                              style: TextStyle(
                                                color: hoverBlack,
                                                fontSize: pixel14,
                                                fontWeight: regular,
                                              ),
                                            ),
                                            TextSpan(
                                              text: '\n\n' +
                                                  students[index].email,
                                              style: TextStyle(
                                                  color: Colors.grey[400],
                                                  fontSize: pixel10,
                                                  height: 0,
                                                  fontWeight: regular),
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
                                                fontWeight: semiBold)),
                                        TextSpan(
                                          text:
                                              '\n\n\t' + students[index].gender,
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
                        ),
            ],
          ),
        ),
      ),
    );
  }
}
