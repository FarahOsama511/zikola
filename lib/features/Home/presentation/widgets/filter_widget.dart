import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zikola_office/features/Home/data/models/orders_model.dart';

import '../../../../core/theming/color_manager.dart';
import '../../business logic/cubit/cubit/my_orders_cubit.dart';

class CustomDropdownExample extends StatefulWidget {
  const CustomDropdownExample({super.key});

  @override
  State<CustomDropdownExample> createState() => _CustomDropdownExampleState();
}

class _CustomDropdownExampleState extends State<CustomDropdownExample> {
  String selectedValue = "كل الوقت";

  final List<DropdownMenuItem<String>> items = [
    DropdownMenuItem(value: "كل الوقت", child: Text("كل الوقت")),
    DropdownMenuItem(value: "اليوم", child: Text("اليوم")),
    DropdownMenuItem(value: "هذا الأسبوع", child: Text("هذا الأسبوع")),
    DropdownMenuItem(value: "هذا الشهر", child: Text("هذا الشهر")),
  ];

  List<OrdersModel> filterByTime(String timeFrame) {
    final completedOrders = context.read<GetMyOrdersCubit>().completedOrder;
    if (timeFrame == "اليوم") {
      return completedOrders.where((order) {
        final orderDate = order.createdAt;
        final now = DateTime.now();
        return orderDate!.year == now.year &&
            orderDate.month == now.month &&
            orderDate.day == now.day;
      }).toList();
    } else if (timeFrame == "هذا الأسبوع") {
      return completedOrders.where((order) {
        final orderDate = order.createdAt;
        final now = DateTime.now();
        final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
        final endOfWeek = startOfWeek.add(Duration(days: 6));
        return orderDate!.isAfter(startOfWeek.subtract(Duration(days: 1))) &&
            orderDate.isBefore(endOfWeek.add(Duration(days: 1)));
      }).toList();
    } else if (timeFrame == "هذا الشهر") {
      return completedOrders.where((order) {
        final orderDate = order.createdAt;
        final now = DateTime.now();
        return orderDate!.year == now.year && orderDate.month == now.month;
      }).toList();
    } else {
      return completedOrders;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250.w,
      child: DropdownButtonHideUnderline(
        child: DropdownButtonFormField<String>(
          initialValue: "اليوم",
          dropdownColor: Colors.white,
          decoration: InputDecoration(
            filled: true,
            focusColor: ColorManager.lightGrey,
            enabled: false,

            contentPadding: EdgeInsets.symmetric(
              horizontal: 12.w,
              vertical: 8.h,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.r),
              borderSide: BorderSide(color: ColorManager.orangeColor),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.r),
              borderSide: BorderSide(color: ColorManager.lightGrey),
            ),
          ),
          items: items,
          onChanged: (value) {
            setState(() {
              filterByTime(value!);
              selectedValue = value;
            });
          },
        ),
      ),
    );
  }
}
