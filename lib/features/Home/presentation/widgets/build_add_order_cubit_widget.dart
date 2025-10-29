import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:zikola/core/routing/approutes.dart';
import 'package:zikola/features/Home/business%20logic/cubit/cubit/add_myorder_cubit.dart';
import 'package:zikola/features/Home/business%20logic/cubit/cubit/add_myorder_state.dart';
import 'package:zikola/features/Home/business%20logic/cubit/cubit/edit_myorder_cubit.dart';
import 'package:zikola/features/Home/business%20logic/cubit/cubit/edit_myorder_state.dart';
import 'package:zikola/features/Home/business%20logic/cubit/cubit/my_orders_cubit.dart';
import '../../../../core/get_it.dart' as di;

class BuildAddOrderCubitWidget extends StatelessWidget {
  final int itemId;
  final bool isEdit;
  final Widget Function(bool, BuildContext) child;
  const BuildAddOrderCubitWidget({
    super.key,
    required this.itemId,
    required this.child,
    this.isEdit = false,
  });

  @override
  Widget build(BuildContext context) {
    if (isEdit) {
      return BlocProvider(
        create: (providerContext) => di.setUp<EditMyOrderCubit>(),
        child: Builder(
          builder: (providerContext) {
            return BlocConsumer<EditMyOrderCubit, EditMyOrderState>(
              builder: (providerContext, state) {
                return child(state is EditMyOrderLoading, providerContext);
              },
              listener: (providerContext, state) {
                if (state is EditMyOrderError) {
                  ScaffoldMessenger.of(
                    providerContext,
                  ).showSnackBar(SnackBar(content: Text(state.error.message)));
                } else if (state is EditMyOrderSuccess) {
                  ScaffoldMessenger.of(providerContext).showSnackBar(
                    const SnackBar(content: Text("تم تعديل الطلب بنجاح")),
                  );
                  BlocProvider.of<GetMyOrdersCubit>(
                    providerContext,
                  ).getAllOrders();
                  providerContext.go(AppRoutes.userHome);
                }
              },
            );
          },
        ),
      );
    } else {
      return BlocProvider(
        create: (providerContext) => di.setUp<AddMyOrderCubit>(),
        child: Builder(
          builder: (providerContext) {
            return BlocConsumer<AddMyOrderCubit, AddMyOrderState>(
              builder: (providerContext, state) {
                return child(state is AddMyOrderLoading, providerContext);
              },
              listener: (providerContext, state) {
                if (state is AddMyOrderError) {
                  ScaffoldMessenger.of(
                    providerContext,
                  ).showSnackBar(SnackBar(content: Text(state.error.message)));
                } else if (state is AddMyOrderSuccess) {
                  ScaffoldMessenger.of(providerContext).showSnackBar(
                    const SnackBar(content: Text("تم طلب الأوردر بنجاح")),
                  );
                  BlocProvider.of<GetMyOrdersCubit>(
                    providerContext,
                  ).getAllOrders();
                  providerContext.go(AppRoutes.userHome);
                }
              },
            );
          },
        ),
      );
    }
  }
}
