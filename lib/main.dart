import 'dart:developer';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zikola/core/cubit/theme_app_cubit.dart';
import 'package:zikola/core/cubit/theme_app_state.dart';
import 'package:zikola/firebase_options.dart';
import 'core/constants/strings.dart';
import 'core/get_it.dart' as di;
import 'core/helpers/sharedpref_helper.dart';
import 'core/routing/route.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'push_notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  PushNotificationService.init();
  await SharedprefHelper.cacheInitialization();
  savedToken = await SharedprefHelper.getSecurityString("token");
  role = SharedprefHelper.getData("role");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      builder: (context, child) {
        return BlocProvider(
          create: (context) => ThemeAppCubit(),
          child: BlocBuilder<ThemeAppCubit, ThemeAppState>(
            builder: (context, state) {
              return MaterialApp.router(
                themeMode: context.read<ThemeAppCubit>().getTheme,
                theme: isDark ? ThemeData.dark() : ThemeData.light(),
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
          ),
        );
      },
    );
  }
}
