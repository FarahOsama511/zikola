import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zikola/core/constants/strings.dart';
import 'package:zikola/core/theming/color_manager.dart';
import 'package:zikola/core/theming/text_style_manager.dart';
import 'package:zikola/features/barista_home/business_logic/get_all_orders_cubit.dart';
import 'package:zikola/features/barista_home/business_logic/get_all_orders_state.dart';
import '../../business_logic/update_status_order_cubit.dart';
import '../../business_logic/update_status_order_state.dart';
import '../widgets/build_get_all_orders_cubit.dart';

class BaristaScreen extends StatefulWidget {
  const BaristaScreen({super.key});

  @override
  State<BaristaScreen> createState() => _BaristaScreenState();
}

class _BaristaScreenState extends State<BaristaScreen> {
  String selectedStatus = "قيد الانتظار";

  void selectStatus(String status) {
    setState(() {
      selectedStatus = status;
    });
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<GetAllOrdersCubit>(context).getAllOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 14.w),
            child: BlocConsumer<GetAllOrdersCubit, GetAllOrdersState>(
              builder: (context, state) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "مرحبًا طنط أم أحمد 👋",
                      style: TextStyleManager.font24Bold,
                    ),
                    Text(
                      "قم بإدارة طلبات القهوة الخاصة بك",
                      style: TextStyleManager.font15RegularGrey,
                    ),
                    SizedBox(height: 20.h),

                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          buildStatusOrderButton(
                            "الكل",
                            context.read<GetAllOrdersCubit>().allOrders.length,
                          ),
                          SizedBox(width: 10.w),
                          buildStatusOrderButton(
                            "قيد الانتظار",
                            context
                                .read<GetAllOrdersCubit>()
                                .pendingOrder
                                .length,
                          ),
                          SizedBox(width: 10.w),
                          buildStatusOrderButton(
                            "قيد التحضير",
                            context
                                .read<GetAllOrdersCubit>()
                                .acceptedOrder
                                .length,
                          ),
                          SizedBox(width: 10.w),
                          buildStatusOrderButton(
                            "مكتمل",
                            context
                                .read<GetAllOrdersCubit>()
                                .completedOrder
                                .length,
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 20.h),
                    buildGetAllOrders(
                      status: selectedStatus,
                      state: state,
                      context: context,
                    ),
                  ],
                );
              },
              listener: (context, state) {
                if (state is ErrorGetAllOrders) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(state.error.message)));
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget buildStatusOrderButton(String status, int numOfOrders) {
    final bool isSelected = selectedStatus == status;

    return GestureDetector(
      onTap: () => selectStatus(status),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        decoration: BoxDecoration(
          color: isSelected ? ColorManager.orangeColor : Colors.white,
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(color: ColorManager.lightGrey),
          boxShadow: [
            BoxShadow(
              color: ColorManager.greyColor.withOpacity(0.2),
              blurRadius: 2,
              offset: const Offset(1, 1),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                status,
                style: TextStyleManager.font20RegularGrey.copyWith(
                  color: isSelected ? Colors.white : ColorManager.greyColor,
                ),
              ),
              SizedBox(width: 6.w),
              CircleAvatar(
                radius: 12.r,
                backgroundColor: isSelected
                    ? Colors.white.withOpacity(0.3)
                    : ColorManager.lightGrey,
                child: Text(
                  "${numOfOrders}",
                  style: TextStyleManager.font15RegularBlack.copyWith(
                    color: Colors.white,
                    fontSize: 13.sp,
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
