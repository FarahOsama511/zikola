import '../../../../../core/networking/api_error_model.dart';

abstract class LogOutState {}

class InitialLogOut extends LogOutState {}

class LoadingLogOut extends LogOutState {}

class SuccessLogOut extends LogOutState {}

class ErrorLogOut extends LogOutState {
  final ApiErrorModel error;
  ErrorLogOut(this.error);
}
