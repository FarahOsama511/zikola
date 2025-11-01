import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'color_manager.dart';

class TextStyleManager {
  TextStyleManager._();
  static TextStyle font24Thin = TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeight.w100,
    color: ColorManager.secondColor,
  );
  static TextStyle font24Extralight = TextStyle(
    fontSize: 24.sp,
    fontWeight: FontWeight.w200,
    color: ColorManager.secondColor,
  );
  static TextStyle font24Light = TextStyle(
    fontSize: 24.sp,
    fontWeight: FontWeight.w300,
    color: ColorManager.secondColor,
  );
  static TextStyle font20RegularGrey = TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeight.w400,
    color: ColorManager.greyColor,
  );
  static TextStyle font15RegularGrey = TextStyle(
    fontSize: 15.sp,
    fontWeight: FontWeight.w400,
    color: ColorManager.greyColor,
  );
  static TextStyle font20RegularBlack = TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeight.w400,
    color: ColorManager.secondColor,
  );
  static TextStyle font15RegularBlack = TextStyle(
    fontSize: 15.sp,
    fontWeight: FontWeight.w400,
    color: ColorManager.secondColor,
  );
  static TextStyle font20Bold = TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeight.bold,
    color: ColorManager.secondColor,
  );
  static TextStyle font15Bold = TextStyle(
    fontSize: 15.sp,
    fontWeight: FontWeight.bold,
    color: ColorManager.secondColor,
  );
  static TextStyle font24Bold = TextStyle(
    fontSize: 24.sp,
    fontWeight: FontWeight.bold,
    color: ColorManager.secondColor,
  );
  static TextStyle font20BoldWhite = TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );
  static TextStyle font16BoldWhite = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );
}
