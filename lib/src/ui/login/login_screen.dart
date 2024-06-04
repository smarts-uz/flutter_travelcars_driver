import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_travelcars_driver/src/api/repository.dart';
import 'package:flutter_travelcars_driver/src/model/api_model/http_result.dart';
import 'package:flutter_travelcars_driver/src/theme/app_theme.dart';
import 'package:flutter_travelcars_driver/src/ui/main/main_screen.dart';
import 'package:flutter_travelcars_driver/src/utils/center_dialog/center_dialog.dart';
import 'package:flutter_travelcars_driver/src/widgets/profile_widget.dart';

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
            height: 60,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
              color: AppTheme.blue,
            ),
            child: Center(
              child: SvgPicture.asset(
                "assets/images/appBar.svg",
              ),
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.only(
                    left: 8,
                    right: 8,
                    top: 50,
                  ),
                  padding:
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(21),
                    color: AppTheme.lightGray,
                  ),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(21),
                      color: AppTheme.white,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Войти",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontFamily: AppTheme.fontFamily,
                            fontWeight: FontWeight.w600,
                            fontStyle: FontStyle.normal,
                            fontSize: 22,
                            height: 1.38,
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
                        const SizedBox(
                          height: 22,
                        ),
                        GestureDetector(
                          onTap: () async {
                            if (_loginController.text.isEmpty || _passwordController.text.isEmpty) {
                              CenterDialog.simpleCenterDialog(
                                context,
                                "Ошибка",
                                "Логин и пароль не могут быть пустыми!",
                              );
                              return;
                            }

                            setState(() {
                              value = true;
                            });

                            HttpResult result = await repository.setLogin(
                              _loginController.text,
                              _passwordController.text,
                            );

                            setState(() {
                              value = false;
                            });

                            if (result.statusCode == -1) {
                              CenterDialog.simpleCenterDialog(
                                context,
                                "Ошибка",
                                "Проверьте подключение к Интернету!",
                              );
                            } else if (!result.isSuccess) {
                              CenterDialog.simpleCenterDialog(
                                context,
                                "Ошибка",
                                result.result.toString(),
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
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40),
                              color: AppTheme.blue,
                            ),
                            child: !value
                                ? Center(
                              child: Text(
                                "Вход".toUpperCase(),
                                style: const TextStyle(
                                  fontFamily: AppTheme.fontFamily,
                                  fontWeight: FontWeight.normal,
                                  fontStyle: FontStyle.normal,
                                  fontSize: 16,
                                  height: 24 / 16,
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
