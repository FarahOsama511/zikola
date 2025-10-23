import 'package:dartz/dartz.dart';
import 'package:zikola/core/networking/api_error_handler.dart';
import 'package:zikola/core/networking/api_result.dart';
import 'package:zikola/features/Home/data/models/item_model.dart';
import 'package:zikola/features/Home/data/webservices/item_webservice.dart';

import '../../../../main.dart';

class ItemRepo {
  final ItemWebservice itemWebservice;
  ItemRepo(this.itemWebservice);
  Future<RepoResult<List<ItemModel>>> getItems() async {
    try {
      final response = await itemWebservice.getItems();
      final results = response["data"];
      final items = (results as List)
          .map((e) => ItemModel.fromJson(e))
          .toList();
      return Right(items);
    } catch (e) {
      logger.d("error is $e");
      return left(ApiErrorHandler.handle(e));
    }
  }
}
