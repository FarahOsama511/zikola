import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theming/text_style_manager.dart';
import '../widgets/build_bloc_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(14.r, 80.r, 14.r, 14.r),
              child: Column(
                children: [
                  // شعار التطبيق
                  Center(
                    child: Container(
                      height: 90.h,
                      width: 100.w,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 9,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20.r),
                        child: Image.asset(
                          "assets/images/logo.jpg",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 20.h),

                  // عنوان التطبيق
                  Text(
                    "قهوة المكتب ☕",
                    style: TextStyleManager.font20RegularBlack,
                  ),

                  SizedBox(height: 10.h),

                  // وصف بسيط
                  Text(
                    "اطلب مشروبك المفضل بسهولة",
                    style: TextStyleManager.font20RegularGrey,
                  ),

                  SizedBox(height: 20.h),

                  SizedBox(
                    height: 130.h,
                    width: double.infinity,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.r),
                      child: Image.asset(
                        "assets/images/drinks.jpg",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  SizedBox(height: 20.h),
                  buildBlocWidget(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
