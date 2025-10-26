import 'package:dio/dio.dart';
import '../../../../core/constants/strings.dart';
import '../../../../core/networking/api_endpoints.dart';
import '../../../../main.dart';

class ItemWebservice {
  late Dio dio;
  ItemWebservice() {
    BaseOptions baseOptions = BaseOptions(
      baseUrl: ApiEndpoints.baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 20),
    );

    dio = Dio(baseOptions);
  }

  Future<dynamic> getItems() async {
    dio.options.headers = {
      "Accept": "application/json",
      "Authorization": "Bearer $savedToken",
    };

    Response response = await dio.get(ApiEndpoints.items);
    logger.d(response.statusCode);
    return response.data;
  }
}
