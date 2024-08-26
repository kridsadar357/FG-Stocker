// lib/controller/login.dart
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../environment.dart';
import '../pages/my_home_page.dart';

Future<void> validateAndSubmit(BuildContext context, GlobalKey<FormState> formKey, TextEditingController emailController, TextEditingController passwordController) async {
  if (formKey.currentState?.validate() ?? false) {
    final username = emailController.text.trim();
    final password = passwordController.text.trim();
    if (username.isEmpty || password.isEmpty) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('เกิดข้อผิดพลาด'),
          content: Text('กรุณากรอก\nรหัสพนักงาน หรือ รหัสผ่าน'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('รับทราบ'),
            ),
          ],
        ),
      );
    } else {
      final response = await http.post(
        Uri.parse('http://$Api_ipAddress:$Api_port/api/api.php'),
        body: {
          'ssn': username,
          'pass': password,
        },
      );
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        if (responseData['status'] == 'success') {
          String userId = username;
          saveUserId(userId);
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => MyHomePage()),
          );
        } else {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Invalid Credentials'),
              content: Text('The provided username or password is invalid.'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            ),
          );
        }
      } else {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Server Error'),
            content: Text('Failed to communicate with the server. Please try again later.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          ),
        );
      }
    }
  }
}

Future<void> clearUserData() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove('userId');
}

Future<void> saveUserId(String userId) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('userId', userId);
}
