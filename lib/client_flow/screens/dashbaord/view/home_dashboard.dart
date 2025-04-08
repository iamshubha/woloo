

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:woloo_smart_hygiene/screens/common_widgets/image_provider.dart';
import 'package:woloo_smart_hygiene/utils/app_color.dart';
import 'package:woloo_smart_hygiene/utils/app_constants.dart';
import 'package:woloo_smart_hygiene/utils/app_textstyle.dart';

import '../../../../core/local/global_storage.dart';
import '../../../../screens/login/view/login_screen.dart';
import '../../../../utils/app_images.dart';
import '../../subcription/view/subcription.dart';
import '../bloc/dashboard_bloc.dart';
import '../bloc/dashboard_event.dart';
import '../bloc/dashboard_state.dart';
import '../data/model/facility_model.dart';
import 'home_tabbar.dart';

class HomeDashboard extends StatefulWidget {
  const HomeDashboard({super.key});

  @override
  State<HomeDashboard> createState() => _HomeDashboardState();
}

class _HomeDashboardState extends State<HomeDashboard> {
  ClientDashBoardBloc dashBoardBloc  = ClientDashBoardBloc();
  Map<String, dynamic>? decodedToken;
  GlobalStorage globalStorage = GetIt.instance();
  List<Facility> facility = [];
  Duration difference = const Duration();

   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var some =   globalStorage.getToken();
    String clintId = globalStorage.getClientId();

     // dashBoardBloc.add( GetAllFacilityEvent(
     // clientId: int.parse(clintId)
     // ) );

     dashBoardBloc.add( SubcriptionEvent(
         id: int.parse(clintId)
     ) );

    decodedToken = JwtDecoder.decode(some);

    // dashBoardBloc.add( ClientEvent(
    //   id: decodedToken!["id"]
    // ) );
     
     
  }



  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      appBar: AppBar(
        leading: CustomImageProvider(
          image: AppImages.dashlogo,
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start
          ,
          // mainAxisAlignment: MainAxisAlignment.start,
          children: [
             Text(DashboardConst.helloSuperAdmin,
              style: AppTextStyle.font14bold,
             ),
            Text(DashboardConst.currentDateTime,
              style: AppTextStyle.font12,
            )
          ],
        ),
      ),

     body: SingleChildScrollView(
       child: Padding(
         padding: const EdgeInsets.symmetric( horizontal: 16),
         child: Column(
           children: [
       
             BlocConsumer(
               bloc: dashBoardBloc,
               listener: (context, state) {

                  print("state in dashbaord $state ");
       
                 if ( state is DashboarLoading  ){
      
                   EasyLoading.show(status: state.message);
                 }
       
                 if( state is Subcription ){

       

                             DateTime currentDate = DateTime.now();
                               // YYYY-MM-DD format
                             // DateTime dateTime = DateTime.parse(dateString);
                             DateTime futureDate =   state.subscriptionModel!.results!.expiryDate!; // Example future date
       
                              difference = futureDate.difference(currentDate);
       
                             print('Difference: ${difference.inDays} days');
       
                           EasyLoading.dismiss();
                   // gender = state.tasklist;



                 }

                  // if( state is GetAllFacility ){
                  //
                  //   EasyLoading.dismiss();
                  //   dashBoardBloc.add( SubcriptionEvent(
                  //       id: decodedToken!["id"]
                  //   ) );
                  //
                  //
                  //   facility = state.facilityModel!.results!.facilities!;
                  //   // setState(() {
                  //   //
                  //   // });
                  //
                  // }

                 if(state is DashboarError  ){
                   EasyLoading.dismiss();
                   EasyLoading.showError( state.error.message);
       
                 }
               },
               builder: (context, state) {
                 return
                   Column(
                     children: [

                       Text(
                         textAlign: TextAlign.center,
                         "Your Free Subscription shall end in ${difference.inDays} Days.",
                         style: AppTextStyle.font13.copyWith(
                             color: AppColors.textgreyColor
                         ),
                       ),
                       GestureDetector(
                         onTap:(){
                             Navigator.of(context).push( MaterialPageRoute(builder: (context) {
                               return const SubcriptionScreen();
                             }, ) );
                         },
                         child: Text(
                           textAlign: TextAlign.center,
                           DashboardConst.renew,
                           style: AppTextStyle.font13.copyWith(
                               color: AppColors.textgreyColor,
                              decoration: TextDecoration.underline,
                           ),
                         ),
                       ),
                     ],
                   );
               },
             ),
       
       
       
             Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                 Text(DashboardConst.dashboardOverview,
                  style: AppTextStyle.font20bold,
                 ),
       
                 GestureDetector(
                  onTap: () {
                      Navigator.of(context).push( MaterialPageRoute(builder: (context) {
                        return const LoginScreen();
                      }, ) );
                    //  Navigator.pushNamed(context, AppRoutes.clientDashboard);
        
                    },
                 
                   child: Container(
                     width: 40,
                     height: 40,
                     decoration: BoxDecoration(
                       color: AppColors.white,
                       borderRadius: BorderRadius.circular(12),
                       boxShadow: [
                         BoxShadow(
                           color: Colors.black
                               .withValues(alpha:0.2), // Shadow color
                           spreadRadius:
                           1, // How wide the shadow should spread
                           blurRadius:
                           10, // The blur effect of the shadow
                           offset: const Offset(0,
                               0), // No offset for shadow on all sides
                         ),
                       ],
                     ),
                     child: Padding(
                       padding: const EdgeInsets.all(8.0),
                       child: CustomImageProvider(
                         // width: 22,
                         // height: 22,
                         image: AppImages.changeArrow,
                         fit: BoxFit.cover,
                       ),
                     ),
                   ),
                 )
       
                 // Icon(
                 //   Icons.ß
                 // )
       
               ],
             ),
               Container(
                 // width: MediaQuery.of(context).size.width/1,
                // flex: 2,
                 height: 700.w,
                 child:  HomeTabbar(
                  // facility: facility,
                 ))
       
           ],
         ),
       ),
     ),
    );
  }
}