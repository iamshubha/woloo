

import 'package:dio/dio.dart';
import 'package:woloo_smart_hygiene/core/network/api_constant.dart';
import 'package:woloo_smart_hygiene/core/network/dio_client.dart';
import 'package:woloo_smart_hygiene/screens/login/data/model/send_otp.dart';
import 'package:woloo_smart_hygiene/screens/login/data/model/verify_otp_model.dart';

import '../../dashbaord/model/login_model.dart';

class SignupService {
  final DioClient dio;
  const SignupService({required this.dio});

  Future creatClient({
  required String phoneNumber,  
  required String name,
  required String email,
  required String password,
  required String address,
    required String city,
    required String pincode,
   
   }) async {
    try {
      var response = await dio.post(
        APIConstants.CREATE_CLIENT,
        data: {
          "name": name,
          "email": email,
          "password": password,
          "mobile": phoneNumber,
          "address": address,
          "city": city,
          "pincode":  pincode
        },
      );

      return response['results']["user_id"].toString();

    } catch (e) {
      rethrow;
    }
  }


  Future<bool> signUp({
     required String userId,
    required String mobileNumber,
  required String name,
  required String email,
  required String password,
  // required int clientUserId,
  required int clientTypeId,
  required String address,
  required String city,
  required String pincode,
    }) async {
    try {

      //
      var response = await dio.post(
        options:  Options(
          headers: {
            "x-api-key":  "k45GQj8FtKt0NR074UfFyvCEPAfJBzxY"
          },
        ),
        APIConstants.CLIENT_SIGNUP,
        data: {
          "client_user_id": userId,
          "client_name": name,
          "client_type_id":clientTypeId,
          "email":  email,
          "mobile": mobileNumber,
          "address": address,
          "city": city,
          "pincode":  pincode
        },

      );


      return response['success'];
    } catch (e) {
      rethrow;
    }
  }


  Future<LoginModel> login({
  required String email,
  required String password,
  // required int clientUserId,

    }) async {
    try {
      var response = await dio.post(
        APIConstants.CLIENT_LOGIN,
        data: {
          "email":  email,
          "password": password
        },
      );


      return LoginModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

}
