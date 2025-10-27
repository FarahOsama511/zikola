import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:zikola/features/Home/business%20logic/cubit/cubit/my_orders_cubit.dart';
import 'package:zikola/features/Home/presentation/widgets/build_add_order_cubit_widget.dart';
import '../../../../core/theming/color_manager.dart';
import '../../../../core/theming/text_style_manager.dart';
import '../../business logic/cubit/cubit/add_myorder_cubit.dart';
import '../../data/models/orders_model.dart';

class DetailsItemWidget extends StatefulWidget {
  final List<OrdersModel> allOrders;
  const DetailsItemWidget({super.key, required this.allOrders});

  @override
  State<DetailsItemWidget> createState() => _DetailsItemWidgetState();
}

class _DetailsItemWidgetState extends State<DetailsItemWidget> {
  late List<bool> isOrderList;

  @override
  void initState() {
    super.initState();
    isOrderList = List<bool>.filled(widget.allOrders.length, false);
  }

  void toggleReorder(int index) {
    setState(() {
      isOrderList[index] = !isOrderList[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        separatorBuilder: (context, index) => SizedBox(height: 20.h),
        itemCount: context.read<GetMyOrdersCubit>().completedOrder.length,
        itemBuilder: (context, index) {
          final order = context.read<GetMyOrdersCubit>().completedOrder[index];
          final isOrder = isOrderList[index];

          return Container(
            height: 190.h,
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(color: ColorManager.lightGrey),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                ListTile(
                  dense: false,
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(15.r),
                    child: SizedBox(
                      width: 60.w,
                      height: 300.h,
                      child: Image.network(
                        order.item?.imageUrl ??
                            "https://thvnext.bing.com/th/id/OIP.GdL69NaUTPtmqZ3vAPcRyQHaHa?w=185&h=185&c=7&r=0&o=7",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        order.item?.name ?? "",
                        style: TextStyleManager.font20RegularBlack,
                      ),
                      Container(
                        width: 85.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.r),
                          color: ColorManager.greenColor,
                        ),
                        child: Text(
                          textAlign: TextAlign.center,
                          "مكتمل",
                          style: TextStyleManager.font16BoldWhite.copyWith(
                            fontSize: 14.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        order.room ?? "",
                        style: TextStyleManager.font15RegularGrey,
                      ),
                      Text(
                        "${DateFormat('dd MMM yyyy').format(order.createdAt!)} في ${DateFormat('h:mm').format(order.createdAt!)}",
                        style: TextStyleManager.font15RegularGrey,
                      ),
                      Text(
                        "${order.numberOfSugarSpoons} ملاعق سكر",
                        style: TextStyleManager.font15RegularGrey,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.h),
                Divider(endIndent: 10, indent: 10),
                SizedBox(height: 20.h),
                BuildAddOrderCubitWidget(
                  itemId: order.item?.id ?? 1,
                  child: (_, providerContext) {
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.w),
                      child: InkWell(
                        onTap: () {
                          providerContext.read<AddMyOrderCubit>().addOrder(
                            order.numberOfSugarSpoons ?? 0,
                            order.room ?? "",
                            order.orderNotes ?? "",
                            order.item?.id ?? 0,
                          );
                        },
                        child: Container(
                          height: 30.h,
                          padding: EdgeInsets.symmetric(vertical: 5.h),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: isOrder
                                ? ColorManager.orangeColor
                                : Colors.transparent,
                            border: Border.all(color: ColorManager.lightGrey),
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          child: Text(
                            textAlign: TextAlign.center,
                            isOrder ? "تم إعادة الطلب" : "إعادة الطلب",
                            style: isOrder
                                ? TextStyleManager.font16BoldWhite.copyWith(
                                    fontSize: 15.sp,
                                  )
                                : TextStyleManager.font15Bold,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
