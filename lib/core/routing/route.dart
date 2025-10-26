import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:zikola/core/routing/approutes.dart';
import 'package:zikola/features/Home/business%20logic/cubit/add_myorder_cubit.dart';
import 'package:zikola/features/Home/business%20logic/cubit/item_cubit.dart';
import 'package:zikola/features/Home/business%20logic/cubit/log_out_cubit.dart';
import 'package:zikola/features/Home/business%20logic/cubit/my_orders_cubit.dart';
import 'package:zikola/features/Home/data/models/item_model.dart';
import 'package:zikola/features/Home/presentation/screens/add_order_screen.dart';
import 'package:zikola/features/barista_home/business_logic/get_all_orders_cubit.dart';
import 'package:zikola/features/barista_home/business_logic/update_status_order_cubit.dart';
import 'package:zikola/features/barista_home/presentation/screens/barista_screen.dart';
import '../../features/Home/presentation/widgets/bottom_nav_bar.dart';
import '../../features/login/bussines logic/login_cubit.dart';
import '../../features/login/presentation/screens/login_screen.dart';
import '../constants/strings.dart';
import '../get_it.dart' as di;

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: AppRoutes.login,
      builder: (context, state) => BlocProvider(
        create: (context) => di.setUp<LoginCubit>(),
        child: LoginScreen(),
      ),
      redirect: (BuildContext context, GoRouterState state) {
        if (savedToken != null && savedToken!.isNotEmpty) {
          if (role == "admin") {
            return AppRoutes.userHome;
          } else if (role == "barista") {
            return AppRoutes.baristaHome;
          } else {
            return AppRoutes.login;
          }
        } else {
          return AppRoutes.login;
        }
      },
    ),
    GoRoute(
      path: AppRoutes.userHome,
      builder: (context, state) => MultiBlocProvider(
        providers: [
          BlocProvider<ItemCubit>(
            create: (BuildContext context) => di.setUp<ItemCubit>(),
          ),
          BlocProvider<GetMyOrdersCubit>(
            create: (BuildContext context) => di.setUp<GetMyOrdersCubit>(),
          ),
          BlocProvider<LogOutCubit>(
            create: (BuildContext context) => di.setUp<LogOutCubit>(),
          ),
        ],
        child: BottomNavigation(),
      ),
    ),
    GoRoute(
      path: AppRoutes.baristaHome,
      builder: (context, state) => MultiBlocProvider(
        providers: [
          BlocProvider<GetAllOrdersCubit>(
            create: (BuildContext context) => di.setUp<GetAllOrdersCubit>(),
          ),
          BlocProvider<UpdateOrderCubit>(
            create: (BuildContext context) => di.setUp<UpdateOrderCubit>(),
          ),
        ],

        child: BaristaScreen(),
      ),
    ),
    GoRoute(
      path: AppRoutes.addOrder,
      builder: (context, state) {
        final item = state.extra as ItemModel;
        return BlocProvider<AddMyOrderCubit>(
          create: (BuildContext context) => di.setUp<AddMyOrderCubit>(),
          child: AddOrder(item: item),
        );
      },
    ),
  ],
);
