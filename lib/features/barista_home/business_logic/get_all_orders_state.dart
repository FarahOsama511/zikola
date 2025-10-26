import 'package:zikola/core/networking/api_error_model.dart';
import '../../Home/data/models/orders_model.dart';

abstract class GetAllOrdersState {}

class InitialGetAllOrders extends GetAllOrdersState {}

class LoadingGetAllOrders extends GetAllOrdersState {}

class SuccessGetAllOrders extends GetAllOrdersState {
  final List<OrdersModel> allOrders;
  SuccessGetAllOrders(this.allOrders);
}

class ErrorGetAllOrders extends GetAllOrdersState {
  final ApiErrorModel error;
  ErrorGetAllOrders(this.error);
}
