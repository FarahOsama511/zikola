import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zikola/features/login/bussines%20logic/login_state.dart';
import 'package:zikola/features/login/data/repositries/login_repo.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this.loginRepo) : super(LoginInitial());
  final LoginRepo loginRepo;

  Future<void> login(String userName, String password) async {
    emit(LoadingLoginState());
    final result = await loginRepo.login(userName, password);
    
    result.fold(
      (error) => emit(ErrorLoginState(error)),
      (token) => emit(SuccessLoginState()),
    );
  }
}

