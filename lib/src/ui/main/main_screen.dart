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

    // FirebaseMessaging.onMessage.listen(
    //   (RemoteMessage message) {},
    // );
    // FirebaseMessaging.onMessageOpenedApp.listen(
    //   (RemoteMessage message) async {
    //     if (message.notification!.body != null) {
    //       await Navigator.push(
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
  }

  @override
  Widget build(BuildContext context) {
    double h = Utils.height(context);
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
                text[_bottomNavIndex],
                style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 22 * h,
                    height: 26 / 22 * h,
                    color: AppTheme.white),
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
                height: 24,
                width: 24,
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
        activeIndex: _bottomNavIndex,
        splashColor: AppTheme.blue,
        notchAndCornersAnimation: animation,
        splashSpeedInMilliseconds: 300,
        notchSmoothness: NotchSmoothness.defaultEdge,
        gapLocation: GapLocation.center,
        leftCornerRadius: 32,
        rightCornerRadius: 32,
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

class NavigationScreen extends StatefulWidget {
  final IconData iconData;

  const NavigationScreen({
    Key? key,
    required this.iconData,
  }) : super(key: key);

  @override
  _NavigationScreenState createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> animation;

  @override
  void didUpdateWidget(NavigationScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.iconData != widget.iconData) {
      _startAnimation();
    }
  }

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );
    _controller.forward();
    super.initState();
  }

  _startAnimation() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.white,
      child: Center(
        child: CircularRevealAnimation(
          animation: animation,
          centerOffset: const Offset(80, 80),
          maxRadius: MediaQuery.of(context).size.longestSide * 1.1,
          child: Icon(
            widget.iconData,
            color: Colors.transparent,
            size: 160,
          ),
        ),
      ),
    );
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
