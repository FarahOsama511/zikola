import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zikola/core/theming/color_manager.dart';
import 'package:zikola/features/barista_home/business_logic/get_all_orders_cubit.dart';
import 'package:zikola/features/barista_home/business_logic/update_status_order_cubit.dart';
import 'package:zikola/features/barista_home/business_logic/update_status_order_state.dart';
import '../../../../core/theming/text_style_manager.dart';
import '../../../Home/data/models/orders_model.dart';

Widget buildDetailsOrder(String status, List<OrdersModel> orders) {
  return Expanded(
    child: Directionality(
      textDirection: TextDirection.rtl,
      child: ListView.separated(
        separatorBuilder: (context, index) => SizedBox(height: 20.h),
        itemCount: orders.length,
        itemBuilder: (context, index) {
          final order = orders[index];
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 14.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(color: ColorManager.lightGrey),
              boxShadow: [
                BoxShadow(
                  color: ColorManager.greyColor,
                  blurRadius: .5,
                  offset: const Offset(.5, .5),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  dense: false,
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(15.r),
                    child: SizedBox(
                      width: 60.w,
                      height: 300.h,
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
                          overflow: TextOverflow.ellipsis,
                          order.user?.name ?? "",
                          style: TextStyleManager.font15RegularBlack,
                        ),
                      ),
                      Spacer(),

                      BlocListener<UpdateOrderCubit, UpdateOrderState>(
                        listener: (context, state) {
                          if (state is SuccessUpdateOrder) {
                            context.read<GetAllOrdersCubit>().getAllOrders();
                          } else if (state is ErrorUpdateOrder) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(state.error.message)),
                            );
                          }
                        },
                        child: GestureDetector(
                          onTap: () {
                            final currentStatus = StatusOrder.values.firstWhere(
                              (e) => e.name == order.status,
                              orElse: () => StatusOrder.waiting,
                            );
                            final nextStatus = statusOrder[currentStatus];

                            if (nextStatus != null) {
                              context.read<UpdateOrderCubit>().updateOrder(
                                nextStatus,
                                order.id ?? 1,
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("الطلب مكتمل بالفعل ✅"),
                                ),
                              );
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 10.w),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.r),
                              border: Border.all(color: ColorManager.greyColor),
                            ),
                            child: Text(
                              textAlign: TextAlign.center,
                              _translateStatus(order.status ?? ""),
                              style: TextStyleManager.font15RegularBlack,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  subtitle: Text(
                    order.item?.name ?? "",
                    style: TextStyleManager.font20RegularGrey,
                  ),
                ),
                Text(
                  "عدد ملاعق السكر: ${order.numberOfSugarSpoons ?? 0}",
                  style: TextStyleManager.font20RegularGrey,
                ),
                if (order.orderNotes != null && order.orderNotes!.isNotEmpty)
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(top: 8.h),
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.w,
                      vertical: 6.h,
                    ),
                    decoration: BoxDecoration(
                      color: ColorManager.orangeColor,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Text(
                      order.orderNotes ?? "ملاحظة إضافية",
                      style: TextStyleManager.font20BoldWhite,
                      textAlign: TextAlign.right,
                    ),
                  ),

                const Divider(),
                Text(
                  "رقم الغرفة ${order.room}",
                  style: TextStyleManager.font15RegularGrey,
                ),
              ],
            ),
          );
        },
      ),
    ),
  );
}

String _translateStatus(String status) {
  switch (status.toLowerCase()) {
    case 'waiting':
      return 'قيد الانتظار';
    case 'onprogress':
      return 'قيد التنفيذ';
    case 'completed':
      return 'تم الانتهاء';
    default:
      return status;
  }
}

enum StatusOrder { waiting, onprogress, completed }

Map<StatusOrder, String> statusOrder = {
  StatusOrder.waiting: "onprogress",
  StatusOrder.onprogress: "completed",
};
