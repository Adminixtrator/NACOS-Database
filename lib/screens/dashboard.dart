import 'package:centraldb/helpers/colors.dart';
import 'package:centraldb/screens/pages/addStudent.dart';
import 'package:centraldb/screens/pages/home.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  void initState() {
    super.initState();
  }

  int currentIndex = 0;
  List<Widget> screens = [
    Home(),
    AddStudent(),
  ];

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        body: screens[currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          selectedItemColor: green,
          onTap: (value) => setState(() => currentIndex = value),
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.person_add), label: 'Add Student'),
          ],
        ),
      ),
    );
  }
}
