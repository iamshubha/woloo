


import 'dart:math';

import 'package:dio/dio.dart';
import 'package:woloo_smart_hygiene/client_flow/screens/dashbaord/data/model/check_task_model.dart';
import 'package:woloo_smart_hygiene/client_flow/screens/dashbaord/data/model/client_model.dart';
import 'package:woloo_smart_hygiene/client_flow/screens/dashbaord/data/model/facility_model.dart';
import 'package:woloo_smart_hygiene/client_flow/screens/dashbaord/data/model/supervisor_model.dart';
import 'package:woloo_smart_hygiene/screens/task_list/data/model/task_list_model.dart';

import '../../../../../core/network/api_constant.dart';
import '../../../../../core/network/dio_client.dart';
import '../../../../../screens/report_issue_screen/data/model/facility_dropdown_model.dart';
import '../model/client_setup_model.dart';
import '../model/dashboard_task_model.dart';
import '../model/subscription_model.dart';
import '../model/task_model.dart';
import '../model/tasklist_model.dart';

class DashboardService {
  final DioClient dio;
  const DashboardService({required this.dio});



Future<ClientSetupModel> clientSetup({

  required String orgName,
  required String unitNo,
  required String locality,
  required String clientId,
   required  String address,
   String? building,
   String? floor,
   String? landmark,
   String? pincode,
  String? locationId,
  String? clusterId,
 required String? city

}) async {
  try {

     ClientSetupModel clientSetupModel;
    // Data payload with all parameters
    Map<String, dynamic> data =
    {
      "location": locality,
  "address": address,
  "city": city,
  "client_id": clientId,
  "facility_name": orgName,
  "cluster_id": "",
  "facility_type": "home",
  "pincode": pincode
  };
    // {
    //   "org_name": orgName,
    //   "unit_no": unitNo,
    //   "locality": locality,
    //   "location": locality,
    //   "address": address,
    //   "city": city,
    //   "building": "",
    //   "floor": "",
    //   "landmark": "",
    //   "pincode": pincode,
    //   "location_id": "sd" ?? "",  // Optional parameter with default value
    //   "cluster_id":  "",    // Optional parameter with default value
    //   "client_id": clientId,
    //   "facility_name": orgName,
    //   "facility_type": "Home"
    //
    // };


    var response = await dio.post(
      APIConstants.CLIENT_SETUP,
      data: data,
      options:  Options(extra: {"auth": true}),
    );

    clientSetupModel =  ClientSetupModel.fromJson(response);

    return clientSetupModel;
  } catch (e) {
    rethrow;
  }
}


 Future<SuperVisorModel> addUser({
 
  required String roleId,
  required String name,
  required String mobile,
  required String clientId,
           String? gender,
  required  List<int>? clusterId,
  

}) async {
  try {
      SuperVisorModel superVisorModel;
    // Data payload with all parameters

      FormData formData = FormData();

      formData = FormData.fromMap({
        "role_id": roleId,
        "first_name": name,
        "cluster_ids":clusterId.toString(),
        // "last_name": locality,
        "mobile": mobile,
        "gender": "male"
      });


    var response = await dio.post(
      APIConstants.ADD_USER,
      data: formData,
      options:  Options(extra: {"auth": true}),
    );

    superVisorModel =  SuperVisorModel.fromJson(response);
    // clientModel =  ClientModel.fromJson(response);

    return superVisorModel;
  } catch (e) {
    rethrow;
  }
}



