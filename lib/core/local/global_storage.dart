import 'package:get_storage/get_storage.dart';

class GlobalStorage {
  final GetStorage _box;
  const GlobalStorage(
    this._box,
  );

  final String _tokenKey = 'accessToken';
  final String _idKey = 'accessId';

  /// Save Token
  void saveToken({required String accessToken}) {
    if (accessToken.isEmpty) {
      throw 'Access Token is empty';
    }
    _box.write(_tokenKey, accessToken);
  }

  String getToken() {
    String? token = _box.read(_tokenKey);
    return token ?? '';
  }

  void removeToken() {
    _box.remove(_tokenKey);
  }

  void saveJanitorId({required int accessId}) {
    _box.write(_idKey, accessId);
  }

  int getId() {
    int id = _box.read(_idKey);
    return id;
  }

  void removeList() {
    _box.remove(_idKey);
  }

  void saveCheckIn({required bool isCheckedIn}) {
    _box.write("isCheckedIn", isCheckedIn);
  }

  bool isCheckedIn() {
    return _box.read("isCheckedIn") ?? false;
  }
}
