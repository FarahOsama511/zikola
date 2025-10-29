import 'package:dio/dio.dart';

import '../constants/strings.dart';
import 'api_endpoints.dart';

class DioHelper {
  late Dio dio;
  DioHelper() {
    BaseOptions baseOptions = BaseOptions(
      baseUrl: ApiEndpoints.baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 20),
      headers: {"Accept": "application/json"},
    );

    dio = Dio(baseOptions);
  }
  Future<dynamic> getMethod({
    required String endPoint,
    required Map<String, dynamic> data,
    required bool isToken,
  }) async {
    dio.options.headers = {if (isToken) "Authorization": "Bearer $savedToken"};
  }
}
