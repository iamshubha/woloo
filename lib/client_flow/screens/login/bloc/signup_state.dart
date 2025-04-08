import 'package:equatable/equatable.dart';

import '../../../../core/network/failure.dart';

abstract class SignUpState extends Equatable {
  const SignUpState();
}

class SignUpInitial extends SignUpState {
  @override
  List<Object> get props => [];
}

class SignUpLoading extends SignUpState {
  final String message;
  const SignUpLoading({required this.message});

  @override
  List<Object> get props => [];
}

class CreateClient extends SignUpState {

  @override
  List<Object> get props => [];
}

class RegisterUser extends SignUpState {
  @override
  List<Object> get props => [];
}

class LoginUser extends SignUpState {
  @override
  List<Object> get props => [];
}


class SignUpError extends SignUpState {
  final Failure error;
  const SignUpError({required this.error});

  @override
  List<Object> get props => [error];
}