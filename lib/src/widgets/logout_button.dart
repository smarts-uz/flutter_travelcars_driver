import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_travelcars_driver/src/api/repository.dart';
import 'package:flutter_travelcars_driver/src/model/api_model/http_result.dart';
import 'package:flutter_travelcars_driver/src/theme/app_theme.dart';
import 'package:flutter_travelcars_driver/src/ui/login/login_screen.dart';
import 'package:flutter_travelcars_driver/src/widgets/profile_widget.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LogoutButton extends StatelessWidget {
  final double h;
  final double w;
  final Repository repository;

  const LogoutButton({
    Key? key,
    required this.h,
    required this.w,
    required this.repository,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24 * w),
      child: getButtonProfile(
        context,
        "Выйти",
        (on) {
          showDialog(
            context: context,
            builder: (context) {
              return CupertinoAlertDialog(
                title: const Text("Сообщение"),
                content: const Text("Нажмите Да, чтобы выйти."),
                actions: [
                  GestureDetector(
                    onTap: () async {
                      HttpResult response = await repository.logout();
                      if (response.isSuccess) {
                        SharedPreferences pref =
                            await SharedPreferences.getInstance();
                        pref.setString("token", "");
                        pref.setString("pin", "");
                        Navigator.pop(context);
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ),
                        );
                      } else {
                        Fluttertoast.showToast(
                          msg: response.result.toString(),
                        );
                        Navigator.pop(context);
                      }
                    },
                    child: Container(
                      height: 36,
                      color: Colors.transparent,
                      child: const Center(
                        child: Text(
                          "Да",
                          style: TextStyle(
                            fontFamily: AppTheme.fontFamily,
                            fontWeight: FontWeight.w600,
                            fontStyle: FontStyle.normal,
                            fontSize: 18,
                            color: AppTheme.blue,
                          ),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 36,
                      color: Colors.transparent,
                      child: const Center(
                        child: Text(
                          "Нет",
                          style: TextStyle(
                            fontFamily: AppTheme.fontFamily,
                            fontWeight: FontWeight.w600,
                            fontStyle: FontStyle.normal,
                            fontSize: 18,
                            color: AppTheme.red,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
