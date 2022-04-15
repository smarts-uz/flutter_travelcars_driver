import 'package:flutter/material.dart';
import 'package:flutter_travelcars_driver/src/api/repository.dart';
import 'package:flutter_travelcars_driver/src/bloc/home_bloc.dart';
import 'package:flutter_travelcars_driver/src/model/api_model/http_result.dart';
import 'package:flutter_travelcars_driver/src/theme/app_theme.dart';
import 'package:flutter_travelcars_driver/src/ui/main/main_screen.dart';
import 'package:flutter_travelcars_driver/src/utils/center_dialog/center_dialog.dart';
import 'package:flutter_travelcars_driver/src/widgets/profile_widget.dart';
import '../../utils/utils.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _loginController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  Repository repository = Repository();
  bool value = false;

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    // double h = Utils.height(context);
    // double w = Utils.width(context);
    return Scaffold(
      backgroundColor: AppTheme.bgColor,
      appBar: PreferredSize(
        preferredSize: Size.zero,
        child: AppBar(
          elevation: 0,
          backgroundColor: AppTheme.blue,
        ),
      ),
      body: Column(
        children: [
          Container(
            height: 60 * h,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(12 * h),
                bottomRight: Radius.circular(12 * h),
              ),
              color: AppTheme.blue,
            ),
            child: Center(
              child: Text(
                "TravelCars",
                style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 22 * h,
                    height: 26 / 22 * h,
                    color: AppTheme.white),
              ),
            ),
          ),
          const Spacer(),
          Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.only(
              left: 8 * w,
              right: 8 * w,
              top: 16,
            ),
            padding: EdgeInsets.symmetric(horizontal: 8 * w, vertical: 8 * h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(21 * h),
              color: AppTheme.lightGray,
            ),
            child: Container(
              padding:
                  EdgeInsets.symmetric(horizontal: 24 * w, vertical: 20 * h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(21),
                color: AppTheme.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Логи",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontFamily: AppTheme.fontFamily,
                      fontWeight: FontWeight.w600,
                      fontStyle: FontStyle.normal,
                      fontSize: 22 * h,
                      height: 1.38 * h,
                      color: AppTheme.black,
                    ),
                  ),
                  getTextEditController(
                    context,
                    _loginController,
                    "Логин",
                  ),
                  getTextEditController(
                    context,
                    _passwordController,
                    "Пароль",
                  ),
                  SizedBox(
                    height: 22 * h,
                  ),
                  GestureDetector(
                    onTap: () async {
                      setState(() {
                        value = true;
                      });

                      HttpResult k = await homeBloc.setLogin(
                        _loginController.text,
                        _passwordController.text,
                      );
                      value = false;
                      setState(() {});
                      if (k.statusCode == -1) {
                        CenterDialog.simpleCenterDialog(
                          context,
                          "Ошибка",
                          "Проверьте подключение к Интернету!",
                        );
                      } else if (k.statusCode == 0) {
                        CenterDialog.simpleCenterDialog(
                          context,
                          "Ошибка",
                          "${k.result}",
                        );
                      } else {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MainScreen(),
                          ),
                        );
                      }
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.symmetric(vertical: 10 * h),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        color: AppTheme.blue,
                      ),
                      child: !value
                          ? Center(
                              child: Text(
                                "Вход".toUpperCase(),
                                style: TextStyle(
                                  fontFamily: AppTheme.fontFamily,
                                  fontWeight: FontWeight.normal,
                                  fontStyle: FontStyle.normal,
                                  fontSize: 16 * h,
                                  height: 24 / 16 * h,
                                  color: AppTheme.white,
                                ),
                              ),
                            )
                          : const Center(
                              child: CircularProgressIndicator(),
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
