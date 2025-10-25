import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'core/helpers/sharedpref_helper.dart';
import 'core/routing/route.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

var logger = Logger();
String? savedToken;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  savedToken = await SharedprefHelper.getSecurityString("token");
  log(savedToken ?? "");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      builder: (_, child) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routerConfig: router,
        );
      },
    );
  }
}
