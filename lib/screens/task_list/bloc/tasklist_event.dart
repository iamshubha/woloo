import 'package:equatable/equatable.dart';
import 'package:janitor/screens/task_list/data/model/create_task_model.dart';

abstract class TaskListEvent extends Equatable {
  const TaskListEvent();
}

class GetAllTask extends TaskListEvent {
  final int id;

  const GetAllTask({required this.id});

  @override
  List<Object?> get props => [id];
}

class SubmitTasks extends TaskListEvent {
  CreateTaskModel createTaskModel = CreateTaskModel();

  SubmitTasks({required this.createTaskModel});

  @override
  List<Object?> get props => [createTaskModel.toJson()];
}
