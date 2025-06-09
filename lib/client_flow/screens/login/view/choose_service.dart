


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:woloo_smart_hygiene/client_flow/utils/client_images.dart';
import 'package:woloo_smart_hygiene/screens/common_widgets/image_provider.dart';
import 'package:woloo_smart_hygiene/utils/app_textstyle.dart';

import '../../../../core/local/global_storage.dart';
import '../../../../janitorial_services/screens/host_dashboard_screen.dart';
import '../../../../utils/app_color.dart';
import '../../../../utils/app_images.dart';
import '../../../widgets/CustomButton.dart';
import '../../dashbaord/bloc/dashboard_bloc.dart';
import '../../dashbaord/bloc/dashboard_event.dart';
import '../../dashbaord/bloc/dashboard_state.dart';
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
      Duration difference = const Duration();
      String? planId;
 

   @override
  void initState() {
    // TODO: implement initState
    super.initState();


      var clientId =   globalStorage.getClientId();


       dashBoardBloc.add(SubcriptionEvent(id:  int.parse(clientId)));

    //      var some =   globalStorage.getClientToken();

    //   decodedToken = JwtDecoder.decode(some);

    //  dashBoardBloc.add( ClientEvent(
    //   id: decodedToken!["id"]
    //  ) );
     

  }


  @override
  Widget build(BuildContext context) {
    return  
    
    
     Scaffold(
      backgroundColor: AppColors.backgroundColor,
      // appBar: AppBar(
      //   backgroundColor: AppColors.backgroundColor,
      // ),
      body: 
      
      BlocConsumer(
        bloc: dashBoardBloc,
        listener: (context, state) {
           
                 if ( state is DashboarLoading  ){
      
                   EasyLoading.show(status: state.message);
                 }


                 if( state is Subcription ){
                     planId =
                     
                      // "0";
                     
                     globalStorage.getPlanId();
                      print("plan id $planId");


                            // dashBoardBloc.add( GetAllFacilityEvent(
                            //     clientId: int.parse(globalStorage.getClientId())
                            // ) );

       

                             DateTime currentDate = DateTime.now();
                               // YYYY-MM-DD format
                             // DateTime dateTime = DateTime.parse(dateString);
                             DateTime futureDate =   state.subscriptionModel!.results!.expiryDate!; // Example future date
       
                               print('Difference: $futureDate days');
                              difference = 
                              
                              //  Duration(days: 0 ) ;
                              
                              futureDate.difference(currentDate);
       
                             print('Difference: ${difference.inDays} days');
       
                           EasyLoading.dismiss();

                           if (difference.inDays == 0 && planId == "0") {
                            
                             showDialog(
                              barrierDismissible: false,
                              context: context, builder:
                              (context) {
                                return 
                                 PopScope(
                                  canPop: false,
                                   child: AlertDialog(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(60),
                                    ),
                                    
                                    backgroundColor: AppColors.white,
                                    // title:  Center(
                                    //   child: Text("Your Free Subscription has expired",
                                    //    style: AppTextStyle.font20bold,
                                    //    textAlign: TextAlign.center,
                                    //   ),
                                    // ),
                                    content:
                                    SingleChildScrollView(
                                      child: ListBody(
                                        children: <Widget>[
                                           CustomImageProvider(
                                            image: ClientImages.warning,
                                            width: 86.w,
                                            height: 86.h,
                                           ),
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                          Text(
                                            textAlign: TextAlign.center,
                                            "Extend your trial period for the next 15 days. Kindly create the facility.",
                                           style: AppTextStyle.font18bold,
                                          ),
                                          SizedBox(
                                            height: 20.h,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                          var clientId =   globalStorage.getClientId();

                                          dashBoardBloc.add(ExpiryEvent(clientId: int.parse(clientId) , days: 15));
                                              // showModalBottomSheet(
                                              //   backgroundColor: Colors.transparent,
                                              //   context: context, builder:
                                              //  (context) {
                                              //     return 
                                              //      SubcriptionScreen(
                                              //       dashBoardBloc: dashBoardBloc,
                                              //       isfromFacility: true,
                                              //       facilityId:facility[1].id,

                                              //     );                                             
                                              //  },
                                              //  );
                                            },
                                            child: const Custombutton(
                                              width: 300,
                                              text: "Extend Now",
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                                                   ),
                                 );
                              },
                             );
                       
                           }

                           
                            
                   // gender = state.tasklist;



                 }

                  if (state is ExtendExpiry) {

                           EasyLoading.dismiss(); 
                           Navigator.of(context).pop();
    
                  }

                 if(state is DashboarError  ){
                   EasyLoading.dismiss();
                   EasyLoading.showError( state.error);
       
                 }

          
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric( horizontal: 16),
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.center,
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                 const SizedBox(
                   height: 120,
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
                     padding: const EdgeInsets.symmetric(vertical: 25 , horizontal: 22),
                    // height: 165.h,
                    decoration: BoxDecoration(
                      color: AppColors.white,
                        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues( alpha: 0.2), // Shadow color
            spreadRadius: 1, // How wide the shadow should spread
            blurRadius: 10, // The blur effect of the shadow
            offset: const Offset(0, 5), // Shadow offset, with y-offset for bottom shadow
          ),
              ],
                      
                      borderRadius:  BorderRadius.circular(30)
            
                    ),
          
                    child:  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
          
                      children: [
            
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          // mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                       
                            Row(
                              children: [
                                Text("TASQ",
                                style: AppTextStyle.font20bold.copyWith(
                                  fontWeight: FontWeight.bold
                                ),
                                ),
                               Text("MASTER",
                                style: AppTextStyle.font20,
                                ),
                              ],
                            ),
                             const SizedBox(
                               height: 10,
                             ),
          
                            Text(
                              // textAlign: TextAlign.center,
                              "Monitor your hygiene with Woloo’s",
                              style: AppTextStyle.font12bold.copyWith(
                                color: AppColors.greyBorder
                              ),
                            ),
                             const SizedBox(
                              height: 5,
                            ),
                               Text(
                              // textAlign: TextAlign.center,
                              "Smart Hygiene Technology Service.",
                              style: AppTextStyle.font12bold.copyWith(
                                color: AppColors.greyBorder
                              ),
                            ),
                            const SizedBox(
                              height: 14,
                            ),
          
          
                            GestureDetector(
                              onTap: () {
                                
                                  Navigator.of(context).push( MaterialPageRoute(builder:  (context) {
                                     return const Home(
                                      isFromDashboard: false,
                                     );
                                  }, ));
          
                              },
                              child: Container(
                                width: 178,
                                height: 38,
                                decoration: BoxDecoration(
                                    boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withValues( alpha: 0.2), // Shadow color
                                      spreadRadius: 1, // How wide the shadow should spread
                                      blurRadius: 10, // The blur effect of the shadow
                                      offset: const Offset(0, 5), // Shadow offset, with y-offset for bottom shadow
                                    ),
                                  ],
                                  color: const Color(0xffFFEB00),
                                  borderRadius: BorderRadius.circular(6)
                                  
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                              
                                                       Text("Explore",
                                                             style: AppTextStyle.font16bold.copyWith(
                                                               color: AppColors.black
                                                             ),
                                                            ) ,
                              
                                  CustomImageProvider(
                                    image: ClientImages.arrow,
                                    width: 34,
                                   ),
                              
                                  ],
                                ),
                              ),
                            )
                            
                            //  ElevatedButton.icon(
                            //    style: ElevatedButton.styleFrom(
                            //     // fixedSize: Size(171, 35),
          
                            //      backgroundColor: AppColors.buttonYellowColor,
                            //      shape: RoundedRectangleBorder(
                            //        borderRadius: BorderRadius.circular(12), // <-- Radius
                            //      ),
                            //    ),
          
                            //    iconAlignment: IconAlignment.end,
          
                            //      icon: CustomImageProvider(
                            //       image: ClientImages.arrow,
                            //       width: 34,
                            //      ),
          
                                 
                            //      ///const Icon(Icons.arrow_forward,
                            //     //  color:  AppColors.black,
                            //     //  size: 34,
                            //     //  ),
                            //      onPressed: (){
                            //       Navigator.of(context).push( MaterialPageRoute(builder:  (context) {
                            //          return const Home(
                            //           isFromDashboard: false,
                            //          );
                            //       }, ));
                            //      }, label: Text("Explore",
                            //                                style: AppTextStyle.font16bold.copyWith(
                            //                                  color: AppColors.black
                            //                                ),
                            //                               ) )
          
                          ],
                        ),
                        CustomImageProvider(
                          image:  AppImages.dashboard,
                          height: 119,
                          width: 55,
                        )
            
                      ],
                    ),
                   ),
                   
              //            const SizedBox(
              //             height: 25,
              //            ),
          
                       
              //            Container(
              //              padding: const EdgeInsets.symmetric(vertical: 25 , horizontal: 22),
              //             // height: 165.h,
              //             decoration: BoxDecoration(
              //               color: AppColors.white,
              //                 boxShadow: [
              //   BoxShadow(
              //     color: Colors.black.withValues( alpha: 0.2), // Shadow color
              //     spreadRadius: 1, // How wide the shadow should spread
              //     blurRadius: 10, // The blur effect of the shadow
              //     offset: const Offset(0, 5), // Shadow offset, with y-offset for bottom shadow
              //   ),
              // ],         
              //               borderRadius:  BorderRadius.circular(30)
              //             ),
          
              //             child:  Row(
              //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //               crossAxisAlignment: CrossAxisAlignment.center,
          
              //               children: [
            
              //                 Column(
              //                   crossAxisAlignment: CrossAxisAlignment.start,
              //                   // mainAxisAlignment: MainAxisAlignment.start,
              //                   children: [
                       
              //                     Row(
              //                       children: [
              //                         Text("Host ",
              //                         style: AppTextStyle.font20bold.copyWith(
              //                           fontWeight: FontWeight.bold
              //                         ),
              //                         ),
              //                        Text("Dashboard",
              //                         style: AppTextStyle.font20bold,
              //                         ),
              //                       ],
              //                     ),
              //                      const SizedBox(
              //                        height: 10,
              //                      ),
          
              //                     Text(
              //                       // textAlign: TextAlign.center,
              //                       "Monitor your restaurant walk-in’s",
              //                       style: AppTextStyle.font12bold.copyWith(
              //                         color: AppColors.greyBorder
              //                       ),
              //                     ),
              //                      const SizedBox(
              //                       height: 5,
              //                     ),
              //                        Text(
              //                       // textAlign: TextAlign.center,
              //                       "through Woloo and collect rewards!.",
              //                       style: AppTextStyle.font12bold.copyWith(
              //                         color: AppColors.greyBorder
              //                       ),
              //                     ),
              //                     const SizedBox(
              //                       height: 14,
              //                     ),
          
          
              //                     GestureDetector(
              //                       onTap: () {
                                
              //                           Navigator.of(context).push( MaterialPageRoute(builder:  (context) {
              //                              return const HostDashboard(
              //                               // isFromDashboard: false,
              //                              );
              //                           }, ));
          
              //                       },
              //                       child: Container(
              //                         width: 178,
              //                         height: 38,
              //                         decoration: BoxDecoration(
              //                             boxShadow: [
              //                             BoxShadow(
              //                               color: Colors.black.withValues( alpha: 0.2), // Shadow color
              //                               spreadRadius: 1, // How wide the shadow should spread
              //                               blurRadius: 10, // The blur effect of the shadow
              //                               offset: const Offset(0, 5), // Shadow offset, with y-offset for bottom shadow
              //                             ),
              //                           ],
              //                           color: const Color(0xffFFEB00),
              //                           borderRadius: BorderRadius.circular(6)
                                  
              //                         ),
              //                         child: Row(
              //                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //                           children: [
                              
              //                                                Text("Explore",
              //                                                      style: AppTextStyle.font16bold.copyWith(
              //                                                        color: AppColors.black
              //                                                      ),
              //                                                     ) ,
                              
              //                           CustomImageProvider(
              //                             image: ClientImages.arrow,
              //                             width: 34,
              //                            ),
                              
              //                           ],
              //                         ),
              //                       ),
              //                     )
                            
              //                     //  ElevatedButton.icon(
              //                     //    style: ElevatedButton.styleFrom(
              //                     //     // fixedSize: Size(171, 35),
          
              //                     //      backgroundColor: AppColors.buttonYellowColor,
              //                     //      shape: RoundedRectangleBorder(
              //                     //        borderRadius: BorderRadius.circular(12), // <-- Radius
              //                     //      ),
              //                     //    ),
          
              //                     //    iconAlignment: IconAlignment.end,
          
              //                     //      icon: CustomImageProvider(
              //                     //       image: ClientImages.arrow,
              //                     //       width: 34,
              //                     //      ),
          
                                 
              //                     //      ///const Icon(Icons.arrow_forward,
              //                     //     //  color:  AppColors.black,
              //                     //     //  size: 34,
              //                     //     //  ),
              //                     //      onPressed: (){
              //                     //       Navigator.of(context).push( MaterialPageRoute(builder:  (context) {
              //                     //          return const Home(
              //                     //           isFromDashboard: false,
              //                     //          );
              //                     //       }, ));
              //                     //      }, label: Text("Explore",
              //                     //                                style: AppTextStyle.font16bold.copyWith(
              //                     //                                  color: AppColors.black
              //                     //                                ),
              //                     //                               ) )
          
              //                   ],
              //                 ),
              //                 Center(
              //                   child: CustomImageProvider(
              //                     image:  ClientImages.host,
              //                     height: 89,
              //                     width: 80,
              //                   ),
              //                 )
            
              //               ],
              //             ),
              //            )
            
              ],
            ),
          );
        }
      ),
    );
  }
}