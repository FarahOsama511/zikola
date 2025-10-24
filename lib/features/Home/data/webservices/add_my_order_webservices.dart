import 'package:dio/dio.dart';
import '../../../../core/networking/api_endpoints.dart';
import '../../../../main.dart';

class AddMyOrderWebservices {
  late Dio dio;
  AddMyOrderWebservices() {
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
    String itemId,
  ) async {
    dio.options.headers = {
      "Accept": "application/json",
      "Authorization": "Bearer $savedToken",
    };

    Response response = await dio.post(
      ApiEndpoints.addOrder,
      data: {
        "numberOfSugarSpoons": numberOfSugarSpoons,
        "room": room,
        "notes": notes,
        "itemId": itemId,
      },
    );
    logger.d(response.statusCode);
    return response.data;
  }
}
