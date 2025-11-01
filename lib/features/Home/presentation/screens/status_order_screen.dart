import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theming/text_style_manager.dart';
import '../../business logic/cubit/cubit/delete_my_order_cubit.dart';
import '../../business logic/cubit/cubit/delete_my_order_state.dart';
import '../../business logic/cubit/cubit/my_orders_cubit.dart';
import '../widgets/status_order_widget.dart';

class StatusOrderScreen extends StatefulWidget {
  const StatusOrderScreen({super.key});

  @override
  State<StatusOrderScreen> createState() => _StatusOrderState();
}

class _StatusOrderState extends State<StatusOrderScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<DeleteOrderCubit, DeleteOrderState>(
      listener: (context, state) {
        if (state is DeleteOrderSuccess) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text("تم حذف الاوردر بنجاح")));
          context.read<GetMyOrdersCubit>().getAllOrders();
        }
      },
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("حالة الطلب", style: TextStyleManager.font24Bold),
                    Text(
                      "تتبع طلبات القهوة الخاصة بك",
                      style: TextStyleManager.font20RegularGrey,
                    ),
                    Divider(),
                    SizedBox(height: 20.h),
                    const StatusOrderWidget(),
                    SizedBox(height: 20.h),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
