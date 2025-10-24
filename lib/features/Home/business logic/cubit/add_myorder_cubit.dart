import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repositiries/add_my_order_repo.dart';
import 'add_myorder_state.dart';

class AddMyOrderCubit extends Cubit<AddMyOrderState> {
  final AddMyOrderRepo addMyOrderRepo;

  AddMyOrderCubit(this.addMyOrderRepo) : super(AddMyOrderInitial());

  Future<void> addOrder(
    int numberOfSugarSpoons,
    String room,
    String notes,
    String itemId,
  ) async {
    emit(AddMyOrderLoading());
    final result = await addMyOrderRepo.addMyOrder(
      numberOfSugarSpoons,
      room,
      notes,
      itemId,
    );

    result.fold(
      (error) => emit(AddMyOrderError(error)),
      (order) => emit(AddMyOrderSuccess()),
    );
  }
}
