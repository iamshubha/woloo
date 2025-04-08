


import 'package:equatable/equatable.dart';

abstract class SignupEvent extends Equatable {
  const SignupEvent();
}


class CreateClientEvent extends SignupEvent {
  final String mobileNumber;
  final String name;
  final String email;
  final String password;
  final String address;
  final String city;
  final String pincode;
  const CreateClientEvent({
    required this.mobileNumber,
    required this.email,
    required this.name,
    required this.password,
    required this.address,
    required this.city,
    required this.pincode,

  });

  @override
  List<Object?> get props => [
    mobileNumber,
    email,
    name,
    password
    ];
}


class Signup extends SignupEvent {
  final String mobileNumber;
  final String name;
  final String email;
  final String password;
  final int clientTypeId;
  final String address;
  final String city;
  final String pincode;

  const Signup({
    required this.mobileNumber,
    required this.email,
    required this.name,
    required this.password,
    required this.clientTypeId,
    required this.address,
    required this.city,
    required this.pincode,
  });

  @override
  List<Object?> get props => [
    mobileNumber,
    email,
    name,
    password,
    clientTypeId,
    address,
    city,
    pincode,
  ];
}



class Login extends SignupEvent {
  final String email;
  final String password;
  const Login({ required this.email,  required this.password});

  @override
  List<Object?> get props => [
    email,
    password
    ];
}


