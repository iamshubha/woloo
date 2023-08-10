import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:janitor/core/local/global_storage.dart';
import 'package:janitor/screens/login/data/network/login_services.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginService loginService = LoginService(dio: GetIt.instance());
  String requestId = '';
  String code = '';
  late int janitorId;

  LoginBloc() : super(LoginInitial()) {
    on<LoginEvent>((event, emit) {});
    on<SendOTP>(_mapSendOTPToState);
    on<VerifyOTP>(_mapVerifyOTPToState);
    // on<GetCountryCodes>(_mapGetCountryCodeToState);
  }

  FutureOr<void> _mapSendOTPToState(SendOTP event, Emitter<LoginState> emit) async {
    try {
      emit(const LoginLoading(message: "Sending OTP..."));

      var response = await loginService.sendOTP(phoneNumber: event.mobileNumber);

      requestId = response.requestId.toString();
      print("requestId $requestId");
      emit(LoginOTPSent());
    } catch (e) {
      emit(LoginError(error: e.toString()));
    }
  }

  FutureOr<void> _mapVerifyOTPToState(VerifyOTP event, Emitter<LoginState> emit) async {
    try {
      emit(const LoginLoading(message: "Validating OTP...."));
      print("requestId" + requestId);

      var response = await loginService.verifyOTP(otp: event.otp, requestId: requestId);
      GlobalStorage globalStorage = GetIt.instance();
      print("tokennnnnn" + response.token.toString());
      globalStorage.saveToken(accessToken: response.token ?? '');
      globalStorage.saveJanitorId(accessId: response.id!);
      print("iddddd" + response.id.toString());

      // RBAC rbac = await loginService.getRBAC();
      // await loginService.uploadFCMToken();
      // if (GetIt.instance.isRegistered<RBAC>()) {
      //   GetIt.instance.unregister<RBAC>();
      // }
      // GetIt.instance.registerLazySingleton(() => rbac);

      emit(LoginOTPVerified());
    } catch (e) {
      print(e.toString());
      emit(LoginError(error: e.toString()));
    }
  }
}
