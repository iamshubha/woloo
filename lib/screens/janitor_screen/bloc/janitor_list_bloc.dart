import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:janitor/screens/janitor_screen/bloc/janitor_list_event.dart';
import 'package:janitor/screens/janitor_screen/bloc/janitor_list_state.dart';
import 'package:janitor/screens/janitor_screen/data/model/Janitor_list_model.dart';
import 'package:janitor/screens/janitor_screen/data/netwrok/janitor_list_service.dart';

class JanitorListBloc extends Bloc<JanitorsListEvent, JanitorListState> {
  final JanitorListService janitorListService =
      JanitorListService(dio: GetIt.instance());
  List<JanitorListModel> data = [];
  var clusterId;

  JanitorListBloc() : super(JanitorListInitial()) {
    on<JanitorsListEvent>((event, emit) {});
    on<GetAllJanitors>(_mapGetAllJanitorToState);
    on<ReassignTask>(_mapGetReAssignTaskToState);
  }

  FutureOr<void> _mapGetAllJanitorToState(
      GetAllJanitors event, Emitter<JanitorListState> emit) async {
    try {
      emit(JanitorListLoading());
      data =
          await janitorListService.getAllJanitors(clusterId: event.cluster_id);
      clusterId = event.cluster_id;
      emit(JanitorListSuccess(data: data));
    } catch (e) {
      emit(JanitorListError(error: e.toString()));
    }
  }

  FutureOr<void> _mapGetReAssignTaskToState(
      ReassignTask event, Emitter<JanitorListState> emit) async {
    try {
      emit(ReassignTaskLoading(message: "Loading Please Wait..."));
      await janitorListService.reAssignTaskToJanitor(
          id: event.id, janitor_id: event.janitor_id);
      data = await janitorListService.getAllJanitors(clusterId: clusterId);
      emit(JanitorListSuccess(data: data));
      emit(ReassignTaskSuccessful());
    } catch (e) {
      emit(ReassignTaskError(error: e.toString()));
    }
  }
}
