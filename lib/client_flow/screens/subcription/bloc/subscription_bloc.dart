
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import '../../../../core/network/error_handler.dart';
import '../data/network/subcription_service.dart';
import 'subscription_event.dart';
import 'subscription_state.dart';

class SubcriptionBloc extends Bloc<SubscriptionEvent, SubscriptionState> {

  final SubcriptionService subcriptionService = SubcriptionService(dio: GetIt.instance());
  var requestId = '';
  late int roleId;
  late int janitorId;
  //  List<UpdateTokenModel>? profileList;

  SubcriptionBloc() : super(SubscriptionInitial()) {
    // on<LoginEvent>((event, emit) {});
    on<CreateOrderEvent>(_mapCreateOrderToState);
    on<UserCoinsEvent>(_mapgetUserCoinsToState);

   // on<UpdateTokenOnVerifyOTP>(mapUpdateTokenToState);
  }

  FutureOr<void> _mapCreateOrderToState(
      CreateOrderEvent event, Emitter<SubscriptionState> emit) async {
    try {
      emit(const SubscriptionLoading(message: "Sending OTP..."));

      var response =
          await subcriptionService.creatOrder(
            clientId:  event.clientId
            );
      debugPrint("requestId $response");
       response;
      // debugPrint("requestId $requestId");
      emit(CreateOrder( 
        orderModel: response
       ));
    } catch (e) {
      emit(SubscriptionError(error:  ErrorHandler.handle(e).failure ));
    }
  }

    FutureOr<void> _mapgetUserCoinsToState(
      UserCoinsEvent event, Emitter<SubscriptionState> emit) async {
    try {
      emit(const SubscriptionLoading(message: "Loading..."));

      var response =
          await subcriptionService.getTask(
            );
      debugPrint("requestId $response");
       response;
      // debugPrint("requestId $requestId");
      emit(GetUserCoins( coinsModel: response
        
       // orderModel: response
       ));
    } catch (e) {
      emit(SubscriptionError(error:  ErrorHandler.handle(e).failure ));
    }
  }



}
