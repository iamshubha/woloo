part of 'core_bloc.dart';

abstract class CoreEvent extends Equatable {
  const CoreEvent();
}

class GetRBAC extends CoreEvent {
  @override
  List<Object?> get props => [];
}
