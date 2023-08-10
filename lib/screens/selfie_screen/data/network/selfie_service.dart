import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:janitor/core/network/api_constant.dart';
import 'package:janitor/core/network/dio_client.dart';

class SelfieService {
  final DioClient dio;

  const SelfieService({required this.dio});

  Future<String> uploadSelfie({required String type, required File image, required int id, required String remarks}) async {
    try {
      FormData formData = FormData();

      /// Add image
      formData = FormData.fromMap({
        "type": type,
        "id": id,
        "remarks": remarks,
      });

      formData.files.addAll([
        MapEntry(
          "image",
          await MultipartFile.fromFile(
            image.path,
            filename: getFileName(image.path),
            contentType: MediaType(getType(image.path), getFileExtension(image.path)),
          ),
        ),
      ]);

      var response = await dio.post(
        APIConstants.UPLOAD_SELFIE,
        data: formData,
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
