import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:circular_reveal_animation/circular_reveal_animation.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_travelcars_driver/src/theme/app_theme.dart';
import 'package:flutter_travelcars_driver/src/ui/main/calendar/calendar_screen.dart';
import 'package:flutter_travelcars_driver/src/ui/main/home/home_screen.dart';
import 'package:flutter_travelcars_driver/src/ui/main/profile/profile_screen.dart';
import 'package:flutter_travelcars_driver/src/ui/main/service/service_screen.dart';
import 'package:flutter_travelcars_driver/src/ui/main/tasks/task_screen.dart';
import 'package:flutter_travelcars_driver/src/ui/main/tasks/tasks/online_task_view_screen.dart';
import 'package:flutter_travelcars_driver/src/utils/utils.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  final PageController _pageController =
      PageController(initialPage: 0, keepPage: true);
  final autoSizeGroup = AutoSizeGroup();
  int _bottomNavIndex = 0;
  int taskIndex = 0;
  late AnimationController _animationController;
  late Animation<double> animation;
  late CurvedAnimation curve;
  List<String> text = [
    "Текущая поездка",
    "ИНФОРМАЦИЯ",
    "График работы",
    "Профиль водителя",
    "ЗАЯВКИ",
  ];
  final iconList = <String>[
    "assets/icons/home.svg",
    "assets/icons/info_svg.svg",
    "assets/icons/calendar.svg",
    "assets/icons/user.svg",
  ];

  @override
  void initState() {
    super.initState();
    final systemTheme = SystemUiOverlayStyle.light.copyWith(
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.light,
    );
    SystemChrome.setSystemUIOverlayStyle(systemTheme);

    _animationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    curve = CurvedAnimation(
      parent: _animationController,
      curve: const Interval(
        0.5,
        1.0,
        curve: Curves.fastOutSlowIn,
      ),
    );
    animation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(curve);

    Future.delayed(
      const Duration(seconds: 1),
      () => _animationController.forward(),
    );

    get();
  }

  get() async {
    // FirebaseMessaging.instance.getInitialMessage().then(
    //   (RemoteMessage? message) {
    //     if (message != null) {
    //       Navigator.push(
    //         context,
    //         MaterialPageRoute(
    //           builder: (context) => OnlineTaskViewScreen(
    //             id: message.data["id"],
    //           ),
    //         ),
    //       );
    //     }
    //   },
    // );

    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) {},
    );

    FirebaseMessaging.onBackgroundMessage(
      (message) async {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OnlineTaskViewScreen(
              id: message.data["id"],
            ),
          ),
        );
      },
    );
    FirebaseMessaging.onMessageOpenedApp.listen(
      (RemoteMessage message) async {
        if (message.notification!.body != null) {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OnlineTaskViewScreen(
                id: message.data["id"],
              ),
            ),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double h = Utils.height(context);
    double w = Utils.width(context);
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
                text[_bottomNavIndex].toUpperCase(),
                style: TextStyle(
                  fontFamily: AppTheme.fontFamily,
                  fontWeight: FontWeight.normal,
                  fontSize: 18 * h,
                  height: 22 / 18 * h,
                  color: AppTheme.white,
                ),
              ),
            ),
          ),
          Expanded(
            child: PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                HomeScreen(
                  onChange: (int id) {
                    taskIndex = id;
                    bottomTapped(4);
                  },
                ),
                const ServiceScreen(),
                const CalendarScreen(),
                const ProfileScreen(),
                TaskScreen(
                  index: taskIndex,
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: ScaleTransition(
        scale: animation,
        child: FloatingActionButton(
          elevation: 8,
          backgroundColor:
              (_bottomNavIndex == 4) ? AppTheme.white : AppTheme.green,
          child: Icon(
            Icons.location_on,
            color: (_bottomNavIndex == 4) ? AppTheme.blue : AppTheme.white,
          ),
          onPressed: () {
            bottomTapped(4);
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar.builder(
        itemCount: iconList.length,
        tabBuilder: (int index, bool isActive) {
          final color = isActive ? AppTheme.blue : AppTheme.grey;
          return Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 24 * h,
                width: 24 * w,
                child: SvgPicture.asset(
                  iconList[index],
                  color: color,
                ),
              ),
            ],
          );
        },
        backgroundColor: AppTheme.white,
        elevation: 10,
        height: 50 * h,
        activeIndex: _bottomNavIndex,
        splashColor: AppTheme.blue,
        notchAndCornersAnimation: animation,
        splashSpeedInMilliseconds: 300,
        notchSmoothness: NotchSmoothness.defaultEdge,
        gapLocation: GapLocation.center,
        leftCornerRadius: 32 * h,
        rightCornerRadius: 32 * h,
        onTap: (index) {
          bottomTapped(index);
        },
      ),
    );
  }

  bottomTapped(int index) {
    _bottomNavIndex = index;
    _pageController.jumpToPage(index);

    FocusScope.of(context).requestFocus(FocusNode());
    setState(() {});
  }
}

class HexColor extends Color {
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF' + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }
}
