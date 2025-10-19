import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../features/login/bussines logic/login_cubit.dart';
import '../../features/login/data/repositries/login_repo.dart';
import '../../features/login/data/webservices/login_webservice.dart';
import '../../features/login/presentation/screens/login_screen.dart';
  final LoginRepo loginRepo = LoginRepo(LoginWebservice());
  final LoginCubit loginCubit = LoginCubit(loginRepo);
final GoRouter router = GoRouter(
  routes: [
GoRoute(path:'/', builder: (context, state) => 

BlocProvider(
  create: (context) => LoginCubit(LoginRepo(LoginWebservice())),
  child: SimpleLoginTest())),
  ],
);