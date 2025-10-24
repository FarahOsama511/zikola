import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:zikola/features/Home/business%20logic/cubit/add_myorder_cubit.dart';
import 'package:zikola/features/Home/business%20logic/cubit/item_cubit.dart';
import 'package:zikola/features/Home/business%20logic/cubit/my_orders_cubit.dart';
import 'package:zikola/features/Home/data/repositiries/add_my_order_repo.dart';
import 'package:zikola/features/Home/data/repositiries/get_my_orders_repo.dart';
import 'package:zikola/features/Home/data/repositiries/item_repo.dart';
import 'package:zikola/features/Home/data/webservices/add_my_order_webservices.dart';
import 'package:zikola/features/Home/data/webservices/get_my_orders_webservice.dart';
import 'package:zikola/features/Home/data/webservices/item_webservice.dart';
import 'package:zikola/features/Home/presentation/screens/add_order.dart';
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
final AddMyOrderRepo addMyOrderRepo = AddMyOrderRepo(AddMyOrderWebservices());
final AddMyOrderCubit addMyOrderCubit = AddMyOrderCubit(addMyOrderRepo);
final GetMyOrdersRepo getMyOrdersRepo = GetMyOrdersRepo(
  GetMyOrdersWebservice(),
);
final GetMyOrdersCubit getMyOrdersCubit = GetMyOrdersCubit(getMyOrdersRepo);
final GoRouter router = GoRouter(
  routes: [
    // GoRoute(
    //   path: '/',
    //   builder: (context, state) =>
    //       BlocProvider(create: (context) => loginCubit, child: LoginScreen()),
    //   redirect: (BuildContext context, GoRouterState state) {
    //     if (savedToken != null && savedToken!.isNotEmpty) {
    //       return '/home';
    //     } else {
    //       return '/';
    //     }
    //   },
    // ),
    // GoRoute(
    //   path: '/home',
    //   builder: (context, state) => MultiBlocProvider(
    //     providers: [
    //       BlocProvider<ItemCubit>(create: (BuildContext context) => itemCubit),
    //       BlocProvider<GetMyOrdersCubit>(
    //         create: (BuildContext context) => getMyOrdersCubit,
    //       ),
    //     ],

    //     child: BottomNavigation(),
    //   ),
    // ),
    GoRoute(
      path: '/',
      builder: (context, state) => BlocProvider<AddMyOrderCubit>(
        create: (BuildContext context) => addMyOrderCubit,
        child: AddOrder(),
      ),
    ),
  ],
);
