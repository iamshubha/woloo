import 'dart:async';
import 'dart:math';

import 'package:Woloo_Smart_hygiene/screens/login/data/model/Update_token_model.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:Woloo_Smart_hygiene/core/local/global_storage.dart';
import 'package:Woloo_Smart_hygiene/screens/login/data/network/login_services.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginService loginService = LoginService(dio: GetIt.instance());
  String requestId = '';
  late int roleId;
  late int janitorId;

  LoginBloc() : super(LoginInitial()) {
    on<LoginEvent>((event, emit) {});
    on<SendOTP>(_mapSendOTPToState);
    on<VerifyOTP>(_mapVerifyOTPToState);
    on<UpdateTokenOnVerifyOTP>(_mapUpdateTokenToState);
  }

  FutureOr<void> _mapSendOTPToState(
      SendOTP event, Emitter<LoginState> emit) async {
    try {
      emit(const LoginLoading(message: "Sending OTP..."));

      var response =
          await loginService.sendOTP(phoneNumber: event.mobileNumber);

      requestId = response.requestId.toString();

      print("requestId $requestId");
      emit(LoginOTPSent());
    } catch (e) {
      emit(LoginError(error: e.toString()));
    }
  }

  FutureOr<void> _mapVerifyOTPToState(
      VerifyOTP event, Emitter<LoginState> emit) async {
    try {
      emit(const LoginLoading(message: "Validating OTP...."));
      print("requestId" + requestId);

      var response =
          await loginService.verifyOTP(otp: event.otp, requestId: requestId);
      GlobalStorage globalStorage = GetIt.instance();

      print("tokennnnnn" + response.token.toString());
      globalStorage.saveToken(accessToken: response.token ?? '');
      globalStorage.saveJanitorId(accessId: response.id!);
      roleId = response.roleId!;
      globalStorage.saveRoleId(accessRoleId: response.roleId!);
      globalStorage.saveSupervisorName(
          accessSupervisorName: response.name ?? '');

      print("Namee--------- " + response.roleId.toString());

      print("iddddd" + response.id.toString());

      emit(LoginOTPVerified());
    } catch (e) {
      print(e.toString());
      emit(LoginError(error: e.toString()));
    }
  }

  FutureOr<void> _mapUpdateTokenToState(
      UpdateTokenOnVerifyOTP event, Emitter<LoginState> emit) async {
    try {
      emit(UpdateTokenLoading());

      var response = await loginService.updateFCMToken(token: event.token);

      print("updateTokenResponse  -------->$response");

      emit(UpdateTokenSuccess(data: response));
    } catch (e) {
      emit(UpdateTokenError(error: e.toString()));
    }
  }
}
