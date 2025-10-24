import 'package:dartz/dartz.dart';
import 'package:zikola/features/Home/data/models/orders_model.dart';
import 'package:zikola/features/Home/data/webservices/get_my_orders_webservice.dart';
import '../../../../core/networking/api_error_handler.dart';
import '../../../../core/networking/api_result.dart';
import '../../../../main.dart';

class GetMyOrdersRepo {
  final GetMyOrdersWebservice getMyOrdersWebservice;
  GetMyOrdersRepo(this.getMyOrdersWebservice);
  Future<RepoResult<List<OrdersModel>>> getMyOrders() async {
    try {
      final response = await getMyOrdersWebservice.getMyOrders();
      final results = response["data"];
      final myOrders = (results as List)
          .map((e) => OrdersModel.fromJson(e))
          .toList();
      return Right(myOrders);
    } catch (e) {
      logger.d("error is $e");
      return left(ApiErrorHandler.handle(e));
    }
  }
}
