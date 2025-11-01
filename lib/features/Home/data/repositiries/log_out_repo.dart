import 'package:dartz/dartz.dart';
import '../../../../core/constants/strings.dart';
import '../../../../core/helpers/sharedpref_helper.dart';
import '../../../../core/networking/api_error_handler.dart';
import '../../../../core/networking/api_result.dart';
import '../webservices/log_out_webservices.dart';

class LogOutRepo {
  final LogOutWebservices logOutWebservices;
  LogOutRepo(this.logOutWebservices);
  Future<RepoResult<Map<String, dynamic>>> logOut() async {
    try {
      final response = await logOutWebservices.logOut();
      await SharedprefHelper.clearAllSecuredData();
      savedToken = null;
      role = null;
      return Right(response);
    } catch (e) {
      logger.d(e);
      return Left(ApiErrorHandler.handle(e));
    }
  }
}
