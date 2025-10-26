import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zikola/features/barista_home/business_logic/get_all_orders_state.dart';
import 'package:zikola/features/barista_home/data/repositiries/get_all_orders_repo.dart';
import '../../../core/constants/strings.dart';
import '../../Home/data/models/orders_model.dart';

class GetAllOrdersCubit extends Cubit<GetAllOrdersState> {
  GetAllOrdersCubit(this.getAllOrdersRepo) : super(InitialGetAllOrders());
  final GetAllOrdersRepo getAllOrdersRepo;
  List<OrdersModel> allOrders = [];
  List<OrdersModel> pendingOrder = [];
  List<OrdersModel> completedOrder = [];
  List<OrdersModel> acceptedOrder = [];
  Future<void> getAllOrders() async {
    emit(LoadingGetAllOrders());
    final result = await getAllOrdersRepo.getAllOrders();
    result.fold((error) => emit(ErrorGetAllOrders(error)), (items) {
      emit(SuccessGetAllOrders(items));
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
