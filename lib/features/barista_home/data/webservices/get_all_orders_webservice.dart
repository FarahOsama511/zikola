import 'package:dio/dio.dart';
import '../../../../core/constants/strings.dart';
import '../../../../core/networking/api_endpoints.dart';

class GetAllOrdersWebservice {
  late Dio dio;
  GetAllOrdersWebservice() {
    BaseOptions baseOptions = BaseOptions(
      baseUrl: ApiEndpoints.baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 20),
    );

    dio = Dio(baseOptions);
  }

  Future<dynamic> getAllOrders() async {
    dio.options.headers = {
      "Accept": "application/json",
      "Authorization": "Bearer $savedToken",
    };

    Response response = await dio.get(ApiEndpoints.orders);
    logger.d(response.statusCode);
    return response.data;
  }

  Future<dynamic> updateOrder(String status, int orderId) async {
    dio.options.headers = {
      "Accept": "application/json",
      "Authorization": "Bearer $savedToken",
    };

    Response response = await dio.put(
      "${ApiEndpoints.changeStatusOrder}$orderId",

      data: {"status": status},
    );
    logger.d("🟡 response: $response");
    logger.d(response.statusCode);
    return response.data;
  }
}
