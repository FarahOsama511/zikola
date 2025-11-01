import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theming/color_manager.dart';
import '../screens/home_screen.dart';
import '../screens/order_history_screen.dart';
import '../screens/profile_screen.dart';
import '../screens/status_order_screen.dart';

class BottomNavigation extends StatefulWidget {
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int currentindex = 0;
  List<Widget> pages = [
    HomeScreen(),
    StatusOrderScreen(),
    OrderHistoryScreen(),
    ProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: currentindex, children: pages),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
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
            label: "الرئيسية",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment, size: 30),
            label: "الطلبات",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history, size: 30),
            label: "السجل",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, size: 30),
            label: "الملف الشخصي",
          ),
        ],
      ),
    );
  }
}
