import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theming/color_manager.dart';
import '../../../../core/theming/text_style_manager.dart';

class SettingsCard extends StatefulWidget {
  const SettingsCard({super.key});

  @override
  State<SettingsCard> createState() => _SettingsCardState();
}

bool isDark = false;

class _SettingsCardState extends State<SettingsCard> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 160,
      right: 20,
      left: 20,
      child: Container(
        height: 130.h,
        padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 9,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.sunny, size: 35),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("الوضع الداكن", style: TextStyleManager.font15Bold),
                    Text(
                      isDark ? "مفعل" : "غير مفعل",
                      style: TextStyleManager.font15Bold.copyWith(
                        color: ColorManager.greyColor,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Switch(
                  inactiveThumbColor: Colors.white,
                  activeThumbColor: ColorManager.orangeColor,
                  inactiveTrackColor: ColorManager.lightGrey,
                  value: isDark,
                  onChanged: (value) {
                    setState(() {
                      isDark = !isDark;
                    });
                  },
                ),
              ],
            ),
            const Divider(),
            Row(
              children: [
                Expanded(
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.lock, size: 35),
                  ),
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "تغيير كلمة المرور",
                      style: TextStyleManager.font15Bold,
                    ),
                    Text(
                      "قم بتحديث كلمة المرور الخاصة بك",
                      style: TextStyleManager.font15Bold.copyWith(
                        color: ColorManager.greyColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
