import 'package:zikola/core/networking/api_error_model.dart';
import 'package:zikola/features/Home/data/models/item_model.dart';

abstract class ItemState {}

final class ItemInitial extends ItemState {}

final class ItemLoading extends ItemState {}

final class ItemSuccess extends ItemState {
  List<ItemModel> items;
  ItemSuccess(this.items);
}

final class ItemError extends ItemState {
  final ApiErrorModel error;
  ItemError(this.error);
}
