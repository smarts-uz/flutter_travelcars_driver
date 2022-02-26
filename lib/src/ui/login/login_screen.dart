import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_travelcars_driver/src/api/repository.dart';
import 'package:flutter_travelcars_driver/src/bloc/home_bloc.dart';
import 'package:flutter_travelcars_driver/src/model/api_model/home_model.dart';
import 'package:flutter_travelcars_driver/src/model/api_model/http_result.dart';
import 'package:flutter_travelcars_driver/src/theme/app_theme.dart';
import 'package:flutter_travelcars_driver/src/ui/main/main_screen.dart';
import 'package:flutter_travelcars_driver/src/widgets/profile_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _loginController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  Repository repository = Repository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.bgColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          getTextEditController(
            context,
            _loginController,
            "login",
          ),
          getTextEditController(
            context,
            _passwordController,
            "password",
          ),
          getButtonProfile(
            context,
            "Login",
            (on) async {
              int k = await homeBloc.setLogin(
                _loginController.text,
                _passwordController.text,
              );
              if (k == -1) {

              } else {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MainScreen(),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
