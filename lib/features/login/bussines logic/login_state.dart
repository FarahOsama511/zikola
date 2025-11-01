import '../../../core/networking/api_error_model.dart';

abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoadingLoginState extends LoginState {}

class SuccessLoginState extends LoginState {}

class ErrorLoginState extends LoginState {
  final ApiErrorModel error;
  ErrorLoginState(this.error);
}
