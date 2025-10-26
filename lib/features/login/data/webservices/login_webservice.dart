import 'package:dio/dio.dart';
import 'package:zikola/core/networking/api_endpoints.dart';
import '../../../../core/constants/strings.dart';

class LoginWebservice {
  late Dio dio;

  LoginWebservice() {
    BaseOptions baseOptions = BaseOptions(
      baseUrl: ApiEndpoints.baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 20),
      headers: {"Accept": "application/json"},
    );
    dio = Dio(baseOptions);
  }

  Future<dynamic> login(String username, String password) async {
    Response response = await dio.post(
      ApiEndpoints.login,
      data: {"username": username, "password": password},
    );
    logger.d(response.statusCode);
    return response.data;
  }
}
