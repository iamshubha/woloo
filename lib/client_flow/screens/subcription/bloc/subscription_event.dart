


import 'package:equatable/equatable.dart';

abstract class SubscriptionEvent extends Equatable {
  const SubscriptionEvent();
}


class CreateOrderEvent extends SubscriptionEvent {
  final String clientId;
  // final String name;
  // final String email;
  // final String password;
  const CreateOrderEvent({required this.clientId , });

  @override
  List<Object?> get props => [
    clientId
    ];
}


class UserCoinsEvent extends SubscriptionEvent {
  // final CoinsModel  coinsModel;
  // final String name;
  // final String email;
  // final String password;
  const UserCoinsEvent( );

  @override
  List<Object?> get props => [
    // coinsModel
    ];
}






