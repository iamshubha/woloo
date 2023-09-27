import 'package:dio/dio.dart';
import 'package:janitor/core/network/api_constant.dart';
import 'package:janitor/core/network/dio_client.dart';
import 'package:janitor/screens/issue_list_screen/data/model/Issue_list_model.dart';
import 'package:janitor/screens/task_list/data/model/create_task_model.dart';
import 'package:janitor/screens/task_list/data/model/task_list_model.dart';

class IssueListService {
  final DioClient dio;
  const IssueListService({required this.dio});

  Future<List<IssueListModel>> getAllTasks({required int supervisorId}) async {
    try {
      var response = await dio.get(
        APIConstants.GET_ALL_ISSUES,
        options: Options(extra: {"auth": true}),

      );
      List<IssueListModel> output = [];
      for (var item in response['results']) {
        output.add(IssueListModel.fromJson(item));
      }
      return output;
    } catch (e) {
      rethrow;
    }
  }

}
