import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repositiries/my_order_repo.dart';
import 'delete_my_order_state.dart';

class DeleteOrderCubit extends Cubit<DeleteOrderState> {
  final MyOrderRepo deleteOrderRepo;
  DeleteOrderCubit(this.deleteOrderRepo) : super(DeleteOrderInitial());

  Future<void> deleteOrder(int orderId) async {
    emit(DeleteOrderLoading());
    final result = await deleteOrderRepo.deleteMyOrder(orderId);

    result.fold(
      (error) => emit(DeleteOrderError(error)),
      (_) => emit(DeleteOrderSuccess()),
    );
  }
}
