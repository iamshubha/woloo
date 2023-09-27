import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:http_parser/http_parser.dart';
import 'package:janitor/core/network/api_constant.dart';
import 'package:janitor/core/network/dio_client.dart';

class CoreService {
  final DioClient dio = GetIt.instance<DioClient>();

  Future<String> updateFCMToken({required String token}) async {
    try {
      var response = await dio.put(
        APIConstants.UPDATE_TOKEN_FCM,
        data: {
          "token": token,
        },
        options: Options(extra: {"auth": true}),
      );

      return response['results'].toString();
    } catch (e) {
      rethrow;
    }
  }

  getFileName(String path) {
    return path.split('/').last;
  }

  getFileExtension(String path) {
    return path.split('/').last.split(".").last;
  }

  getType(String path) {
    String extension = getFileExtension(path);
    switch (extension) {
      case "pdf":
        return "application";
      case "jpg":
        return "image";
      case "jpeg":
        return "image";
      case "png":
        return "image";
    }
    return "";
  }
}
