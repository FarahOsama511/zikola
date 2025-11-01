import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants/strings.dart';
import '../data/repositries/login_repo.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this.loginRepo) : super(LoginInitial());
  final LoginRepo loginRepo;

  Future<void> login(String userName, String password) async {
    emit(LoadingLoginState());
    final result = await loginRepo.login(userName, password, fcmToken ?? "");

    result.fold(
      (error) => emit(ErrorLoginState(error)),
      (token) => emit(SuccessLoginState()),
    );
  }
}
