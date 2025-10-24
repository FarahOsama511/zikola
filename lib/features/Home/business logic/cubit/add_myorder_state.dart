import '../../../../core/networking/api_error_model.dart';

abstract class AddMyOrderState {}

final class AddMyOrderInitial extends AddMyOrderState {}

final class AddMyOrderLoading extends AddMyOrderState {}

final class AddMyOrderSuccess extends AddMyOrderState {}

final class AddMyOrderError extends AddMyOrderState {
  final ApiErrorModel error;
  AddMyOrderError(this.error);
}
