import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:Woloo_Smart_hygiene/core/local/global_storage.dart';
import 'package:Woloo_Smart_hygiene/screens/dashboard/bloc/dashboard_event.dart';
import 'package:Woloo_Smart_hygiene/screens/dashboard/bloc/dashboard_state.dart';
import 'package:Woloo_Smart_hygiene/screens/dashboard/data/model/dashboard_model_class.dart';
import 'package:Woloo_Smart_hygiene/screens/dashboard/data/network/dashboard_service.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final DashboardService dashboardService =
      DashboardService(dio: GetIt.instance());
  final GlobalStorage globalStorage = GetIt.instance<GlobalStorage>();
  List<DashboardModelClass> data = [];
  late int janitorId;
  var message;

  DashboardBloc() : super(ClockInInitial()) {
    on<DashboardEvent>((event, emit) {});
    on<MarkAttendance>(_mapMarkAttendanceToState);
    on<GetTaskTamplates>(_mapGetDashboardToState);
    on<UpdateStatus>(_mapUpdateStatusToState);
    on<CheckAttendance>(_mapAppLaunchToState);
  }

  FutureOr<void> _mapMarkAttendanceToState(
      MarkAttendance event, Emitter<DashboardState> emit) async {
    try {
      emit(const ClockInLoading(message: "Loading Please Wait..."));

      var response = await dashboardService.markAttendance(
          type: event.type, locations: event.locations);

      if (event.type == "check_in") {
        globalStorage.saveCheckIn(isCheckedIn: true);
        emit(ClockInSuccessful(attendanceModel: response));
      }

      if (event.type == "check_out") {
        globalStorage.saveCheckIn(isCheckedIn: false);

        emit(ClockOutSuccessful(attendanceModel: response));
        return;
      }
      message = response.message;
      print("responseeee  ------>>>>>>  " + response.toString());
    } catch (e) {
      if (event.type == "check_in") {
        emit(ClockInError(error: e.toString(), message: message));
      }
      if (event.type == "check_out") {
        emit(ClockOutError(error: e.toString(), message: message));
      }
    }
  }

  FutureOr<void> _mapGetDashboardToState(
      GetTaskTamplates event, Emitter<DashboardState> emit) async {
    try {
      emit(DashboardLoading());
      data = await dashboardService.getTasksByJanitorId();

      emit(GetDashboardDataSuccess(data: data));
    } catch (e) {
      emit(DashboardError(error: e.toString()));
    }
  }

  FutureOr<void> _mapUpdateStatusToState(
      UpdateStatus event, Emitter<DashboardState> emit) async {
    try {
      emit(const UpdateStatusLoading(message: "Loading Please Wait..."));

      await dashboardService.updateStatus(id: event.id, status: event.status);
      data = await dashboardService.getTasksByJanitorId();

      emit(GetDashboardDataSuccess(data: data));
    } catch (e) {
      emit(UpdateStatusError(error: e.toString()));
    }
  }

  FutureOr<void> _mapAppLaunchToState(
      CheckAttendance event, Emitter<DashboardState> emit) async {
    try {
      emit(AppLaunchLoading(message: "Launching App.."));

      var response = await dashboardService.appLaunch();
      if (response.lastAttendance == "check_in") {
        globalStorage.saveCheckIn(isCheckedIn: true);
      }
      if (response.lastAttendance == "check_out") {
        globalStorage.saveCheckIn(isCheckedIn: false);
      }
      print("appLaunchResponse  ------  " + response.toJson().toString());
      emit(AppLaunchSuccess(data: response));
    } catch (e) {
      emit(AppLaunchError(error: e.toString()));
    }
  }
}
