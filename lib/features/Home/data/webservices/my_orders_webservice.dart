import 'package:dio/dio.dart';
import '../../../../core/constants/strings.dart';
import '../../../../core/networking/api_endpoints.dart';

class MyOrdersWebservice {
  late Dio dio;
  MyOrdersWebservice() {
    BaseOptions baseOptions = BaseOptions(
      baseUrl: ApiEndpoints.baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 20),
    );

    dio = Dio(baseOptions);
  }
  Future<dynamic> addMyOrder(
    int numberOfSugarSpoons,
    String room,
    String notes,
    int itemId,
  ) async {
    dio.options.headers = {
      "Accept": "application/json",
      "Authorization": "Bearer $savedToken",
    };

    Response response = await dio.post(
      ApiEndpoints.orders,
      data: {
        "number_of_sugar_spoons": numberOfSugarSpoons,
        "room": room,
        "order_notes": notes,
        "item_id": itemId,
      },
    );
    logger.d(response.statusCode);

    return response.data;
  }

  Future<dynamic> deleteMyOrder(int orderId) async {
    dio.options.headers = {
      "Accept": "application/json",
      "Authorization": "Bearer $savedToken",
    };

    Response response = await dio.delete("${ApiEndpoints.orders}$orderId");
    logger.d(response.statusCode);

    return response.data;
  }

  Future<dynamic> editMyOrder(
    int orderId,
    int numberOfSugarSpoons,
    String room,
    String orderNotes,
    int itemId,
  ) async {
    dio.options.headers = {
      "Accept": "application/json",
      "Authorization": "Bearer $savedToken",
    };

    Response response = await dio.put(
      "${ApiEndpoints.orders}$orderId",
      data: {
        "number_of_sugar_spoons": numberOfSugarSpoons,
        "room": room,
        "order_notes": orderNotes,
        "item_id": itemId,
      },
    );
    logger.d(response.statusCode);

    return response.data;
  }
}
