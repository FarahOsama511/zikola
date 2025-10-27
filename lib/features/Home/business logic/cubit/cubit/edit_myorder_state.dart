import 'package:zikola/features/Home/data/models/orders_model.dart';

import '../../../../../core/networking/api_error_model.dart';

abstract class EditMyOrderState {}

final class EditMyOrderInitial extends EditMyOrderState {}

final class EditMyOrderLoading extends EditMyOrderState {}

final class EditMyOrderSuccess extends EditMyOrderState {
  final OrdersModel order;

  EditMyOrderSuccess({required this.order});
}

final class EditMyOrderError extends EditMyOrderState {
  final ApiErrorModel error;
  EditMyOrderError(this.error);
}
