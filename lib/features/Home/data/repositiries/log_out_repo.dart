import 'package:dartz/dartz.dart';
import 'package:zikola/core/networking/api_error_handler.dart';
import 'package:zikola/core/networking/api_result.dart';
import 'package:zikola/features/Home/data/webservices/log_out_webservices.dart';
import 'package:zikola/main.dart';
import '../../../../core/constants/strings.dart';
import '../../../../core/helpers/sharedpref_helper.dart';

class LogOutRepo {
  final LogOutWebservices logOutWebservices;
  LogOutRepo(this.logOutWebservices);
  Future<RepoResult<Map<String, dynamic>>> logOut() async {
    try {
      final response = await logOutWebservices.logOut();
      await SharedprefHelper.clearAllSecuredData();
      savedToken = null;
      return Right(response);
    } catch (e) {
      logger.d(e);
      return Left(ApiErrorHandler.handle(e));
    }
  }
}
