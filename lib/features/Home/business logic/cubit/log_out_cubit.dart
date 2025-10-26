import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zikola/features/Home/data/repositiries/log_out_repo.dart';
import '../../../../core/constants/strings.dart';
import 'log_out_state.dart';

class LogOutCubit extends Cubit<LogOutState> {
  LogOutCubit(this.logOutRepo) : super(InitialLogOut());
  final LogOutRepo logOutRepo;

  Future<void> logOut() async {
    emit(LoadingLogOut());
    final result = await logOutRepo.logOut();
    logger.d(result);
    result.fold(
      (error) => emit(ErrorLogOut(error)),
      (_) => emit(SuccessLogOut()),
    );
  }
}
