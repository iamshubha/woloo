

import 'package:equatable/equatable.dart';
import 'package:woloo_smart_hygiene/client_flow/screens/dashbaord/data/model/check_task_model.dart';
import 'package:woloo_smart_hygiene/client_flow/screens/dashbaord/data/model/dashboard_task_model.dart';
import 'package:woloo_smart_hygiene/client_flow/screens/dashbaord/data/model/facility_model.dart';
import 'package:woloo_smart_hygiene/client_flow/screens/dashbaord/data/model/task_model.dart';
import 'package:woloo_smart_hygiene/screens/task_list/data/model/task_list_model.dart';

import '../../../../core/network/failure.dart';
import '../../../../screens/report_issue_screen/data/model/facility_dropdown_model.dart';
import '../data/model/client_setup_model.dart';
import '../data/model/subscription_model.dart';
import '../data/model/supervisor_model.dart';
import '../data/model/tasklist_model.dart';

abstract class DashboardState extends Equatable {
  const DashboardState();
}



class DashboarInitial extends DashboardState {
  @override
  List<Object> get props => [];
}

class DashboarLoading extends DashboardState {
  final String message;
  const DashboarLoading({required this.message});

  @override
  List<Object> get props => [];
}

class ClientSetUp extends DashboardState {
   ClientSetupModel clientSetupModel;
  ClientSetUp({ required this.clientSetupModel});
   
  @override
  List<Object> get props => [];
}

class AddUser extends DashboardState {
  @override
  List<Object> get props => [];
}

class Addjanitor extends DashboardState {
  final SuperVisorModel? superVisorModel;
  Addjanitor({ required this.superVisorModel});
  @override
  List<Object> get props => [superVisorModel!];
}

class GetTask extends DashboardState {
  final List<TaskDropdownModel> tasklist;
  const GetTask({required this.tasklist});
  @override
  List<Object> get props => [tasklist];
}


class DashbaordTask extends DashboardState {
  DashbaordModel? dashbaordModel;
  DashbaordTask({ required this.dashbaordModel});
  @override
  List<Object> get props => [dashbaordModel! ];
}

class Subcription extends DashboardState {
  SubscriptionModel? subscriptionModel;
  Subcription({ required this.subscriptionModel });
  @override
  List<Object> get props => [subscriptionModel!];
}

class AssignTask extends DashboardState {
  @override
  List<Object> get props => [];
}

class GetClient extends DashboardState {
  @override
  List<Object> get props => [];
}

class GetAllJanitor extends DashboardState {
  TaskModel? taskModel;
  GetAllJanitor({this.taskModel });

  @override
  List<Object> get props => [taskModel!];
}

class GetAllFacility extends DashboardState {
  FacilityModel? facilityModel;
  GetAllFacility({this.facilityModel });

  @override
  List<Object> get props => [facilityModel!];
}


class CheckTaskTime extends DashboardState {
  CheckTaskModel? checkTaskModel;
  CheckTaskTime({this.checkTaskModel});
  @override
  List<Object> get props => [checkTaskModel!];
}


class DashboarError extends DashboardState {
  final Failure error;
  const DashboarError({required this.error});

  @override
  List<Object> get props => [error];
}