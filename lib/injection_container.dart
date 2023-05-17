import 'package:dio/dio.dart';
import 'package:dio_log/interceptor/dio_log_interceptor.dart';
import 'package:get_it/get_it.dart';
import 'package:get_storage/get_storage.dart';

import 'core/interceptor/auth_interceptor.dart';
import 'core/interceptor/error_interceptor.dart';
import 'core/local/global_storage.dart';
import 'core/network/dio_client.dart';

// import 'data/services/network/dio_client.dart';

final sl = GetIt.instance;

Future<void> init() async {
  /// Dio
  var dio = Dio();
  DioLogInterceptor.enablePrintLog = false;
  dio.interceptors.add(ErrorInterceptor());
  dio.interceptors.add(DioLogInterceptor());
  dio.interceptors.add(AuthInterceptor());

  sl.registerLazySingleton(() => DioClient(dio));
  sl.registerLazySingleton(() => GlobalStorage(GetStorage()));
}
