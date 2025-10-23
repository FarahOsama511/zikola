import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zikola/core/theming/color_manager.dart';
import 'package:zikola/core/theming/text_style_manager.dart';

class BuildWidgetTextFormField extends StatelessWidget {
  final String hintText;
  final bool? isObscureText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final TextEditingController controller;
  final Function(String?)? validator;
  Function(String)? onChanged;
  BuildWidgetTextFormField({
    super.key,
    required this.hintText,
    required this.controller,
    this.isObscureText,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      child: TextFormField(
        style: TextStyleManager.font15RegularBlack,
        controller: controller,
        obscureText: isObscureText ?? false,
        onChanged: onChanged,
        cursorColor: ColorManager.secondColor,
        cursorWidth: 1,
        cursorHeight: 20,
        decoration: InputDecoration(
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          hintText: hintText,
          hintStyle: TextStyleManager.font15RegularGrey,
          isDense: true,
          contentPadding: EdgeInsets.symmetric(
            vertical: 12.h,
            horizontal: 12.w,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(13.r),
            borderSide: BorderSide(
              style: BorderStyle.solid,
              color: ColorManager.orangeColor,
              width: 2,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(13.r),
            borderSide: BorderSide(color: ColorManager.lightGrey),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(13.r),
            borderSide: BorderSide(color: Colors.red),
          ),

          filled: true,
          fillColor: Color.fromARGB(255, 238, 235, 235),
        ),
        validator: (value) {
          return validator!(value);
        },
      ),
    );
  }
}
