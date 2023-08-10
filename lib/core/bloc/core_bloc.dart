import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:janitor/core/local/global_storage.dart';

part 'core_event.dart';
part 'core_state.dart';

class CoreBloc extends Bloc<CoreEvent, CoreState> {
  // final CoreService coreService = CoreService();
  final globalStorage = GetIt.instance<GlobalStorage>();

  CoreBloc() : super(CoreInitial()) {
    on<CoreEvent>((event, emit) {});
    on<CheckUserIsLoggedInOrNot>(_mapCheckUserState);
  }

  FutureOr<void> _mapCheckUserState(CheckUserIsLoggedInOrNot event, Emitter<CoreState> emit) async {
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
}
