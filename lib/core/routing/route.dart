import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:zikola/features/Home/business%20logic/cubit/item_cubit.dart';
import 'package:zikola/features/Home/data/repositiries/item_repo.dart';
import 'package:zikola/features/Home/data/webservices/item_webservice.dart';
import 'package:zikola/features/Home/presentation/screens/home_screen.dart';
import 'package:zikola/main.dart';
import '../../features/Home/presentation/widgets/bottom_nav_bar.dart';
import '../../features/login/bussines logic/login_cubit.dart';
import '../../features/login/data/repositries/login_repo.dart';
import '../../features/login/data/webservices/login_webservice.dart';
import '../../features/login/presentation/screens/login_screen.dart';

final LoginRepo loginRepo = LoginRepo(LoginWebservice());
final LoginCubit loginCubit = LoginCubit(loginRepo);
final ItemRepo itemRepo = ItemRepo(ItemWebservice());
final ItemCubit itemCubit = ItemCubit(itemRepo);
final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) =>
          BlocProvider(create: (context) => loginCubit, child: LoginScreen()),
      redirect: (BuildContext context, GoRouterState state) {
        if (savedToken != null && savedToken!.isNotEmpty) {
          return '/home';
        } else {
          return '/';
        }
      },
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => BlocProvider(
        create: (context) => itemCubit,
        child: BottomNavigation(),
      ),
    ),
  ],
);
