import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:get_storage/get_storage.dart';
import 'package:woloo_smart_hygiene/hygine_services/network/hygiene_service.dart';

import 'hygiene_service_event.dart';
import 'hygiene_service_state.dart';

class HygieneServiceBloc
    extends Bloc<HygieneServiceEvent, HygieneServiceState> {
  final box = GetStorage();
  final HygieneServiceApi hygieneServiceApi =
      HygieneServiceApi(dio: GetIt.instance());

  HygieneServiceBloc() : super(HygieneServiceInitial()) {
    on<HygieneServiceReq>(_getAllHygieneData);
    on<HygieneServiceReqById>(_getHygieneDataById);
  }

  FutureOr<void> _getAllHygieneData(
    HygieneServiceReq event,
    Emitter<HygieneServiceState> emit,
  ) async {
    try {
      emit(const HygieneServiceLoading(message: "Loading data..."));
      final response = await hygieneServiceApi.getAllHygieneData();

      debugPrint("requestId $response");
      print(response);
      // emit(HygieneServiceSuccess());
      emit(HygieneServiceSuccess(dashboardData: response));
    } catch (e) {
      emit(HygieneServiceError(error: e.toString()));
      debugPrint("Error in _getAllHygieneData service: $e");
    }
  }

  FutureOr<void> _getHygieneDataById(
    HygieneServiceReqById event,
    Emitter<HygieneServiceState> emit,
  ) async {
    try {
      emit(const HygieneServiceLoading(message: "Loading data..."));
      final response = await hygieneServiceApi.getHygieneDataById(
          productId: event.productId);

      debugPrint("requestId $response");
      print(response);
      // emit(HygieneServiceSuccess());
      emit(HygieneServiceProductSuccess(dashboardData: response));
    } catch (e) {
      emit(HygieneServiceError(error: e.toString()));
      debugPrint("Error in _getAllHygieneData service: $e");
    }
  }
}
