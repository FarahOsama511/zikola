import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:zikola/core/routing/approutes.dart';
import 'package:zikola/core/theming/color_manager.dart';
import 'package:zikola/features/login/bussines%20logic/login_cubit.dart';
import 'package:zikola/features/login/bussines%20logic/login_state.dart';
import 'package:zikola/features/login/presentation/widgets/login_box.dart';
import '../../../../core/constants/strings.dart';

Widget buildBlocWidget() {
  return BlocConsumer<LoginCubit, LoginState>(
    listener: (context, state) {
      if (state is SuccessLoginState) {
        if (role == "employee") {
          GoRouter.of(context).go(AppRoutes.userHome);
        } else if (role == "barista") {
          GoRouter.of(context).go(AppRoutes.baristaHome);
        }
      } else if (state is ErrorLoginState) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(state.error.message)));
      }
    },

    builder: (context, state) {
      if (state is LoadingLoginState) {
        return Center(
          child: CircularProgressIndicator(color: ColorManager.primaryColor),
        );
      }
      return LoginBox();
    },
  );
}
