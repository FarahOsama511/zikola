import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zikola/features/Home/business%20logic/cubit/my_orders_cubit.dart';
import 'package:zikola/features/Home/business%20logic/cubit/my_orders_state.dart';
import '../../../../core/theming/color_manager.dart';
import 'details_item_widget.dart';

Widget buildMyOrdersBlocWidget() {
  return BlocBuilder<GetMyOrdersCubit, MyOrdersState>(
    builder: (context, state) {
      if (state is MyOrdersLoading) {
        return Center(
          child: CircularProgressIndicator(color: ColorManager.primaryColor),
        );
      } else if (state is MyOrdersSuccess) {
        return DetailsItemWidget(allOrders:context.read<GetMyOrdersCubit>().completedOrder);
      } else if (state is MyOrdersError) {
        return Center(child: Text(state.message.message));
      } else {
        return SizedBox.shrink();
      }
    },
  );
}
