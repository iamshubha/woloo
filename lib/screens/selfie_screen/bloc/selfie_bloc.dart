import 'dart:async';

import 'package:Woloo_Smart_hygiene/screens/selfie_screen/bloc/selfie_event.dart';
import 'package:Woloo_Smart_hygiene/screens/selfie_screen/bloc/selfie_state.dart';
import 'package:Woloo_Smart_hygiene/screens/selfie_screen/data/network/selfie_service.dart';
import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';

class SelfieBloc extends Bloc<SelfieEvent, SelfieState> {
  final SelfieService selfieService = SelfieService(dio: GetIt.instance());
  // String requestId = '';
  // List<DashboardModelClass> data = [];

  SelfieBloc() : super(UploadSelfieInitial()) {
    on<SelfieEvent>((event, emit) {});
    on<UploadSelfie>(_mapUploadSelfieToState);
  }

  FutureOr<void> _mapUploadSelfieToState(
      UploadSelfie event, Emitter<SelfieState> emit) async {
    try {
      emit(const UploadSelfieLoading(message: ""));

      var response = await selfieService.uploadSelfie(
        type: event.type,
        image: event.image,
        id: event.id,
        remarks: event.remarks,
      );
      
        Future.delayed( Duration( seconds: 2 ) );

    print("responseeee image  upload  ------  " + response);
      emit(UploadSelfieSuccessful());
    } catch (e) {
      emit(UploadSelfieError(error: e.toString()));
    }
  }
  
}


FutureOr<void>  _captureImage(){





  }
