import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/repositiries/item_repo.dart';
import 'item_state.dart';

class ItemCubit extends Cubit<ItemState> {
  ItemCubit(this.itemRepo) : super(ItemInitial());
  final ItemRepo itemRepo;
  Future<void> getAllItems() async {
    emit(ItemLoading());
    final result = await itemRepo.getItems();
    result.fold((error) => emit(ItemError(error)), (items) {
      return emit(ItemSuccess(items));
    });
  }
}
