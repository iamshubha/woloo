


import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:woloo_smart_hygiene/screens/common_widgets/image_provider.dart';
import 'package:woloo_smart_hygiene/utils/app_textstyle.dart';

import '../../../../core/local/global_storage.dart';
import '../../../../utils/app_color.dart';
import '../../../../utils/app_images.dart';
import '../../dashbaord/bloc/dashboard_bloc.dart';
import '../../dashbaord/bloc/dashboard_event.dart';
import '../../dashbaord/view/dashboard.dart';
import '../../dashbaord/view/home.dart';

class ChooseService extends StatefulWidget {
  const ChooseService({super.key});

  @override
  State<ChooseService> createState() => _ChooseServiceState();
}

class _ChooseServiceState extends State<ChooseService> {


  ClientDashBoardBloc dashBoardBloc  = ClientDashBoardBloc();
    GlobalStorage globalStorage = GetIt.instance();
    Map<String, dynamic>? decodedToken;
 

   @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //      var some =   globalStorage.getClientToken();

    //   decodedToken = JwtDecoder.decode(some);

    //  dashBoardBloc.add( ClientEvent(
    //   id: decodedToken!["id"]
    //  ) );
     

  }


  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric( horizontal: 16),
        child: Column(
          children: [
             const SizedBox(
               height: 190,
             ),
              CustomImageProvider(
                image: AppImages.whiteLogo,
                width: 178.w,
                height: 127.h,
              ),
             const  SizedBox(
                height: 50,
               ),
        
               Container(
                 padding: EdgeInsets.symmetric(vertical: 25 , horizontal: 25),
                // height: 165.h,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  
                  borderRadius:  BorderRadius.circular(30)
        
                ),

                child:  Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
        
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                   
                        Text("TASKMASTER",
                        style: AppTextStyle.font20bold,
                        ),
                         SizedBox(
                           height: 10,
                         ),

                        Text(
                          // textAlign: TextAlign.center,
                          "Monitor your hygiene withWoloo’s\nSmart Hygiene Technology Service.",
                          style: AppTextStyle.font12bold.copyWith(
                            color: AppColors.greyBorder
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        
                         ElevatedButton.icon(
                           style: ElevatedButton.styleFrom(
                             backgroundColor: AppColors.buttonYellowColor,
                             shape: RoundedRectangleBorder(
                               borderRadius: BorderRadius.circular(12), // <-- Radius
                             ),
                           ),
                           iconAlignment: IconAlignment.end,
                             icon: const Icon(Icons.arrow_forward,
                             color:  AppColors.black,
                             size: 34,
                             ),
                             onPressed: (){
                              Navigator.of(context).push( MaterialPageRoute(builder:  (context) {
                                 return const Home(
                                  isFromDashboard: false,
                                 );
                              }, ));
                             }, label: Text("Explore",
                          style: AppTextStyle.font16bold.copyWith(
                            color: AppColors.black
                          ),
                         ) )
                      ],
                    ),
                    CustomImageProvider(
                      image:  AppImages.dashboard,
                      height: 119,
                      width: 55,
                    )
        
                  ],
                ),
               )
        
          ],
        ),
      ),
    );
  }
}