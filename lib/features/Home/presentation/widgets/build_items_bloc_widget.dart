import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zikola/features/Home/business%20logic/cubit/item_cubit.dart';
import 'package:zikola/features/Home/business%20logic/cubit/item_state.dart';

import '../../../../core/theming/color_manager.dart';
import 'items_widget.dart';

Widget BuildItemsBlocWidget() {
  return BlocBuilder<ItemCubit, ItemState>(
    builder: (context, state) {
      if (state is ItemLoading) {
        return Center(
          child: CircularProgressIndicator(color: ColorManager.primaryColor),
        );
      } else if (state is ItemSuccess) {
        return ItemsWidget(item: state.items);
      } else if (state is ItemError) {
        return Center(child: Text("${state.error.message}"));
      } else {
        return SizedBox.shrink();
      }
    },
  );
}
