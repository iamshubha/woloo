import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    Logger(printer: PrettyPrinter()).e(err.response);
    if (err.response?.statusCode == 400) {
      err.response?.data = err.response?.data['message'];
    }
    super.onError(err, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (response.data['status'] != 200) {
      Logger(printer: PrettyPrinter()).e(response.data);
      throw response.data['message'];
    }
    super.onResponse(response, handler);
  }
}
