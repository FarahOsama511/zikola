import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zikola/features/Home/business%20logic/cubit/my_orders_state.dart';
import 'package:zikola/features/Home/data/repositiries/get_my_orders_repo.dart';
import '../../../../core/constants/strings.dart';
import '../../data/models/orders_model.dart';

class GetMyOrdersCubit extends Cubit<MyOrdersState> {
  GetMyOrdersCubit(this.getMyOrdersRepo) : super(MyOrdersInitial());
  final GetMyOrdersRepo getMyOrdersRepo;
  List<OrdersModel> allOrders = [];
  List<OrdersModel> pendingOrder = [];
  List<OrdersModel> completedOrder = [];
  List<OrdersModel> acceptedOrder = [];
  Future<void> getAllOrders() async {
    emit(MyOrdersLoading());
    final result = await getMyOrdersRepo.getMyOrders();
    result.fold((error) => emit(MyOrdersError(error)), (items) {
      emit(MyOrdersSuccess(items));
      allOrders = items;
      pendingOrder = allOrders
          .where((order) => order.status == "waiting")
          .toList();
      completedOrder = allOrders
          .where((order) => order.status == "completed")
          .toList();
      acceptedOrder = allOrders
          .where((order) => order.status == "onprogress")
          .toList();
      logger.d(allOrders);
    });
  }
}
