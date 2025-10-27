import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:zikola/core/networking/api_error_handler.dart';
import 'package:zikola/core/networking/api_result.dart';
import 'package:zikola/features/login/data/webservices/login_webservice.dart';
import '../../../../core/constants/strings.dart';
import '../../../../core/helpers/sharedpref_helper.dart';

class LoginRepo {
  final LoginWebservice loginWebservice;
  LoginRepo(this.loginWebservice);
  Future<RepoResult<String>> login(String username, String password) async {
    try {
      final response = await loginWebservice.login(username, password);
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
