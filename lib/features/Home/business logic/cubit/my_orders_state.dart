import '../../../../../core/networking/api_error_model.dart';
import '../../data/models/orders_model.dart';

abstract class MyOrdersState {}

final class MyOrdersInitial extends MyOrdersState {}

final class MyOrdersLoading extends MyOrdersState {}

final class MyOrdersSuccess extends MyOrdersState {
  final List<OrdersModel> orders;
  MyOrdersSuccess(this.orders);
}

final class MyOrdersError extends MyOrdersState {
  final ApiErrorModel message;
  MyOrdersError(this.message);
}
