import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:zikola/features/Home/business%20logic/cubit/add_myorder_cubit.dart';
import 'package:zikola/features/Home/business%20logic/cubit/add_myorder_state.dart';
import 'package:zikola/features/Home/presentation/widgets/details_my_order.dart';

Widget buildAddOrderCubitWidget() {
  return BlocConsumer<AddMyOrderCubit, AddMyOrderState>(
    builder: (context, state) {
      return DetailsMyOrder();
    },
    listener: (context, state) {
      if (state is AddMyOrderError) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(state.error.message)));
      } else if (state is AddMyOrderSuccess) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Order created successfully")));
        context.go('/home');
      }
    },
  );
}
