import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zikola/core/theming/color_manager.dart';
import 'package:zikola/core/theming/text_style_manager.dart';
import 'package:zikola/features/login/presentation/widgets/build_widget_text_field.dart';

import '../../bussines logic/login_cubit.dart';

class LoginBox extends StatefulWidget {
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
    return Container(
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
        key:formKey ,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("UserName", style: TextStyleManager.font20Bold),
              buildWidgetTextFormField(
                hintText: "Farah Osama",
                controller: _userNameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "please, enter the username";
                  }
                  return null;
                },
              ),
              SizedBox(height: 20.h),
              Text("Password", style: TextStyleManager.font20Bold),
              buildWidgetTextFormField(
                hintText: "password",
                controller: _passwordController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "please, enter the password";
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
                  icon: isObscureText
                      ? Icon(Icons.visibility_off)
                      : Icon(Icons.visibility),
                ),
              ),
              SizedBox(height: 20.h),
              InkWell(
                onTap: () {
                  if(formKey.currentState!.validate()){
                  BlocProvider.of<LoginCubit>(
                    context,
                  ).login(_userNameController.text, _passwordController.text);
                  }
          
                },
                child: Container(
                  width: double.infinity,
                  height: 40.h,
                  padding: EdgeInsets.symmetric(vertical: 7.h),
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
                    "Login",
                    textAlign: TextAlign.center,
                    style: TextStyleManager.font20BoldWhite,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
