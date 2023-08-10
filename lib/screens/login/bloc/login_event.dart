part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class SendOTP extends LoginEvent {
  final String mobileNumber;
  const SendOTP({required this.mobileNumber});

  @override
  List<Object?> get props => [mobileNumber];
}

class VerifyOTP extends LoginEvent {
  final String otp;
  const VerifyOTP({required this.otp});

  @override
  List<Object?> get props => [otp];
}

// class GetCountryCodes extends LoginEvent {
//   @override
//   List<Object?> get props => [];
// }
