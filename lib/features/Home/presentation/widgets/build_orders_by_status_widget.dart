import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:zikola/core/routing/approutes.dart';
import 'package:zikola/features/Home/business%20logic/cubit/cubit/delete_my_order_cubit.dart';
import '../../../../core/theming/color_manager.dart';
import '../../../../core/theming/text_style_manager.dart';
import '../../business logic/cubit/cubit/my_orders_cubit.dart';
import '../../business logic/cubit/my_orders_state.dart';
import '../../data/models/orders_model.dart';
import 'details_status_order.dart';

Widget buildOrdersByState({
  required String selectedStatus,
  required MyOrdersState state,
  required BuildContext context,
}) {
  if (state is MyOrdersSuccess) {
    List<OrdersModel> filteredOrders;

    if (selectedStatus == "قيد الانتظار") {
      filteredOrders = context.read<GetMyOrdersCubit>().pendingOrder;
    } else if (selectedStatus == "قيد التحضير") {
      filteredOrders = context.read<GetMyOrdersCubit>().acceptedOrder;
    } else if (selectedStatus == "تم الاكتمال") {
      filteredOrders = context.read<GetMyOrdersCubit>().completedOrder;
    } else {
      filteredOrders = [];
    }

    if (filteredOrders.isEmpty) {
      return Center(
        child: Text(
          "لا توجد طلبات في هذه الحالة 👀",
          style: TextStyleManager.font20RegularGrey,
        ),
      );
    }

    return DetailsStatusOrder(
      myOrders: filteredOrders,
      state: selectedStatus,
      onEdit: (orderId) {
        context.go(AppRoutes.addOrder, extra: orderId);
      },
      onCancel: (orderId) {
        context.read<DeleteOrderCubit>().deleteOrder(orderId);
      },
      backgroundColor: selectedStatus == "قيد الانتظار"
          ? ColorManager.primaryColor
          : selectedStatus == "قيد التحضير"
          ? ColorManager.orangeColor
          : Colors.green,
      statusOrder: selectedStatus == "قيد الانتظار"
          ? SizedBox()
          : selectedStatus == "قيد التحضير"
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "جارٍ التحضير...",
                  style: TextStyleManager.font15RegularGrey.copyWith(
                    color: ColorManager.orangeColor,
                  ),
                ),
              ],
            )
          : const SizedBox(),
    );
  } else if (state is MyOrdersLoading) {
    return Center(
      child: CircularProgressIndicator(color: ColorManager.primaryColor),
    );
  } else if (state is MyOrdersError) {
    return Center(
      child: Text(
        "حدث خطأ أثناء تحميل الطلبات ⚠️",
        style: TextStyleManager.font20RegularGrey,
      ),
    );
  } else {
    return Container();
  }
}
