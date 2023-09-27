import 'package:dio/dio.dart';
import 'package:janitor/core/network/api_constant.dart';
import 'package:janitor/core/network/dio_client.dart';
import 'package:janitor/screens/issue_list_screen/data/model/Issue_list_model.dart';
import 'package:janitor/screens/janitor_screen/data/model/Janitor_list_model.dart';
import 'package:janitor/screens/janitor_screen/data/model/Reassign_janitor_model.dart';
import 'package:janitor/screens/task_list/data/model/create_task_model.dart';
import 'package:janitor/screens/task_list/data/model/task_list_model.dart';

class JanitorListService {
  final DioClient dio;
  const JanitorListService({required this.dio});

  Future<List<JanitorListModel>> getAllJanitors(
      {required String? clusterId}) async {
    try {
      var response = await dio.get(
        APIConstants.JANITOR_LIST,
        options: Options(extra: {"auth": true}),
        queryParameters: {
          "cluster_id": clusterId,
        },
      );
      List<JanitorListModel> output = [];
      for (var item in response['results']) {
        output.add(JanitorListModel.fromJson(item));
      }
      return output;
    } catch (e) {
      rethrow;
    }
  }

  Future<ReassignJanitorModel> reAssignTaskToJanitor({
    required List<String> id,
    required String janitor_id,
  }) async {
    print("Data" + id.toString());
    try {
      FormData formData = FormData();

      /// Add image
      formData = FormData.fromMap({
        "id": id.toString(),
        "janitor_id": janitor_id,
      });

      var response = await dio.put(
        APIConstants.RE_ASSIGN_TASK,
        data: formData,
        options: Options(extra: {"auth": true}),
      );

      return ReassignJanitorModel.fromJson(response['results']);
    } catch (e) {
      rethrow;
    }
  }
}
