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
    // on<GetRBAC>(_mapGetRBACTOState);
  }

  // FutureOr<void> _mapGetRBACTOState(GetRBAC event, Emitter<CoreState> emit) async {
  //   try {
  //     emit(CoreLoading());
  //     await Future.delayed(const Duration(seconds: 2));
  //     var token = globalStorage.getToken();
  //     if (token.isNotEmpty) {
  //       RBAC rbac = await coreService.getRBAC();
  //       GetIt.instance.registerLazySingleton(() => rbac);
  //       emit(CoreSuccess(isLoggedIn: true, accessHome: rbac.homeScreen == null));
  //     } else {
  //       emit(const CoreSuccess(isLoggedIn: false, accessHome: false));
  //     }
  //   } catch (e) {}
  // }
}
