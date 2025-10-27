import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:zikola/core/routing/approutes.dart';
import '../../../../core/theming/color_manager.dart';
import '../../../../core/theming/text_style_manager.dart';
import '../../data/models/orders_model.dart';

class DetailsStatusOrder extends StatefulWidget {
  final String state;
  final Color backgroundColor;
  final Widget statusOrder;
  final List<OrdersModel> myOrders;
  final Function(int orderId)? onCancel;
  final Function(int orderId)? onEdit;

  const DetailsStatusOrder({
    super.key,
    required this.onEdit,
    required this.onCancel,
    required this.state,
    required this.backgroundColor,
    required this.statusOrder,
    required this.myOrders,
  });

  @override
  State<DetailsStatusOrder> createState() => _DetailsStatusOrderState();
}

class _DetailsStatusOrderState extends State<DetailsStatusOrder> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400.h,
      child: ListView.separated(
        separatorBuilder: (context, index) => SizedBox(height: 20.h),
        itemCount: widget.myOrders.length,
        itemBuilder: (context, index) {
          final order = widget.myOrders[index];
          final formattedTime = DateFormat(
            'h:mm a',
          ).format(order.createdAt ?? DateTime.now());

          return Container(
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(color: ColorManager.lightGrey),
              borderRadius: BorderRadius.circular(20),
            ),
            padding: EdgeInsets.all(10.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  dense: false,
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(15.r),
                    child: SizedBox(
                      width: 60.w,
                      height: 60.w,
                      child: Image.network(
                        order.item?.imageUrl ?? "",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          order.item?.name ?? "",
                          style: TextStyleManager.font20RegularBlack,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Container(
                        height: 35.h,
                        width: 90.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.r),
                          color: widget.backgroundColor,
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          widget.state,
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
                        order.room ?? "غير محدد",
                        style: TextStyleManager.font15RegularGrey,
                      ),
                      Text(
                        "$formattedTime • عدد ملاعق السكر: ${order.numberOfSugarSpoons}",
                        style: TextStyleManager.font15RegularGrey,
                      ),
                    ],
                  ),
                ),
                if (order.status == "waiting")
                  Column(
                    children: [
                      InkWell(
                        onTap: () {
                          if (widget.onCancel != null) {
                            widget.onCancel!(order.id!);
                          }
                        },
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
                            "  ❌ إلغاء الطلب",
                            style: TextStyleManager.font15Bold.copyWith(
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20.h),
                      InkWell(
                        onTap: () {
                          if (widget.onEdit != null) {
                            widget.onEdit!(order.id!);
                          }
                          context.go(AppRoutes.addOrder);
                        },
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
                            "  تعديل الطلب",
                            style: TextStyleManager.font15Bold.copyWith(
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                SizedBox(height: 20.h),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  child: widget.statusOrder,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
