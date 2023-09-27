import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:janitor/core/local/global_storage.dart';
import 'package:janitor/core/service/core_service.dart';

part 'core_event.dart';
part 'core_state.dart';

class CoreBloc extends Bloc<CoreEvent, CoreState> {
  final CoreService coreService = CoreService();
  final globalStorage = GetIt.instance<GlobalStorage>();

  CoreBloc() : super(CoreInitial()) {
    on<CoreEvent>((event, emit) {});
    on<CheckUserIsLoggedInOrNot>(_mapCheckUserState);
    on<UpdateToken>(_mapUpdateTokenToState);
  }

  FutureOr<void> _mapCheckUserState(
      CheckUserIsLoggedInOrNot event, Emitter<CoreState> emit) async {
    try {
      emit(CoreLoading());
      await Future.delayed(const Duration(seconds: 2));
      var token = globalStorage.getToken();
      if (token.isNotEmpty) {
        emit(const CoreSuccess(isLoggedIn: true));
      } else {
        emit(const CoreSuccess(isLoggedIn: false));
      }
    } catch (e) {
      emit(const CoreSuccess(isLoggedIn: false));
    }
  }

  FutureOr<void> _mapUpdateTokenToState(
      UpdateToken event, Emitter<CoreState> emit) async {
    try {
      emit(UpdateTokenLoading());

      var response = await coreService.updateFCMToken(token: event.token);

      print("responseeee  ------  " + response);
      emit(UpdateTokenSuccess());
    } catch (e) {
      emit(UpdateTokenError(error: e.toString()));
    }
  }
}
