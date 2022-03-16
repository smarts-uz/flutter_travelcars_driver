import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_travelcars_driver/src/theme/app_theme.dart';
import 'package:flutter_travelcars_driver/src/ui/login/login_screen.dart';
import 'package:flutter_travelcars_driver/src/ui/main/main_screen.dart';
import 'package:flutter_travelcars_driver/src/ui/pin/pin_code_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String token = "";
  String language = "";
  String pinCode = "";

  @override
  void initState() {
    _navigation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: AppTheme.white,
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Image.asset(
            "assets/images/splash.png",
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }

  Future<void> _navigation() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString("token") ?? "";
    pinCode = prefs.getString("pin") ?? "";
    Timer(
      const Duration(milliseconds: 1600),
      () {
        Navigator.pushReplacement(
          context,
          CupertinoPageRoute(
            builder: (context) {
              return token.isEmpty
                  ? const LoginScreen()
                  : pinCode.isNotEmpty
                      ? const PinCodeScreen(status: 0)
                      : const MainScreen();
            },
          ),
        );
      },
    );
  }
}
