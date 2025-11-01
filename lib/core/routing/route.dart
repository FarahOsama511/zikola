import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../features/Home/business logic/cubit/cubit/delete_my_order_cubit.dart';
import '../../features/Home/business logic/cubit/cubit/item_cubit.dart';
import '../../features/Home/business logic/cubit/cubit/log_out_cubit.dart';
import '../../features/Home/business logic/cubit/cubit/my_orders_cubit.dart';
import '../../features/Home/data/models/item_model.dart';
import '../../features/Home/data/models/orders_model.dart';
import '../../features/Home/presentation/screens/add_or_edit_order_screen.dart';
import '../../features/Home/presentation/widgets/bottom_nav_bar.dart';
import '../../features/barista_home/business_logic/get_all_orders_cubit.dart';
import '../../features/barista_home/business_logic/update_status_order_cubit.dart';
import '../../features/barista_home/presentation/screens/barista_screen.dart';
import '../../features/login/bussines logic/login_cubit.dart';
import '../../features/login/presentation/screens/login_screen.dart';
import '../../main.dart';
import '../constants/strings.dart';
import '../get_it.dart' as di;
import 'approutes.dart';

final GoRouter router = GoRouter(
  navigatorKey: navigatorKey,
  routes: [
    GoRoute(
      path: AppRoutes.login,
      builder: (context, state) => BlocProvider(
        create: (context) => di.setUp<LoginCubit>(),
        child: LoginScreen(),
      ),
      redirect: (BuildContext context, GoRouterState state) {
        if (savedToken != null && savedToken!.isNotEmpty) {
          if (role == "employee") {
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
          // BlocProvider<GetMyOrdersCubit>(
          //   create: (BuildContext context) => di.setUp<GetMyOrdersCubit>(),
          // ),
          BlocProvider<LogOutCubit>(
            create: (BuildContext context) => di.setUp<LogOutCubit>(),
          ),
          BlocProvider<DeleteOrderCubit>(
            create: (BuildContext context) => di.setUp<DeleteOrderCubit>(),
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
        final extra = state.extra as Map<String, dynamic>?;
        final order = extra?['order'] as OrdersModel?;
        final item = extra?['item'] as ItemModel?;
        final isEdit = extra?['isEdit'] as bool? ?? false;

        return BlocProvider(
          create: (context) => di.setUp<GetMyOrdersCubit>(),
          child: AddorEditOrderScreen(order: order, item: item, isEdit: isEdit),
        );
      },
    ),
  ],
);
