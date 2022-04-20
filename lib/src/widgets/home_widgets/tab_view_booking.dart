import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_travelcars_driver/src/model/api_model/history_model.dart';
import 'package:flutter_travelcars_driver/src/theme/app_theme.dart';
import 'package:flutter_travelcars_driver/src/ui/main/tasks/tasks/task_view_screen.dart';
import 'package:flutter_travelcars_driver/src/utils/utils.dart';
import 'package:flutter_travelcars_driver/src/widgets/home_widgets/home_widget.dart';

class TabViewBooking extends StatelessWidget {
  final double h;
  final double w;
  final int size;
  final HistoryModel info;
  final Function(int size) onChange;

  const TabViewBooking({
    Key? key,
    required this.h,
    required this.w,
    required this.size,
    required this.info,
    required this.onChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: info.data1.isEmpty ? 70 * h : 260,
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(21),
            color: AppTheme.white,
            boxShadow: const [
              BoxShadow(
                offset: Offset(0, 0),
                blurRadius: 10,
                color: Color.fromRGBO(0, 0, 0, 0.1),
              ),
            ],
          ),
          child: info.data1.isEmpty
              ? Center(
                  child: Container(
                    margin: const EdgeInsets.only(left: 10),
                    child: RichText(
                      text: const TextSpan(
                        text: "",
                        style: TextStyle(
                          fontFamily: AppTheme.fontFamily,
                          fontWeight: FontWeight.w600,
                          fontStyle: FontStyle.normal,
                          fontSize: 16,
                          height: 1.4,
                          letterSpacing: 0.4,
                          color: AppTheme.black,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: "Пустой",
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              : Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    CarouselSlider(
                        options: CarouselOptions(
                          viewportFraction: 0.94,
                          initialPage: 0,
                          enableInfiniteScroll: true,
                          reverse: false,
                          autoPlay: true,
                          autoPlayInterval: const Duration(seconds: 3),
                          autoPlayAnimationDuration:
                              const Duration(milliseconds: 1000),
                          autoPlayCurve: Curves.fastOutSlowIn,
                          onPageChanged: (i, e) {
                            onChange(i);
                          },
                          scrollDirection: Axis.horizontal,
                        ),
                        items: info.data1.map(
                          (index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => TaskViewScreen(
                                      data: index,
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      index.date,
                                      style: const TextStyle(
                                        fontFamily: AppTheme.fontFamily,
                                        fontWeight: FontWeight.w600,
                                        fontStyle: FontStyle.normal,
                                        fontSize: 18,
                                        height: 1.38,
                                        color: AppTheme.gray,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 12,
                                    ),
                                    Text(
                                      "${index.cityFrom} -\n ${index.cityTo} ${index.reverse == 1 ? "- \n ${index.cityFrom}" : ""}",
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        fontFamily: AppTheme.fontFamily,
                                        fontWeight: FontWeight.w700,
                                        fontStyle: FontStyle.normal,
                                        fontSize: 20,
                                        height: 1.38,
                                        color: AppTheme.black36,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 13,
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10,
                                        vertical: 3,
                                      ),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFF6E01B),
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: Text(
                                        "${index.car}  ${Utils.getCarNumber(index.carNumber)}",
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          fontFamily: AppTheme.fontFamily,
                                          fontWeight: FontWeight.w400,
                                          fontStyle: FontStyle.normal,
                                          fontSize: 14,
                                          height: 1.38,
                                          letterSpacing: 0.4,
                                          color: AppTheme.black36,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ).toList()),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        for (int i = 0; i < info.data1.length; i++)
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 250),
                            curve: Curves.bounceInOut,
                            height: size == i ? 12 : 8,
                            width: size == i ? 12 : 8,
                            margin: const EdgeInsets.symmetric(horizontal: 2),
                            decoration: BoxDecoration(
                              color: AppTheme.blue,
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
        ),
        const SizedBox(
          height: 18,
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          //height: 300,
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(21),
            color: AppTheme.lightGray,
          ),
          child: info.data.isEmpty
              ? const Center(
                  child: Text("Пустой"),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Активные заявки",
                      style: TextStyle(
                        fontFamily: AppTheme.fontFamily,
                        fontWeight: FontWeight.w600,
                        fontStyle: FontStyle.normal,
                        fontSize: 18,
                        height: 1.4,
                        letterSpacing: 0.2,
                        color: AppTheme.black,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 150 * h,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: info.data.length,
                        itemBuilder: (_, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => TaskViewScreen(
                                    data: info.data[index],
                                  ),
                                ),
                              );
                            },
                            child: getHomeTasks(
                              context,
                              info.data[index].date,
                              "${info.data[index].cityFrom}- \n${info.data[index].cityTo} "
                              "${info.data[index].reverse == 1 ? "- \n ${info.data[index].cityFrom}" : ""}",
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
        ),
      ],
    );
  }
}
