import 'package:injectable/injectable.dart';
import 'package:investor_app_flutter/src/core/constants/storage_keys.dart';
import 'package:investor_app_flutter/src/core/storage/i_local_storage_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

@LazySingleton(as: ILocalStorageService)
class LocalStorageService implements ILocalStorageService{
  final SharedPreferences sharedPreferences;

  LocalStorageService({required this.sharedPreferences,});

  @override
  Future<void> clear() async{
    await sharedPreferences.clear();
  }

  @override
  String? fetchToken() {
    return sharedPreferences.getString(StorageKeys.keyJwtToken);
  }

  @override
  Future<bool> saveToken(String token) {
    return sharedPreferences.setString(StorageKeys.keyJwtToken, token);
  }

}