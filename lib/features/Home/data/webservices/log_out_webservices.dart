import 'package:dio/dio.dart';
import 'package:zikola/core/networking/api_endpoints.dart';
import '../../../../core/constants/strings.dart';
import '../../../../main.dart';

class LogOutWebservices {
  late Dio dio;

  LogOutWebservices() {
    BaseOptions baseOptions = BaseOptions(
      baseUrl: ApiEndpoints.baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 20),
      headers: {
        "Accept": "application/json",
        "Authorization": "Bearer $savedToken",
      },
    );
    dio = Dio(baseOptions);
  }

  Future<dynamic> logOut() async {
    Response response = await dio.post(ApiEndpoints.logOut);
    logger.d(response.statusCode);
    return response.data;
  }
}
