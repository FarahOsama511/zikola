import 'package:dio/dio.dart';
import 'package:zikola/core/networking/api_error_model.dart';

class ApiErrorHandler {
  static ApiErrorModel handle(dynamic error) {
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
          return ApiErrorModel(
            message: "Connection timeout. Please try again later.",
            statusCode: 408,
          );

        case DioExceptionType.sendTimeout:
          return ApiErrorModel(
            message: "Send timeout. The request took too long to send.",
            statusCode: 408,
          );

        case DioExceptionType.receiveTimeout:
          return ApiErrorModel(
            message: "Receive timeout. The server took too long to respond.",
            statusCode: 504,
          );

        case DioExceptionType.badCertificate:
          return ApiErrorModel(
            message: "Bad certificate. Please check your network security.",
            statusCode: 495,
          );

        case DioExceptionType.cancel:
          return ApiErrorModel(
            message: "Request was cancelled.",
            statusCode: 499,
          );

        case DioExceptionType.connectionError:
          return ApiErrorModel(
            message: "Connection error occurred. Please check your internet connection.",
            statusCode: 0,
          );

        case DioExceptionType.badResponse:
          final response = error.response;
          if (response != null) {
            final statusCode = response.statusCode ?? 500;

            // نحاول نجيب الرسالة اللي جايه من الباك إند
            String message = "Unexpected server error.";
            if (response.data is Map && response.data['message'] != null) {
              message = response.data['message'];
            } else if (response.data is String) {
              message = response.data;
            }

            return ApiErrorModel(
              message: message,
              statusCode: statusCode,
            );
          } else {
            return ApiErrorModel(
              message: "Server returned an invalid response.",
              statusCode: 500,
            );
          }

        case DioExceptionType.unknown:
        default:
          return _handleUnknownError(error);
      }
    } else {
      return ApiErrorModel(
        message: "An unexpected error occurred.",
        statusCode: 500,
      );
    }
  }

  static ApiErrorModel _handleUnknownError(dynamic error) {
    if (error is Error) {
      return ApiErrorModel(
        message: error.toString(),
        statusCode: 500,
      );
    }
    return ApiErrorModel(
      message: "Unknown error occurred. Please try again later.",
      statusCode: 500,
    );
  }
}
