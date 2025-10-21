import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SharedprefHelper {
  static setSecurityString(String key,String value)async{
    const flutterSecureStorage = FlutterSecureStorage();
    debugPrint('Storing key: $key with value: $value');
    await flutterSecureStorage.write(key: key, value: value);
  }
    static getSecurityString(String key)async{
    const flutterSecureStorage = FlutterSecureStorage();
      debugPrint('Retrieved key: $key');
    return await flutterSecureStorage.read(key: key);
  
}
  static clearAllSecuredData() async {
    debugPrint('FlutterSecureStorage : all data has been cleared');
    const flutterSecureStorage = FlutterSecureStorage();
    await flutterSecureStorage.deleteAll();
  }
}