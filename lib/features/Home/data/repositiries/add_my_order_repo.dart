import 'package:dartz/dartz.dart';
import 'package:zikola/features/Home/data/models/orders_model.dart';
import 'package:zikola/features/Home/data/webservices/add_my_order_webservices.dart';
import '../../../../core/networking/api_error_handler.dart';
import '../../../../core/networking/api_result.dart';
import '../../../../main.dart';

class AddMyOrderRepo {
  final AddMyOrderWebservices addMyOrderWebservices;
  AddMyOrderRepo(this.addMyOrderWebservices);
  Future<RepoResult<OrdersModel>> addMyOrder(
    int numberOfSugarSpoons,
    String room,
    String notes,
    int itemId,
  ) async {
    try {
      final response = await addMyOrderWebservices.addMyOrder(
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
}
