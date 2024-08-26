// ignore_for_file: unnecessary_import, prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_element

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'pages/my_home_page.dart';
import 'pages/login.dart';
import 'pages/user_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
void main() {
  
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Your App Title',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.k2dTextTheme(),
      ),
      home: BlocProvider(
        create: (context) => userBloc,
        child: AppRouter(),
      ),
    );
  }
}

class AppRouter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, bool>(
      builder: (context, isAuthenticated) {
        if (isAuthenticated) {
          return MyHomePage();
        } else {
          return LoginPage();
        }
      },
    );
  }
}
