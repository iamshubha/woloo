import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:janitor/core/local/global_storage.dart';
import 'package:janitor/screens/dashboard/bloc/dashboard_event.dart';
import 'package:janitor/screens/dashboard/bloc/dashboard_state.dart';
import 'package:janitor/screens/dashboard/data/model/dashboard_model_class.dart';
import 'package:janitor/screens/dashboard/data/network/dashboard_service.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final DashboardService dashboardService = DashboardService(dio: GetIt.instance());
  final GlobalStorage globalStorage = GetIt.instance<GlobalStorage>();
  List<DashboardModelClass> data = [];
  late int janitorId;

  DashboardBloc() : super(ClockInInitial()) {
    on<DashboardEvent>((event, emit) {});
    on<MarkAttendance>(_mapMarkAttendanceToState);
    on<GetTaskTamplates>(_mapGetDashboardToState);
    on<UpdateStatus>(_mapUpdateStatusToState);
  }

  FutureOr<void> _mapMarkAttendanceToState(MarkAttendance event, Emitter<DashboardState> emit) async {
    try {
      emit(const ClockInLoading(message: "Loading Please Wait..."));

      var response = await dashboardService.markAttendance(type: event.type, locations: event.locations);

      if (event.type == "check_in") {
        globalStorage.saveCheckIn(isCheckedIn: true);
      }

      if (event.type == "check_out") {
        globalStorage.saveCheckIn(isCheckedIn: false);
        emit(ClockOutSuccessful());
        return;
      }

      print("responseeee  ------  " + response);
      emit(ClockInSuccessful());
    } catch (e) {
      emit(ClockInError(error: e.toString()));
    }
  }

  FutureOr<void> _mapGetDashboardToState(GetTaskTamplates event, Emitter<DashboardState> emit) async {
    try {
      emit(DashboardLoading());
      janitorId = event.janitorId;
      data = await dashboardService.getTasksByJanitorId(id: event.janitorId);

      emit(GetDashboardDataSuccess(data: data));
    } catch (e) {
      emit(DashboardError(error: e.toString()));
    }
  }

  FutureOr<void> _mapUpdateStatusToState(UpdateStatus event, Emitter<DashboardState> emit) async {
    try {
      emit(const UpdateStatusLoading(message: "Loading Please Wait..."));

      await dashboardService.updateStatus(id: event.id, status: event.status);
      data = await dashboardService.getTasksByJanitorId(id: janitorId);

      emit(GetDashboardDataSuccess(data: data));
    } catch (e) {
      emit(UpdateStatusError(error: e.toString()));
    }
  }
}
