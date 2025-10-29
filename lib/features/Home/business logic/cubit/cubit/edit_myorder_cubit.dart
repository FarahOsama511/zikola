import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/repositiries/my_order_repo.dart';
import 'edit_myorder_state.dart';

class EditMyOrderCubit extends Cubit<EditMyOrderState> {
  final MyOrderRepo myOrderRepo;

  EditMyOrderCubit(this.myOrderRepo) : super(EditMyOrderInitial());

  Future<void> editOrder({
    required int orderId,
    required int numberOfSugarSpoons,
    required String room,
    required String notes,
    required String itemId,
  }) async {
    emit(EditMyOrderLoading());

    final result = await myOrderRepo.editMyOrder(
      orderId,
      numberOfSugarSpoons,
      room,
      notes,
      itemId,
    );

    result.fold(
      (error) => emit(EditMyOrderError(error)),
      (order) => emit(EditMyOrderSuccess(order: order)),
    );
  }
}
