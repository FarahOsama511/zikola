import 'package:dartz/dartz.dart';
import '../../../../core/constants/strings.dart';
import '../../../../core/networking/api_error_handler.dart';
import '../../../../core/networking/api_result.dart';
import '../../../Home/data/models/orders_model.dart';
import '../webservices/get_all_orders_webservice.dart';

class GetAllOrdersRepo {
  final GetAllOrdersWebservice getAllOrdersWebservice;
  GetAllOrdersRepo(this.getAllOrdersWebservice);
  Future<RepoResult<List<OrdersModel>>> getAllOrders() async {
    try {
      final response = await getAllOrdersWebservice.getAllOrders();
      final results = response["orders"];
      final allOrders = (results as List)
          .map((e) => OrdersModel.fromJson(e))
          .toList();
      logger.d(allOrders);
      return Right(allOrders);
    } catch (e) {
      logger.d("error is $e");
      return left(ApiErrorHandler.handle(e));
    }
  }

  Future<RepoResult<OrdersModel>> updateOrder(
    String status,
    int orderId,
  ) async {
    try {
      final response = await getAllOrdersWebservice.updateOrder(
        status,
        orderId,
      );
      final data = response['data'];
      final order = OrdersModel.fromJson(data);
      logger.d(order);
      return Right(order);
    } catch (e) {
      logger.d("error is $e");
      return left(ApiErrorHandler.handle(e));
    }
  }
}
