import 'package:dio/dio.dart';

import '../../../../../core/network/api_constant.dart';
import '../../../../../core/network/dio_client.dart';
import '../model/coins_model.dart';
import '../model/order_model.dart';

class SubcriptionService {
  final DioClient dio;
  const SubcriptionService({required this.dio});

  Future<OrderModel> creatOrder({

  required String clientId
   
   }) async {
    try {

      var response = await dio.post(
          options:  Options(extra: {"auth": true, "isSupervisor": true }),
        APIConstants.CREATE_OREDER,
        data:
      {
      "items": [
        {
            "item_type": "plan",
            "qty": 1,
            "item_id": 5
        }
         ],
      "client_id": clientId
    }
      );


       return OrderModel.fromJson(response);

    } catch (e) {
        print("erroeee$e");
      rethrow;
    }
  }



 Future<CoinsModel> getTask(
 
  // required String category,

) async {
   
  try {
      

      CoinsModel coinsModel;


 
    var response = await dio.get(
      APIConstants.GET_USER_COINS,
      
      options:  Options(extra: {"auth": true, "isSupervisor": true}),
    );


    coinsModel = CoinsModel.fromJson(response);
     

   return coinsModel;
  } catch (e) {
    rethrow;
  }
}







}
