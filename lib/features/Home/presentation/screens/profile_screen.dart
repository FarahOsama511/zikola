import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:zikola/core/theming/color_manager.dart';
import 'package:zikola/core/theming/text_style_manager.dart';
import 'package:zikola/features/Home/business%20logic/cubit/cubit/log_out_cubit.dart';
import 'package:zikola/features/Home/business%20logic/cubit/cubit/log_out_state.dart';
import 'package:zikola/features/Home/business%20logic/cubit/cubit/my_orders_cubit.dart';
import 'package:zikola/features/Home/data/models/orders_model.dart';
import '../../../../core/routing/approutes.dart';
import '../../business logic/cubit/my_orders_state.dart';
import '../widgets/settings_card.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: BlocListener<LogOutCubit, LogOutState>(
        listener: (context, state) {
          if (state is SuccessLogOut) {
            context.go(AppRoutes.login);
          } else if (state is ErrorLogOut) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.error.message)));
          }
        },
        child: Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        height: 200.h,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                            colors: [
                              ColorManager.orangeColor,
                              ColorManager.primaryColor,
                            ],
                          ),
                        ),
                      ),
                      SettingsCard(),
                    ],
                  ),
                  SizedBox(height: 70.h),

                  BlocBuilder<GetMyOrdersCubit, MyOrdersState>(
                    builder: (context, state) {
                      final allOrders = context
                          .read<GetMyOrdersCubit>()
                          .allOrders;
                      DateTime oneWeekAgo = DateTime.now().subtract(
                        Duration(days: 7),
                      );

                      // نختار الأوردرات اللي حصلت خلال آخر أسبوع
                      List<OrdersModel> recentOrders = allOrders
                          .where(
                            (order) => order.createdAt!.isAfter(oneWeekAgo),
                          )
                          .toList();
                      return Container(
                        height: 120.h,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20.r),
                          border: Border.all(color: ColorManager.lightGrey),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 14.w,
                            vertical: 14.h,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "إحصائياتك",
                                style: TextStyleManager.font20Bold,
                              ),
                              const Spacer(),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    "${allOrders.length}",
                                    textAlign: TextAlign.center,
                                    style: TextStyleManager.font15Bold.copyWith(
                                      color: ColorManager.orangeColor,
                                    ),
                                  ),

                                  Text(
                                    "${recentOrders.length}",
                                    style: TextStyleManager.font15Bold.copyWith(
                                      color: ColorManager.primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    "إجمالي الطلبات",
                                    style: TextStyleManager.font15Bold.copyWith(
                                      color: ColorManager.greyColor,
                                    ),
                                  ),
                                  Text(
                                    "هذا الأسبوع",
                                    style: TextStyleManager.font15Bold.copyWith(
                                      color: ColorManager.greyColor,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),

                  SizedBox(height: 80.h),
                  InkWell(
                    onTap: () {
                      BlocProvider.of<LogOutCubit>(context).logOut();
                    },
                    child: Container(
                      width: double.infinity,
                      height: 45.h,
                      padding: EdgeInsets.symmetric(vertical: 7.h),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.red, width: 2),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.logout, color: Colors.red),
                          const SizedBox(width: 5),
                          Text(
                            "تسجيل الخروج",
                            style: TextStyleManager.font20RegularBlack.copyWith(
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
