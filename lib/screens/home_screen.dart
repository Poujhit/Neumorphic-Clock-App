import 'package:flutter/material.dart';
import 'package:neumorphic_clock_app/screens/clock_screen.dart';
import 'package:neumorphic_clock_app/screens/stop_watch_screen.dart';
import 'package:neumorphic_clock_app/screens/timer_screen.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class HomeScreen extends StatelessWidget {
  final PersistentTabController _controller = PersistentTabController(initialIndex: 0);

  List<Widget> _buildScreens() {
    return [
      ClockScreen(),
      StopWatchScreen(),
      TimerScreen(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(Icons.alarm, color: Colors.black54),
        title: ("Alarm Clock"),
        activeColor: Color(0xFF707070),
        inactiveColor: Color(0xFFb9abab),
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.watch, color: Colors.black45),
        title: ("StopWatch"),
        activeColor: Color(0xFF707070),
        inactiveColor: Color(0xFF707070),
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.timer, color: Colors.black45),
        title: ("Timer"),
        activeColor: Color(0xFF707070),
        inactiveColor: Color(0xFF707070),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      navBarHeight: 80,
      backgroundColor: Color(0xFFb9abab),
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
      stateManagement: true,
      neumorphicProperties: NeumorphicProperties(
        bevel: 15,
        curveType: CurveType.concave,
      ),
      hideNavigationBarWhenKeyboardShows: true,
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Color(0xFFb9abab),
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      padding: NavBarPadding.only(bottom: 15),
      itemAnimationProperties: ItemAnimationProperties(
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: ScreenTransitionAnimation(
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle: NavBarStyle.neumorphic,
    );
  }
}
