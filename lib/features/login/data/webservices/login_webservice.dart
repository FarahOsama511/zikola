import 'package:dio/dio.dart';
import 'package:zikola/core/constants/api_constant.dart';

class LoginWebservice {
  late Dio dio;
  LoginWebservice() {
    BaseOptions baseOptions = BaseOptions(
      baseUrl: ApiConstant.baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 20),
    );
    dio = Dio(baseOptions);
  }
  Future<dynamic> login(String email, String password) async {
    try {
      Response response = await dio.post(
        ApiConstant.login,
        data: {"email": email, "password": password},
      );
      print(response.statusCode);
      return response.data;
    } catch (e) {
      return Future.error(e);
    }
  }
}
