import 'package:flutter/material.dart';
import 'package:flutter_travelcars_driver/src/model/api_model/course_model.dart';
import 'package:flutter_travelcars_driver/src/theme/app_theme.dart';
import 'package:flutter_travelcars_driver/src/widgets/utils_widgets.dart';

class CourseWidget extends StatelessWidget {
  final double h;
  final double w;
  final List<CourseModel> data;

  const CourseWidget({
    Key? key,
    required this.h,
    required this.w,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("date nbu course $data");
    print("h nbu course $h");
    print("w nbu course $w");
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(horizontal: 8 * w, vertical: 16 * h),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(21 * h),
        color: AppTheme.lightGray,
      ),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(21),
          color: AppTheme.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Курсы валют",
              style: TextStyle(
                fontFamily: AppTheme.fontFamily,
                fontWeight: FontWeight.w600,
                fontStyle: FontStyle.normal,
                fontSize: 18 * h,
                height: 1.3 * h,
                letterSpacing: 0.2,
                color: AppTheme.black,
              ),
            ),
            SizedBox(
              height: 8 * h,
            ),
            for (int i = 0; i < 3; i++)
              for (int j = 0; j < data.length; j++)
                        (
                        data[j].code == "USD" && i == 0 ||
                        data[j].code == "EUR" && i == 1 ||
                        data[j].code == "RUB" && i == 2
                        )
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          height: 40 * h,
                                          width: 40 * h,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(24),
                                            color: data[j].code == "USD"
                                                ? const Color(0xff454563)
                                                : data[j].code == "EUR"
                                                    ? const Color(0xffBE1AF7)
                                                    : const Color(0xff1276A7),
                                          ),
                                          child: Center(
                                            child: Text(
                                              data[j].code == "USD"
                                                  ? "\$"
                                                  : data[j].code == "EUR"
                                                      ? "€"
                                                      : "P",
                                              style: TextStyle(
                                                fontFamily: AppTheme.fontFamily,
                                                fontWeight: FontWeight.w600,
                                                fontStyle: FontStyle.normal,
                                                fontSize: 28 * h,
                                                letterSpacing: 0.7,
                                                color: AppTheme.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 12,
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              data[j].title,
                                              style: TextStyle(
                                                fontFamily: AppTheme.fontFamily,
                                                fontWeight: FontWeight.normal,
                                                fontStyle: FontStyle.normal,
                                                fontSize: 14,
                                                height: 1.5 * h,
                                                letterSpacing: 0.3,
                                                color: AppTheme.black,
                                              ),
                                            ),
                                            Text(
                                              data[j].code,
                                              style: TextStyle(
                                                fontFamily: AppTheme.fontFamily,
                                                fontWeight: FontWeight.normal,
                                                fontStyle: FontStyle.normal,
                                                fontSize: 14 * h,
                                                height: 1.5 * h,
                                                letterSpacing: 0.3,
                                                color: AppTheme.black,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                
                              ),
                              
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    data[j].cbPrice,
                                    style: TextStyle(
                                      fontFamily: AppTheme.fontFamily,
                                      fontWeight: FontWeight.normal,
                                      fontStyle: FontStyle.normal,
                                      fontSize: 14 * h,
                                      height: 1.5 * h,
                                      letterSpacing: 0.3,
                                      color: AppTheme.black,
                                    ),
                                  ),
                                  Text(
                                    data[j].date,
                                    style: TextStyle(
                                      fontFamily: AppTheme.fontFamily,
                                      fontWeight: FontWeight.normal,
                                      fontStyle: FontStyle.normal,
                                      fontSize: 10 * h,
                                      height: 1.5 * h,
                                      letterSpacing: 0.3,
                                      color: AppTheme.green,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 0 * h,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "ПОКУПКА: ${data[j].nbuBuyPrice}",
                                  style: TextStyle(
                                    fontFamily: AppTheme.fontFamily,
                                    fontWeight: FontWeight.normal,
                                    fontStyle: FontStyle.normal,
                                    fontSize: 10 * h,
                                    height: 15 / 12 * h,
                                    //letterSpacing: 0.3,
                                    color: AppTheme.black,
                                  ),
                                ),
                              ),
                              Text(
                                "ПРОДАЖА: ${data[j].nbuCellPrice}",
                                style: TextStyle(
                                  fontFamily: AppTheme.fontFamily,
                                  fontWeight: FontWeight.normal,
                                  fontStyle: FontStyle.normal,
                                  fontSize: 10 * h,
                                  height: 15 / 12 * h,
                                  //letterSpacing: 0.3,
                                  color: AppTheme.black,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10 * h,
                          ),
                          i != 2 ? const MySeparator() : Container(),
                          SizedBox(
                            height: 6 * h,
                          ),
                        ],
                      )
                    : Container(),
          ],
        ),
      ),
    );
  }
}
