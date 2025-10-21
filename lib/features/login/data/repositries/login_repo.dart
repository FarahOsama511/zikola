
import 'package:dartz/dartz.dart';
import 'package:zikola/core/networking/api_error_handler.dart';
import 'package:zikola/core/networking/api_result.dart';
import 'package:zikola/features/login/data/webservices/login_webservice.dart';
import '../../../../core/helpers/sharedpref_helper.dart';
import '../../../../main.dart';

class LoginRepo {
  final LoginWebservice loginWebservice;
  LoginRepo(this.loginWebservice);
  Future<RepoResult<String>>login(String username,String password)async{
    try{
      final response=await loginWebservice.login(username, password);
      SharedprefHelper.setSecurityString("token", response['token']);
      logger.d("=======${response['token']}");
      return Right(response['token']); 
    }catch(e){
      return Left(ApiErrorHandler.handle(e));
    }
  }
}