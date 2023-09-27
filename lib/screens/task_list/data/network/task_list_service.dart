import 'package:dio/dio.dart';
import 'package:janitor/core/network/api_constant.dart';
import 'package:janitor/core/network/dio_client.dart';
import 'package:janitor/screens/task_list/data/model/create_task_model.dart';
import 'package:janitor/screens/task_list/data/model/task_list_model.dart';

class TaskListService {
  final DioClient dio;
  const TaskListService({required this.dio});

  Future<TaskListModel> getAllTasks({required int id}) async {
    try {
      var response = await dio.get(
        APIConstants.GET_ALL_TASKS,
        options: Options(extra: {"auth": true}),
        queryParameters: {
          "id": id,
        },
      );
      print(response['results'].toString() == '[]');
      if (response['results'].toString() == '[]') {
        return TaskListModel(templateId: id.toString(), tasks: []);
      }
      return TaskListModel.fromJson(response['results']);
    } catch (e) {
      rethrow;
    }
  }

  Future<String> submitTask({required CreateTaskModel createTaskModel}) async {
    try {
      var response = await dio.post(
        APIConstants.SUBMIT_TASKS,
        options: Options(extra: {"auth": true}),
        data: createTaskModel.toJson(),
      );
      return response['results'].toString();
    } catch (e) {
      rethrow;
    }
  }

  Future<String> updateStatus(
      {required String id, required String status}) async {
    try {
      var response = await dio.post(
        APIConstants.UPDATE_STATUS,
        data: {
          "id": id,
          "status": status,
        },
        options: Options(extra: {"auth": true}),
      );

      return response['results'].toString();
    } catch (e) {
      rethrow;
    }
  }
}
