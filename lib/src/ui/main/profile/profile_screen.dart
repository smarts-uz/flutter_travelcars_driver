import 'package:flutter/material.dart';
import 'package:flutter_travelcars_driver/src/api/repository.dart';
import 'package:flutter_travelcars_driver/src/bloc/data_bloc.dart';
import 'package:flutter_travelcars_driver/src/model/api_model/profile_model.dart';
import 'package:flutter_travelcars_driver/src/theme/app_theme.dart';
import 'package:flutter_travelcars_driver/src/utils/center_dialog/center_dialog.dart';
import 'package:flutter_travelcars_driver/src/utils/utils.dart';
import 'package:flutter_travelcars_driver/src/widgets/change_password_widget.dart';
import 'package:flutter_travelcars_driver/src/widgets/logout_button.dart';
import 'package:flutter_travelcars_driver/src/widgets/profile_info_widget.dart';
import 'package:flutter_travelcars_driver/src/widgets/profile_widget.dart';
import 'package:flutter_travelcars_driver/src/widgets/service_widgets/service_shimmer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _pass1Controller = TextEditingController();
  final TextEditingController _pass2Controller = TextEditingController();
  final TextEditingController _pass3Controller = TextEditingController();
  final TextEditingController _pin0Controller = TextEditingController();
  final TextEditingController _pin1Controller = TextEditingController();
  final TextEditingController _pin2Controller = TextEditingController();
  Repository repository = Repository();
  ProfileModel? data;
  bool value = false;
  bool circle = false;
  bool one = false;

  @override
  void initState() {
    super.initState();
    get();
    dataBloc.getProfileData();
  }

  get() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String k = prefs.getString("pin") ?? "";
    one = k.isNotEmpty;
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
    dataBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double h = Utils.height(context);
    double w = Utils.width(context);
    return Scaffold(
      backgroundColor: AppTheme.bgColor,
      body: ListView(
        children: [
          SizedBox(
            height: 280 * h,
            child: StreamBuilder(
              stream: dataBloc.profileFeedback,
              builder: (context, AsyncSnapshot<ProfileModel> snapshot) {
                if (snapshot.hasData) {
                  data = snapshot.data!;
                  return ProfileInfoWidget(
                    h: h,
                    w: w,
                    data: data!,
                  );
                } else if (data != null) {
                  return ProfileInfoWidget(
                    h: h,
                    w: w,
                    data: data!,
                  );
                } else {
                  return const ServiceShimmer();
                }
              },
            ),
          ),
          ChangePasswordWidget(
              h: h,
              w: w,
              pass1Controller: _pass1Controller,
              pass2Controller: _pass2Controller,
              pass3Controller: _pass3Controller,
              repository: repository,
              circle: circle,
              onChange: (onChange) {
                setState(() {
                  circle = onChange;
                });
              }),
          SizedBox(
            height: 40 * h,
          ),
          LogoutButton(
            h: h,
            w: w,
            repository: repository,
          ),
          SizedBox(
            height: 40 * h,
          ),
        ],
      ),
    );
  }
}
