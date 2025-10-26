import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zikola/features/barista_home/data/repositiries/get_all_orders_repo.dart';
import 'update_status_order_state.dart';

class UpdateOrderCubit extends Cubit<UpdateOrderState> {
  final GetAllOrdersRepo updateOrderRepo;

  UpdateOrderCubit(this.updateOrderRepo) : super(InitialUpdateOrder());

  Future<void> updateOrder(String status, int orderId) async {
    emit(LoadingUpdateOrder());
    final result = await updateOrderRepo.updateOrder(status, orderId);

    result.fold(
      (error) => emit(ErrorUpdateOrder(error)),
      (updatedOrder) => emit(SuccessUpdateOrder(updatedOrder)),
    );
  }
}
