import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:janitor/screens/task_list/data/model/create_task_model.dart';

abstract class ClusterListEvent extends Equatable {
  const ClusterListEvent();
}

class GetAllClusters extends ClusterListEvent {
  const GetAllClusters();

  @override
  List<Object?> get props => [];
}
