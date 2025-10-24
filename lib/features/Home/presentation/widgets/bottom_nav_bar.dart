import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zikola/core/theming/color_manager.dart';
import 'package:zikola/features/Home/presentation/screens/home_screen.dart';
import 'package:zikola/features/Home/presentation/screens/order_history_screen.dart';
import 'package:zikola/features/Home/presentation/screens/status_order_screen.dart';

class BottomNavigation extends StatefulWidget {
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int currentindex = 0;
  List<Widget> pages = [
    HomeScreen(),
    StatusOrderScreen(),
    OrderHistoryScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: currentindex, children: pages),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: ColorManager.orangeColor,
        unselectedItemColor: ColorManager.greyColor,
        selectedFontSize: 15.sp,
        unselectedFontSize: 15.sp,

        currentIndex: currentindex,
        onTap: (value) {
          setState(() {
            currentindex = value;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined, size: 30),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment, size: 30),
            label: "Status",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history, size: 30),
            label: "History",
          ),
        ],
      ),
    );
  }
}
