import 'package:equatable/equatable.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:woloo_smart_hygiene/b2b_store/models/address.dart';

abstract class HygieneServiceEvent extends Equatable {
  const HygieneServiceEvent();
}

class HygieneServiceReq extends HygieneServiceEvent {
  @override
  List<Object?> get props => [];
}

class HygieneServiceReqById extends HygieneServiceEvent {
  final String productId;
  const HygieneServiceReqById({required this.productId});
  @override
  List<Object?> get props => [];
}
