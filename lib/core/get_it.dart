import 'package:get_it/get_it.dart';
import 'package:zikola/features/Home/business%20logic/cubit/add_myorder_cubit.dart';
import 'package:zikola/features/Home/business%20logic/cubit/item_cubit.dart';
import 'package:zikola/features/Home/business%20logic/cubit/my_orders_cubit.dart';
import 'package:zikola/features/Home/data/repositiries/add_my_order_repo.dart';
import 'package:zikola/features/Home/data/repositiries/get_my_orders_repo.dart';
import 'package:zikola/features/Home/data/repositiries/item_repo.dart';
import 'package:zikola/features/Home/data/webservices/add_my_order_webservices.dart';
import 'package:zikola/features/Home/data/webservices/get_my_orders_webservice.dart';
import 'package:zikola/features/Home/data/webservices/item_webservice.dart';
import 'package:zikola/features/login/bussines%20logic/login_cubit.dart';
import 'package:zikola/features/login/data/repositries/login_repo.dart';
import 'package:zikola/features/login/data/webservices/login_webservice.dart';

final setUp = GetIt.instance;
Future<void> init() async {
  setUp.registerFactory(() => LoginCubit(setUp()));
  setUp.registerFactory(() => AddMyOrderCubit(setUp()));
  setUp.registerFactory(() => GetMyOrdersCubit(setUp()));
  setUp.registerFactory(() => ItemCubit(setUp()));
  //repo
  setUp.registerLazySingleton(() => LoginRepo(setUp()));
  setUp.registerLazySingleton(() => ItemRepo(setUp()));
  setUp.registerLazySingleton(() => GetMyOrdersRepo(setUp()));
  setUp.registerLazySingleton(() => AddMyOrderRepo(setUp()));
  //webservices
  setUp.registerLazySingleton(() => LoginWebservice());
  setUp.registerLazySingleton(() => ItemWebservice());
  setUp.registerLazySingleton(() => GetMyOrdersWebservice());
  setUp.registerLazySingleton(() => AddMyOrderWebservices());
}
