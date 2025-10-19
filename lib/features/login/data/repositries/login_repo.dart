import 'package:shared_preferences/shared_preferences.dart';
import 'package:zikola/features/login/data/webservices/login_webservice.dart';

class LoginRepo {
  final LoginWebservice loginWebservice;
  LoginRepo(this.loginWebservice);
  Future<String>login(String userName,String password)async{
    try{
      final response=await loginWebservice.login(userName, password);
      final SharedPreferences prefs=await SharedPreferences.getInstance();
      final token=prefs.setString('token', response['token']);
      return response['token'];
    }catch(e){
      return Future.error(e);
    }
  }
}