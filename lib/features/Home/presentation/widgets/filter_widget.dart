import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zikola/core/theming/color_manager.dart';

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
