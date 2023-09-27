import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:janitor/screens/task_list/data/model/create_task_model.dart';

abstract class JanitorsListEvent extends Equatable {
  const JanitorsListEvent();
}

class GetAllJanitors extends JanitorsListEvent {
  final String? cluster_id;

  const GetAllJanitors({this.cluster_id});

  @override
  List<Object?> get props => [cluster_id, Random().nextInt(100)];
}

class ReassignTask extends JanitorsListEvent {
  final List<String> id;
  final String janitor_id;

  const ReassignTask({
    required this.id,
    required this.janitor_id,
  });

  @override
  List<Object?> get props => [id, janitor_id, Random().nextInt(100)];
}
