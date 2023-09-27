import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class GlobalStorage {
  final GetStorage _box;
  const GlobalStorage(
    this._box,
  );

  final String _tokenKey = 'accessToken';
  final String _idKey = 'accessId';
  final String _roleIdKey = 'accessRoleId';
  final String _fcmTokenKey = 'accessFCMToken';
  final String _supervisorNameKey = 'accessSupervisorName';
  final String _allocationIdKey = 'accessAllocationId';
  final String _locationKey = 'accessLocation';
  final String _latitudeKey = 'accessLatitude';
  final String _longitudeKey = 'accessLongitude';
  final String _currentTimeKey = 'accessCurrentTime';

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

  void saveRoleId({required int accessRoleId}) {
    _box.write(_roleIdKey, accessRoleId);
  }

  int getRoleId() {
    int roleId = _box.read(_roleIdKey);
    print("storage -- role id --" + roleId.toString());
    return roleId;
  }

  void saveFCMToken({required String accessFCMToken}) {
    if (accessFCMToken.isEmpty) {
      throw 'Access Token is empty';
    }
    _box.write(_fcmTokenKey, accessFCMToken);
  }

  String getFCMToken() {
    String? fcmToken = _box.read(_fcmTokenKey);
    return fcmToken ?? '';
  }

  void removeFCMToken() {
    _box.remove(_fcmTokenKey);
  }

  void saveSupervisorName({required String accessSupervisorName}) {
    if (accessSupervisorName.isEmpty) {
      throw 'Supervisor Name is empty';
    }
    _box.write(_supervisorNameKey, accessSupervisorName);
  }

  String getSupervisorName() {
    String? supervisorName = _box.read(_supervisorNameKey);
    return supervisorName ?? '';
  }

  void removeSupervisorName() {
    _box.remove(_supervisorNameKey);
  }

  // void saveAllocationId({required int accessAllocationId}) {
  //   _box.write(_allocationIdKey, accessAllocationId);
  // }
  //
  // int getAllocationId() {
  //   int allocationId = _box.read(_allocationIdKey);
  //   return allocationId;
  // }

  void saveLocation({required String accessLocation}) {
    if (accessLocation.isEmpty) {
      throw 'Location is empty';
    }
    _box.write(_locationKey, accessLocation);
  }

  String getLocation() {
    String? location = _box.read(_locationKey);
    return location ?? '';
  }

  void removeLocation() {
    _box.remove(_locationKey);
  }

  void saveLattitude({required String accessLatitude}) {
    if (accessLatitude.isEmpty) {
      throw 'Latitude is empty';
    }
    _box.write(_latitudeKey, accessLatitude);
  }

  String getLatitude() {
    String? latitude = _box.read(_latitudeKey);
    return latitude ?? '';
  }

  void removeLatitude() {
    _box.remove(_latitudeKey);
  }

  void saveLongitude({required String accessLongitude}) {
    if (accessLongitude.isEmpty) {
      throw 'Latitude is empty';
    }
    _box.write(_longitudeKey, accessLongitude);
  }

  String getLongitude() {
    String? longitude = _box.read(_longitudeKey);
    return longitude ?? '';
  }

  void removeLongitude() {
    _box.remove(_longitudeKey);
  }

  void saveTime({required String accessTime}) {
    if (accessTime.isEmpty) {
      throw 'Time is empty';
    }
    _box.write(_currentTimeKey, accessTime);
  }

  String getTime() {
    String? time = _box.read(_currentTimeKey);
    return time ?? '';
  }

  void removeTime() {
    _box.remove(_currentTimeKey);
  }
}