 Future<List<TaskDropdownModel>> getTask({
 
  required String category,


}) async {
   
  try {
      // List<TaskListModel> output = [];
 
    var response = await dio.get(
      '${APIConstants.GET_TASK}?category=$category',
      
      options:  Options(extra: {"auth": true}),
    );


    //  output.add();

      List<TaskDropdownModel> output = [];
      for (var item in response['results']) {
           // print( "testing ${item["required_time"] = 15 }");
           item["required_time"] = 15;
           output.add(TaskDropdownModel.fromJson(item));
      }


   return output;
  } catch (e) {
    rethrow;
  }
}


Future<DashbaordModel> getTaskDashboard({
 
  required int facilityId,
  required String type,
  required String clientId,
  required int janitorId
}) async {
  try {
      
     DashbaordModel dashbaordModel;
    // Data payload with all parameters
    Map<String, dynamic> data = 
     {
    // "location_id": locationId,
    "type": type,
    "client_id": int.parse(clientId),
       "facility_id": facilityId,
       "janitor_id": janitorId
	};

    var response = await dio.post(
      APIConstants.GET_TASK_DASHBOARD,
      data: data,
      options:  Options(extra: {"auth": true}),
    );

  dashbaordModel =  DashbaordModel.fromJson(response);

    return dashbaordModel;
  } catch (e) {
    rethrow;
  }
}

Future<TaskModel> getAllJanitor({
 
  // required int locationId,
  // required String type,
  required int clientId,
}) async {
  try {
      
     TaskModel dashbaordModel;
    // Data payload with all parameters
    Map<String, dynamic> data =
    {
      // "pageIndex": 1,
      // "pageSize": 10,
      // "sort": {
      //     "order": "",
      //     "key": ""
      // },
      // "query": "",
      // "total": 1,
      "role_id": 1,
      // "client_id": clientId
    };
//     {
//     "pageIndex": 1,
//     "pageSize": 10,
//     "sort": {
//         "order": "",
//         "key": ""
//     },
//     "query": "",
//     "total": 1,
//     "role_id": 1,
//     "client_id": clientId
// };
  //    {
  //   "location_id": locationId,
  //   "type": type,
  //   "client_id": clientId
	// };

    var response = await dio.post(
      APIConstants.GET_ALL_USER,
      data: data,
      options:  Options(extra: {"auth": true}),
    );

  dashbaordModel =  TaskModel.fromJson(response);

   print("all janitor $dashbaordModel");

    return dashbaordModel;
  } catch (e) {
    rethrow;
  }
}



 Future<SubscriptionModel> getSubscriptionExpiry({
 
  required int id,

}) async {
  try {
      
     SubscriptionModel subscriptionModel;
    // Data payload with all parameters
 

    var response = await dio.get(
     "${APIConstants.SubscriptionExpiry}?id=$id",
      options:  Options(extra: {"auth": true}),
    );

     subscriptionModel =  SubscriptionModel.fromJson(response);

    return subscriptionModel;
  } catch (e) {
    rethrow;
  }
}




  Future<bool> assignTask({

    required int clientId,
    required String shiftTime,
    required List<int?> taskIds,
    required String estimatedTime,
    required List<Map<String, String>> taskTimes,
    required int janitorId,
  }) async {
    try {

      // DashbaordModel dashbaordModel;
      // Data payload with all parameters
      Map<String, dynamic> data =
      {
        "client_id": clientId,
        "shift_time": shiftTime,
        "task_ids":taskIds,
        "estimated_time": estimatedTime,
        "task_times": taskTimes,
        "janitor_id": janitorId
      };
      var response = await dio.post(
        APIConstants.ASSIGN_TASK,
        data: data,
        options:  Options(extra: {"auth": true}),
      );

      // dashbaordModel =  DashbaordModel.fromJson(response);

      return response["results"];
    } catch (e) {
      rethrow;
    }
  }




 Future<ClientModel> getClient({
 
  required int id,

}) async {
  try {
      
     ClientModel clientModel;
    // Data payload with all parameters
 

    var response = await dio.get(
     "${APIConstants.GET_CLIENT_ID}?user_id=$id",
      options:  Options(extra: {"auth": true}),
    );

     clientModel =  ClientModel.fromJson(response);

    return clientModel;
  } catch (e) {
    rethrow;
  }
}




  Future<FacilityModel> getFacility({

    required int clientId,
   
  }) async {
    try {
        FacilityModel facilityModel;
      // Data payload with all parameters
      Map<String, dynamic> data =
     {
    "client_id": clientId,
    "isAll": 1
    };
      var response = await dio.post(
        APIConstants.GET_ALL_FACILITY,
        data: data,
        options:  Options(extra: {"auth": true}),
      );

      facilityModel = FacilityModel.fromJson(response);
      // dashbaordModel =  DashbaordModel.fromJson(response);

      return facilityModel;
    } catch (e) {
      rethrow;
    }
  }


  Future<CheckTaskModel> checkTaskTime({

    required int janitorId,
    required String startTime,
    required String endTime,
   
  }) async {
    try {
        CheckTaskModel checkTaskModel;
      // Data payload with all parameters
      Map<String, dynamic> data =
     {
    "janitor_id": janitorId,
    "start_time": startTime,
    "end_time": endTime,
      };

      var response = await dio.post(
        APIConstants.CHECK_TASK_TIME,
        data: data,
        options:  Options(extra: {"auth": true}),
      );




      checkTaskModel = CheckTaskModel.fromJson(response);
        print("dsfsd  $checkTaskModel");
      // dashbaordModel =  DashbaordModel.fromJson(response);

      return checkTaskModel;
    } catch (e) {
       print(" check modelr ressssss $e");
      rethrow;
    }
  }



//  {
//     "location_id": 42,
//     "type": "today",
//     "client_id": "62578"
// 	}



}