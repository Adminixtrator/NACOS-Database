import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppState extends ChangeNotifier {
  String _firstName;
  String _lastName;
  String _title;
  String _email;
  String _token;
  String _phoneNumber;
  String _baseUrl = 'http://164.90.163.155/api/v1/';
  bool _signedIn;

  get firstName => _firstName;

  get lastName => _lastName;

  get title => _title;

  get email => _email;

  get token => _token;

  get phoneNumber => _phoneNumber;

  get url => _baseUrl;

  get name => _title + ' ' + _firstName + ' ' + _lastName;

  get signedIn => _signedIn;

  AppState() {
    getData();
  }

  Future<bool> setFirstName(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _firstName = value;
    notifyListeners();
    return prefs.setString("firstName", value);
  }

  Future<bool> setLastName(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _lastName = value;
    notifyListeners();
    return prefs.setString("lastName", value);
  }

  Future<bool> setTitle(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _title = value;
    notifyListeners();
    return prefs.setString("title", value);
  }

  Future<bool> setEmail(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _email = value;
    notifyListeners();
    return prefs.setString("email", value);
  }

  Future<bool> setPhoneNumber(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _phoneNumber = value;
    notifyListeners();
    return prefs.setString("phoneNumber", value);
  }

  Future<bool> setToken(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _token = value;
    notifyListeners();
    return prefs.setString("token", value);
  }

  Future<bool> setSignedIn(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _signedIn = value;
    notifyListeners();
    return prefs.setBool("signedIn", value);
  }

  void getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String firstName = prefs.getString("firstName") ?? '';
    String lastName = prefs.getString("lastName") ?? '';
    String title = prefs.getString("title") ?? '';
    String email = prefs.getString("email") ?? '';
    String token = prefs.getString("token") ?? '';
    String phoneNumber = prefs.getString("phoneNumber") ?? '';

    _firstName = firstName;
    _lastName = lastName;
    _title = title;
    _email = email;
    _token = token;
    _phoneNumber = phoneNumber;

    notifyListeners();
  }
}
