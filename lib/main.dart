import 'dart:developer';
import 'package:flutter/material.dart';
import 'core/constants/strings.dart';
import 'core/get_it.dart' as di;
import 'core/helpers/sharedpref_helper.dart';
import 'core/routing/route.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await di.init();
  await SharedprefHelper.cacheInitialization();

  savedToken = await SharedprefHelper.getSecurityString("token");
  role = SharedprefHelper.getData("role");

  log(savedToken ?? "");
  log(role ?? "");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      builder: (context, child) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routerConfig: router,

          locale: const Locale('ar'),
          supportedLocales: const [Locale('ar'), Locale('en')],

          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],

          localeResolutionCallback: (locale, supportedLocales) {
            if (locale == null) return const Locale('ar');
            for (var supportedLocale in supportedLocales) {
              if (supportedLocale.languageCode == locale.languageCode) {
                return supportedLocale;
              }
            }
            return const Locale('ar');
          },
        );
      },
    );
  }
}
