import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zikola/core/theming/color_manager.dart';
import 'package:zikola/core/theming/text_style_manager.dart';

import '../widgets/filter_widget.dart';

class OrderHistoryScreen extends StatefulWidget {
  const OrderHistoryScreen({super.key});
  @override
  State<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Order History", style: TextStyleManager.font24Bold),
                  Icon(Icons.calendar_month, size: 40),
                ],
              ),
              Text(
                "Your past orders",
                style: TextStyleManager.font20RegularGrey,
              ),
              SizedBox(height: 20.h),
              Row(
                children: [
                  Icon(
                    Icons.filter_alt_outlined,
                    size: 40,
                    color: ColorManager.greyColor,
                  ),
                  CustomDropdownExample(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
