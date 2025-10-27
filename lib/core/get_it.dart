import 'package:get_it/get_it.dart';
import 'package:zikola/features/Home/business%20logic/cubit/cubit/add_myorder_cubit.dart';
import 'package:zikola/features/Home/business%20logic/cubit/cubit/delete_my_order_cubit.dart';
import 'package:zikola/features/Home/business%20logic/cubit/cubit/edit_myorder_cubit.dart';
import 'package:zikola/features/Home/business%20logic/cubit/cubit/item_cubit.dart';
import 'package:zikola/features/Home/business%20logic/cubit/cubit/log_out_cubit.dart';
import 'package:zikola/features/Home/business%20logic/cubit/cubit/my_orders_cubit.dart';
import 'package:zikola/features/Home/data/repositiries/my_order_repo.dart';
import 'package:zikola/features/Home/data/repositiries/get_my_orders_repo.dart';
import 'package:zikola/features/Home/data/repositiries/item_repo.dart';
import 'package:zikola/features/Home/data/repositiries/log_out_repo.dart';
import 'package:zikola/features/Home/data/webservices/my_orders_webservice.dart';
import 'package:zikola/features/Home/data/webservices/get_my_orders_webservice.dart';
import 'package:zikola/features/Home/data/webservices/item_webservice.dart';
import 'package:zikola/features/Home/data/webservices/log_out_webservices.dart';
import 'package:zikola/features/barista_home/business_logic/get_all_orders_cubit.dart';
import 'package:zikola/features/barista_home/business_logic/update_status_order_cubit.dart';
import 'package:zikola/features/barista_home/data/repositiries/get_all_orders_repo.dart';
import 'package:zikola/features/barista_home/data/webservices/get_all_orders_webservice.dart';
import 'package:zikola/features/login/bussines%20logic/login_cubit.dart';
import 'package:zikola/features/login/data/repositries/login_repo.dart';
import 'package:zikola/features/login/data/webservices/login_webservice.dart';

final setUp = GetIt.instance;
Future<void> init() async {
  setUp.registerFactory(() => LoginCubit(setUp()));
  setUp.registerFactory(() => AddMyOrderCubit(setUp()));
  setUp.registerFactory(() => GetMyOrdersCubit(setUp()));
  setUp.registerFactory(() => ItemCubit(setUp()));
  setUp.registerFactory(() => GetAllOrdersCubit(setUp()));
  setUp.registerFactory(() => LogOutCubit(setUp()));
  setUp.registerFactory(() => UpdateOrderCubit(setUp()));
  setUp.registerFactory(() => DeleteOrderCubit(setUp()));
  setUp.registerFactory(() => EditMyOrderCubit(setUp()));

  //repo
  setUp.registerLazySingleton(() => LoginRepo(setUp()));
  setUp.registerLazySingleton(() => ItemRepo(setUp()));
  setUp.registerLazySingleton(() => GetMyOrdersRepo(setUp()));
  setUp.registerLazySingleton(() => MyOrderRepo(setUp()));
  setUp.registerLazySingleton(() => GetAllOrdersRepo(setUp()));
  setUp.registerLazySingleton(() => LogOutRepo(setUp()));
  //webservices
  setUp.registerLazySingleton(() => LoginWebservice());
  setUp.registerLazySingleton(() => ItemWebservice());
  setUp.registerLazySingleton(() => GetMyOrdersWebservice());
  setUp.registerLazySingleton(() => MyOrdersWebservice());
  setUp.registerLazySingleton(() => GetAllOrdersWebservice());
  setUp.registerLazySingleton(() => LogOutWebservices());
}
