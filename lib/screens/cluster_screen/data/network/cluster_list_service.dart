import 'package:dio/dio.dart';
import 'package:janitor/core/network/api_constant.dart';
import 'package:janitor/core/network/dio_client.dart';
import 'package:janitor/screens/cluster_screen/data/model/Cluster_model.dart';
import 'package:janitor/screens/issue_list_screen/data/model/Issue_list_model.dart';
import 'package:janitor/screens/task_list/data/model/create_task_model.dart';
import 'package:janitor/screens/task_list/data/model/task_list_model.dart';

class ClusterListService {
  final DioClient dio;
  const ClusterListService({required this.dio});

  Future<List<ClusterModel>> getAllCluster() async {
    try {
      var response = await dio.get(
        APIConstants.CLUSTER_LIST,
        options: Options(extra: {"auth": true}),
      );
      List<ClusterModel> output = [];
      for (var item in response['results']) {
        output.add(ClusterModel.fromJson(item));
      }
      return output;
    } catch (e) {
      rethrow;
    }
  }
}
