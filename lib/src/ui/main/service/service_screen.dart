import 'package:flutter/material.dart';
import 'package:flutter_travelcars_driver/src/bloc/course_bloc.dart';
import 'package:flutter_travelcars_driver/src/bloc/weather_bloc.dart';
import 'package:flutter_travelcars_driver/src/model/api_model/course_model.dart';
import 'package:flutter_travelcars_driver/src/model/api_model/weather_model.dart';
import 'package:flutter_travelcars_driver/src/theme/app_theme.dart';
import 'package:flutter_travelcars_driver/src/utils/utils.dart';
import 'package:flutter_travelcars_driver/src/widgets/course_widget.dart';
import 'package:flutter_travelcars_driver/src/widgets/service_widgets/service_shimmer.dart';
import 'package:flutter_travelcars_driver/src/widgets/weather_widget.dart';

class ServiceScreen extends StatefulWidget {
  const ServiceScreen({Key? key}) : super(key: key);

  @override
  _ServiceScreenState createState() => _ServiceScreenState();
}

class _ServiceScreenState extends State<ServiceScreen> {
  @override
  void initState() {
    courseBloc.getAllCourse();
    weatherBloc.getWeather();
    super.initState();
  }

  @override
  void dispose() {
    courseBloc.dispose();
    weatherBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double h = Utils.height(context);
    double w = Utils.width(context);
    return Scaffold(
      backgroundColor: AppTheme.bgColor,
      body: ListView(
        children: [
          StreamBuilder(
            stream: courseBloc.courseFeedback,
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                List<CourseModel> data = snapshot.data!;
                return CourseWidget(
                  h: h,
                  w: w,
                  data: data,
                );
              } else {
                return const ServiceShimmer();
              }
            },
          ),
          StreamBuilder(
            stream: weatherBloc.weatherFeedBack,
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                WeatherModel info = snapshot.data!;
                return WeatherWidget(
                  h: h,
                  w: w,
                  info: info,
                );
              } else {
                return const ServiceShimmer();
              }
            },
          ),
        ],
      ),
    );
  }
}
