import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/strings.dart';
import '../../../../core/cubit/theme_app_cubit.dart';
import '../../../../core/theming/color_manager.dart';
import '../../../../core/theming/text_style_manager.dart';

class SettingsCard extends StatefulWidget {
  const SettingsCard({super.key});
  @override
  State<SettingsCard> createState() => _SettingsCardState();
}

class _SettingsCardState extends State<SettingsCard> {
  @override
  void initState() {
    final currentTheme = context.read<ThemeAppCubit>().currentTheme;
    isDark = currentTheme == AppTheme.dark;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    logger.d(isDark);
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
                  icon: Icon(isDark ? Icons.dark_mode : Icons.sunny, size: 35),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      isDark ? "الوضع الليلي" : "الوضع النهاري",
                      style: TextStyleManager.font15Bold,
                    ),
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
                      isDark = value;
                    });
                    final newTheme = isDark ? AppTheme.dark : AppTheme.light;
                    context.read<ThemeAppCubit>().selectAppTheme(newTheme);
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
