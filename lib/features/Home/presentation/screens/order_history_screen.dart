import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theming/color_manager.dart';
import '../../../../core/theming/text_style_manager.dart';
import '../../business logic/cubit/cubit/my_orders_cubit.dart';
import '../widgets/build_my_orders_bloc_widget.dart';
import '../widgets/filter_widget.dart';

class OrderHistoryScreen extends StatefulWidget {
  const OrderHistoryScreen({super.key});

  @override
  State<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
  @override
  void initState() {
    BlocProvider.of<GetMyOrdersCubit>(context).getAllOrders();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("سجل الطلبات", style: TextStyleManager.font24Bold),
                    const Icon(Icons.calendar_month, size: 40),
                  ],
                ),
                Text(
                  "تعرف على طلباتك السابقة",
                  style: TextStyleManager.font20RegularGrey,
                ),

                SizedBox(height: 20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      Icons.filter_alt_outlined,
                      size: 40,
                      color: ColorManager.greyColor,
                    ),
                    const CustomDropdownExample(),
                  ],
                ),

                SizedBox(height: 20.h),
                const Divider(),
                SizedBox(height: 20.h),
                buildMyOrdersBlocWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
