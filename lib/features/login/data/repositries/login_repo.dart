import 'dart:developer';
import 'package:dartz/dartz.dart';
import '../../../../core/constants/strings.dart';
import '../../../../core/helpers/sharedpref_helper.dart';
import '../../../../core/networking/api_error_handler.dart';
import '../../../../core/networking/api_result.dart';
import '../webservices/login_webservice.dart';

class LoginRepo {
  final LoginWebservice loginWebservice;
  LoginRepo(this.loginWebservice);
  Future<RepoResult<String>> login(
    String username,
    String password,
    String fcmToken,
  ) async {
    try {
      final response = await loginWebservice.login(
        username,
        password,
        fcmToken,
      );
      await SharedprefHelper.setSecurityString("token", response['token']);
      await SharedprefHelper.setData("role", response["user"]["role"]);
      role = response["user"]["role"];
      savedToken = response['token'];
      log(role ?? "");
      log(savedToken ?? "");
      logger.d(role);
      logger.d(savedToken);
      return Right(response['token']);
    } catch (e) {
      logger.d(e);
      return Left(ApiErrorHandler.handle(e));
    }
  }
}
