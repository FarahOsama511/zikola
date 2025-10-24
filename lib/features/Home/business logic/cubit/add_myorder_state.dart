import '../../../../core/networking/api_error_model.dart';
import '../../data/models/orders_model.dart';

abstract class AddMyOrderState {}

final class AddMyOrderInitial extends AddMyOrderState {}

final class AddMyOrderLoading extends AddMyOrderState {}

final class AddMyOrderSuccess extends AddMyOrderState {
  final List<OrdersModel> order;
  AddMyOrderSuccess(this.order);
}

final class AddMyOrderError extends AddMyOrderState {
  final ApiErrorModel message;
  AddMyOrderError(this.message);
}
