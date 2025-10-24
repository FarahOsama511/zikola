import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zikola/core/theming/color_manager.dart';
import 'package:zikola/features/Home/business%20logic/cubit/my_orders_cubit.dart';
import 'package:zikola/features/Home/presentation/widgets/details_status_order.dart';
import '../../../../core/theming/text_style_manager.dart';

class StatusOrderWidget extends StatefulWidget {
  const StatusOrderWidget({super.key});
  @override
  State<StatusOrderWidget> createState() => _StatusOrderWidgetState();
}

class _StatusOrderWidgetState extends State<StatusOrderWidget> {
  String selectedStatus = "Pending";
  void selectStatus(String status) {
    setState(() {
      selectedStatus = status;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: ColorManager.lightGrey,
            borderRadius: BorderRadius.circular(20.r),
          ),
          padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 10.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              buildStatusButton("Pending"),
              buildStatusButton("In Progress"),
              buildStatusButton("Completed"),
            ],
          ),
        ),
        SizedBox(height: 20.h),
        if (selectedStatus == "Pending")
          DetailsStatusOrder(
            myOrders: context.read<GetMyOrdersCubit>().pendingOrder,
            state: "Pending",
            backgroundColor: ColorManager.primaryColor,
            statusOrder: InkWell(
              //هكتب كود الغاء الاوردر
              onTap: () {},
              child: Container(
                height: 30.h,
                padding: EdgeInsets.symmetric(vertical: 5.h),
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.red),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Text(
                  textAlign: TextAlign.center,
                  " X      Cancel Order",
                  style: TextStyleManager.font15Bold.copyWith(
                    color: Colors.red,
                  ),
                ),
              ),
            ),
          )
        else if (selectedStatus == "OnProgress")
          DetailsStatusOrder(
            myOrders: context.read<GetMyOrdersCubit>().acceptedOrder,
            state: "OnProgress",
            backgroundColor: ColorManager.orangeColor,
            statusOrder: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      " \"Extra hot please\" ",
                      style: TextStyleManager.font20RegularGrey,
                    ),
                    Text(
                      " being prepared",
                      style: TextStyleManager.font15RegularGrey.copyWith(
                        color: ColorManager.orangeColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        else
          DetailsStatusOrder(
            myOrders: context.read<GetMyOrdersCubit>().completedOrder,
            state: "Completed",
            backgroundColor: Colors.green,
            statusOrder: SizedBox(),
          ),
      ],
    );
  }

  Widget buildStatusButton(String status) {
    final bool isSelected = selectedStatus == status;

    return GestureDetector(
      onTap: () {
        selectStatus(status);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(15.r),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    blurRadius: 6,
                    offset: Offset(0, 3),
                  ),
                ]
              : [],
        ),
        child: Text(
          status,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            color: isSelected ? Colors.black : Colors.white,
          ),
        ),
      ),
    );
  }
}
