import 'package:get_storage/get_storage.dart';

class GlobalStorage {
  final GetStorage _box;
  const GlobalStorage(
    this._box,
  );

  final String _tokenKey = 'accessToken';
  // final String _listKey = 'accessList';

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

  // void saveCheckList({required List<int> accessList}) {
  //   if (accessList.isEmpty) {
  //     throw ' list is empty';
  //   }
  //   _box.write(_listKey, accessList);
  // }
  //
  // List<int>? getList() {
  //   List<int>? list = _box.read(_listKey);
  //   return list;
  // }
  //
  // void removeList() {
  //   _box.remove(_listKey);
  // }
}
