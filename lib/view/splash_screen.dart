import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:personal_expense_tracker_app/view/home/home_screen.dart';
import 'package:personal_expense_tracker_app/view/login_screen.dart';

class SplashscreenPage extends StatefulWidget {
  @override
  _SplashscreenPageState createState() => _SplashscreenPageState();
}

class _SplashscreenPageState extends State<SplashscreenPage> {
  final user = Hive.box('users').get("ALL_DATA");

  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 3),
        () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => user?.isLogged == null
                    ? const Login_Page()
                    : user?.isLogged == true
                        ? const HomePage()
                        : const Login_Page())));
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: FlutterLogo(size: 120)),
    );
  }
}
