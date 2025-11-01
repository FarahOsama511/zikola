import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theming/color_manager.dart';
import '../../../../core/theming/text_style_manager.dart';
import '../../bussines logic/login_cubit.dart';
import 'build_widget_text_field.dart';

class LoginBox extends StatefulWidget {
  const LoginBox({super.key});

  @override
  State<LoginBox> createState() => _LoginBoxState();
}

class _LoginBoxState extends State<LoginBox> {
  bool isObscureText = true;
  final formKey = GlobalKey<FormState>();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _passwordController.dispose();
    _userNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        padding: EdgeInsets.all(20),
        height: 260.h,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(color: ColorManager.lightGrey),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 9,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("اسم المستخدم", style: TextStyleManager.font20Bold),
                buildWidgetTextFormField(
                  hintText: "اكتب اسم المستخدم",
                  controller: _userNameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "من فضلك أدخل اسم المستخدم";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20.h),

                Text("كلمة المرور", style: TextStyleManager.font20Bold),
                buildWidgetTextFormField(
                  hintText: "أدخل كلمة المرور",
                  controller: _passwordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "من فضلك أدخل كلمة المرور";
                    }
                    return null;
                  },
                  isObscureText: isObscureText,

                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        isObscureText = !isObscureText;
                      });
                    },
                    icon: Icon(
                      isObscureText ? Icons.visibility_off : Icons.visibility,
                      color: ColorManager.greyColor,
                    ),
                  ),
                ),

                SizedBox(height: 20.h),

                InkWell(
                  onTap: () {
                    if (formKey.currentState!.validate()) {
                      BlocProvider.of<LoginCubit>(context).login(
                        _userNameController.text,
                        _passwordController.text,
                      );
                    }
                  },
                  child: Container(
                    width: double.infinity,
                    height: 45.h,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      color: ColorManager.orangeColor,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 9,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Text(
                      "تسجيل الدخول",
                      style: TextStyleManager.font20BoldWhite,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
