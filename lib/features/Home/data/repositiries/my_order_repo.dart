import 'package:dartz/dartz.dart';
import 'package:zikola/features/Home/data/models/orders_model.dart';
import 'package:zikola/features/Home/data/webservices/my_orders_webservice.dart';
import '../../../../core/constants/strings.dart';
import '../../../../core/networking/api_error_handler.dart';
import '../../../../core/networking/api_result.dart';

class MyOrderRepo {
  final MyOrdersWebservice myOrdersWebservice;
  MyOrderRepo(this.myOrdersWebservice);
  Future<RepoResult<OrdersModel>> addMyOrder(
    int numberOfSugarSpoons,
    String room,
    String notes,
    int itemId,
  ) async {
    try {
      final response = await myOrdersWebservice.addMyOrder(
        numberOfSugarSpoons,
        room,
        notes,
        itemId,
      );
      final order = OrdersModel.fromJson(response["data"]);
      logger.d(order);
      return Right(order);
    } catch (e) {
      logger.d("error is $e");
      return left(ApiErrorHandler.handle(e));
    }
  }

  Future<dynamic> deleteMyOrder(int orderId) async {
    try {
      final response = await myOrdersWebservice.deleteMyOrder(orderId);
      logger.d(response);
      return Right(response);
    } catch (e) {
      logger.d("error is $e");
      return left(ApiErrorHandler.handle(e));
    }
  }

  Future<RepoResult<OrdersModel>> editMyOrder(
    int orderId,
    int numberOfSugarSpoons,
    String room,
    String orderNotes,
    String itemId,
  ) async {
    try {
      final response = await myOrdersWebservice.editMyOrder(
        orderId,
        numberOfSugarSpoons,
        room,
        orderNotes,
        itemId,
      );
      final order = OrdersModel.fromJson(response["data"]);
      logger.d(order);
      return Right(order);
    } catch (e) {
      logger.d("error is $e");
      return left(ApiErrorHandler.handle(e));
    }
  }
}
