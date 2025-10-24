import 'package:dio/dio.dart';
import '../../../../core/networking/api_endpoints.dart';
import '../../../../main.dart';

class GetMyOrdersWebservice {
  late Dio dio;
  GetMyOrdersWebservice() {
    BaseOptions baseOptions = BaseOptions(
      baseUrl: ApiEndpoints.baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 20),
    );

    dio = Dio(baseOptions);
  }

  Future<dynamic> getMyOrders() async {
    dio.options.headers = {
      "Accept": "application/json",
      "Authorization": "Bearer $savedToken",
    };

    Response response = await dio.get(ApiEndpoints.myOrders);
    logger.d(response.statusCode);
    return response.data;
  }
}
