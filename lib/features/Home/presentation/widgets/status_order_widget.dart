import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theming/color_manager.dart';
import '../../business logic/cubit/cubit/my_orders_cubit.dart';
import '../../business logic/cubit/my_orders_state.dart';
import 'build_orders_by_status_widget.dart';

class StatusOrderWidget extends StatefulWidget {
  const StatusOrderWidget({super.key});

  @override
  State<StatusOrderWidget> createState() => _StatusOrderWidgetState();
}

class _StatusOrderWidgetState extends State<StatusOrderWidget> {
  String selectedStatus = "قيد الانتظار";

  void selectStatus(String status) {
    setState(() {
      selectedStatus = status;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Column(
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
                buildStatusButton("قيد الانتظار"),
                buildStatusButton("قيد التحضير"),
                buildStatusButton("تم الاكتمال"),
              ],
            ),
          ),
          SizedBox(height: 20.h),
          BlocBuilder<GetMyOrdersCubit, MyOrdersState>(
            builder: (context, state) {
              return buildOrdersByState(
                selectedStatus: selectedStatus,
                state: state,
                context: context,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget buildStatusButton(String status) {
    final bool isSelected = selectedStatus == status;

    return GestureDetector(
      onTap: () => selectStatus(status),
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
