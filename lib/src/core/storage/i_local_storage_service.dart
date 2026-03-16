abstract class ILocalStorageService {
  Future<void> saveToken(String token);
  String? fetchToken();
  Future<void> clear();
}