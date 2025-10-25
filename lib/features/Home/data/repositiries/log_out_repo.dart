import 'package:dartz/dartz.dart';
import 'package:zikola/core/networking/api_error_handler.dart';
import 'package:zikola/core/networking/api_result.dart';
import 'package:zikola/features/Home/data/webservices/log_out_webservices.dart';
import '../../../../core/helpers/sharedpref_helper.dart';
import '../../../../main.dart';


class LogOutRepo {
  final LogOutWebservices logOutWebservices;
  LogOutRepo(this.logOutWebservices);
  Future<RepoResult<String>> logOut() async {
    try {
      final response = await logOutWebservices.logOut();
      await SharedprefHelper.clearAllSecuredData();
      logger.d("========");
      return Right(response);
    } catch (e) {
      return Left(ApiErrorHandler.handle(e));
    }
  }
}