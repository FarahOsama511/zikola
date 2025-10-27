import '../../../../../core/networking/api_error_model.dart';

abstract class DeleteOrderState {}

final class DeleteOrderInitial extends DeleteOrderState {}

final class DeleteOrderLoading extends DeleteOrderState {}

final class DeleteOrderSuccess extends DeleteOrderState {}

final class DeleteOrderError extends DeleteOrderState {
  final ApiErrorModel error;
  DeleteOrderError(this.error);
}
