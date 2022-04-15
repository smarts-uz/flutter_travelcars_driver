import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_travelcars_driver/src/bloc/history_bloc.dart';
import 'package:flutter_travelcars_driver/src/model/api_model/history_model.dart';
import 'package:flutter_travelcars_driver/src/model/api_model/task_model.dart';
import 'package:flutter_travelcars_driver/src/theme/app_theme.dart';
import 'package:flutter_travelcars_driver/src/utils/utils.dart';
import 'package:flutter_travelcars_driver/src/widgets/home_widgets/data_shimmer.dart';
import 'package:flutter_travelcars_driver/src/widgets/home_widgets/home_widget.dart';
import '../../../bloc/task_bloc.dart';
import '../tasks/tasks/task_view_screen.dart';

class HomeScreen extends StatefulWidget {
  final Function(int id) onChange;

  const HomeScreen({
    Key? key,
    required this.onChange,
  }) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int size = 0;

  @override
  void initState() {
    historyBloc.getAllHistory("active", 1);
    taskBloc.getTasksAll();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // double h = Utils.height(context);
    // double w = Utils.width(context);
    return Scaffold(
      backgroundColor: AppTheme.bgColor,
      body: ListView(
        children: [
          StreamBuilder(
            stream: historyBloc.historyFeedback,
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData && snapshot.data!.data != null) {
                HistoryModel info = snapshot.data!;
                return Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      margin:
                          const EdgeInsets.only(top: 20, left: 10, right: 10),
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
                                CarouselSlider(
                                    options: CarouselOptions(
                                      //height: 265.0 * h,
                                      viewportFraction: 0.94,
                                      //aspectRatio: 16 / 9,
                                      initialPage: 0,
                                      enableInfiniteScroll: true,
                                      reverse: false,
                                      autoPlay: true,
                                      autoPlayInterval:
                                          const Duration(seconds: 3),
                                      autoPlayAnimationDuration:
                                          const Duration(milliseconds: 1000),
                                      autoPlayCurve: Curves.fastOutSlowIn,
                                      onPageChanged: (i, e) {
                                        size = i;
                                        setState(() {});
                                      },
                                      // enlargeCenterPage: true,
                                      scrollDirection: Axis.horizontal,
                                    ),
                                    items: info.data1.map(
                                      (index) {
                                        return GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    TaskViewScreen(
                                                  data: index,
                                                ),
                                              ),
                                            );
                                          },
                                          child: Container(
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  index.date,
                                                  style: const TextStyle(
                                                    fontFamily:
                                                        AppTheme.fontFamily,
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
                                                    fontFamily:
                                                        AppTheme.fontFamily,
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
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                    horizontal: 10,
                                                    vertical: 3,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    color:
                                                        const Color(0xFFF6E01B),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4),
                                                  ),
                                                  child: Text(
                                                    "${index.car}  ${Utils.getCarNumber(index.carNumber)}",
                                                    textAlign: TextAlign.center,
                                                    style: const TextStyle(
                                                      fontFamily:
                                                          AppTheme.fontFamily,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontStyle:
                                                          FontStyle.normal,
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
                                        duration:
                                            const Duration(milliseconds: 250),
                                        curve: Curves.bounceInOut,
                                        height: size == i ? 12 : 8,
                                        width: size == i ? 12 : 8,
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 2),
                                        decoration: BoxDecoration(
                                          color: AppTheme.blue,
                                          borderRadius:
                                              BorderRadius.circular(12),
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
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 10),
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
                                  height: 180,
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 12),
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
                                              builder: (context) =>
                                                  TaskViewScreen(
                                                data: info.data[index],
                                              ),
                                            ),
                                          );
                                        },
                                        child: getHomeTasks(
                                          context,
                                          info.data[index].date,
                                          "${info.data[index].cityFrom}- ${info.data[index].cityTo} ${info.data[index].reverse == 1 ? "- \n ${info.data[index].cityFrom}" : ""}",
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
              } else {
                return const DataShimmer();
              }
            },
          ),
          const SizedBox(
            height: 20,
          ),
          StreamBuilder(
            stream: taskBloc.taskFeedback,
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                TaskModel tasks = snapshot.data!;
                return Container(
                  width: MediaQuery.of(context).size.width,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(21),
                    color: AppTheme.lightGray,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Основные разделы",
                        style: TextStyle(
                          fontFamily: AppTheme.fontFamily,
                          fontWeight: FontWeight.w600,
                          fontStyle: FontStyle.normal,
                          fontSize: 20,
                          height: 1.4,
                          letterSpacing: 0.4,
                          color: AppTheme.black,
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      getContainer(
                        context,
                        "Всего заявок обработано: ",
                        tasks.data.done,
                        AppTheme.blue,
                        (on) {
                          widget.onChange(0);
                        },
                      ),
                      getContainer(
                        context,
                        "Активные текущие заявки: ",
                        tasks.data.active,
                        AppTheme.green,
                        (onChange) {
                          widget.onChange(1);
                        },
                      ),
                    ],
                  ),
                );
              } else {
                return const DataShimmer();
              }
            },
          ),
          const SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}
