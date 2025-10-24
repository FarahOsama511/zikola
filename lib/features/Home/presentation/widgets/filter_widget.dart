import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zikola/core/theming/color_manager.dart';

class CustomDropdownExample extends StatefulWidget {
  const CustomDropdownExample({super.key});

  @override
  State<CustomDropdownExample> createState() => _CustomDropdownExampleState();
}

class _CustomDropdownExampleState extends State<CustomDropdownExample> {
  String selectedValue = "All Time";

  final List<DropdownMenuItem<String>> items = [
    DropdownMenuItem(value: "All Time", child: Text("All Time")),
    DropdownMenuItem(value: "Today", child: Text("Today")),
    DropdownMenuItem(value: "This Week", child: Text("This Week")),
    DropdownMenuItem(value: "This Month", child: Text("This Month")),
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250.w,
      child: DropdownButtonHideUnderline(
        child: DropdownButtonFormField<String>(
          initialValue: "Today",
          dropdownColor: Colors.white,
          decoration: InputDecoration(
            filled: true,
            focusColor: ColorManager.lightGrey,
            enabled: false,

            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 10,
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
              selectedValue = value!;
            });
          },
        ),
      ),
    );
  }
}
