


import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_utils/src/extensions/export.dart';
import 'package:get_it/get_it.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:woloo_smart_hygiene/client_flow/screens/dashbaord/data/model/facility_model.dart';
import 'package:woloo_smart_hygiene/client_flow/screens/dashbaord/view/home.dart';
import '../../../../core/local/global_storage.dart';
import '../../../../screens/common_widgets/tab_widget.dart';
import '../../../../utils/app_color.dart';
import '../../../../utils/app_constants.dart';
import '../../../../utils/app_textstyle.dart';
import '../../../widgets/chart.dart';
import '../../../widgets/tabbar_widget.dart';
import '../../subcription/view/subcription.dart';
import '../bloc/dashboard_bloc.dart';
import '../bloc/dashboard_event.dart';
import '../bloc/dashboard_state.dart';

class HomeTabbar extends StatefulWidget {
  // List<Facility>  facility;
   HomeTabbar({super.key , });

  @override
  State<HomeTabbar> createState() => _HomeTabbarState();
}

class _HomeTabbarState extends State<HomeTabbar> with SingleTickerProviderStateMixin {
   TabController? tabController;
   ClientDashBoardBloc dashBoardBloc  = ClientDashBoardBloc();
   Map<String, dynamic>? decodedToken;
   GlobalStorage globalStorage = GetIt.instance();
   List<Facility> facility = [];
   dynamic planId;





    @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var some =   globalStorage.getClientToken();
    // tabController =  TabController(length: widget.facility.length, vsync: this);

    String clintId = globalStorage.getClientId();
    dashBoardBloc.add( GetAllFacilityEvent(
        clientId: int.parse(clintId)
    ) );

    // tabController =  TabController(length:2, vsync: this);

    decodedToken = JwtDecoder.decode(some);

                              // String clintId = globalStorage.getClientId();
        
        
                                        dashBoardBloc.add( SubcriptionEvent(
                                            id: int.parse(clintId)
                                        ) );




    // facality();

    // print("facilty  lent ${widget.facility!.length}");
     // print("controller lent ${tabController!.length}");


  }




  @override
  Widget build(BuildContext context) {
    // print("facilty  lent ${widget.facility!.length}");
    return
           BlocConsumer(
             bloc: dashBoardBloc,
             listener: (context, state) {


               print("state in tabar $state ");

               if ( state is DashboarLoading  ){

                 EasyLoading.show(status: state.message);
               }

               if( state is GetAllFacility ){

                 EasyLoading.dismiss();
                 // dashBoardBloc.add( SubcriptionEvent(
                 //     id: decodedToken!["id"]
                 // ) );


                 facility = state.facilityModel!.results!.facilities!;

                 facility.insert(0,  Facility(
                   facilityName: "Add Facility/Task",
                   id: 0,));
                  // facility.add(
                  //   Facility(
                  //     facilityName: "Add Facility",
                  //     id: 0,
                  //   )
                  // );
                 tabController =  TabController(length: facility.length, vsync: this);
                 // setState(() {
                 tabController!.animateTo(1);
                 //
                 // });

               }
                     if(state is Subcription ){
                                  EasyLoading.dismiss();
 
                             planId =   globalStorage.getPlanId();
                             
                              // state.subscriptionModel!.results!.planId;
                        // taskModel =  state.taskModel;
                                  }

               if(state is DashboarError  ){
                 EasyLoading.dismiss();
                 EasyLoading.showError( state.error);

               }

             },
             builder: (context , state) {
               return

                 tabController   ==  null  ?
                  Container()
                 :
                 Column(
                        // mainAxisSize: MainAxisSize.min,
                                    children: [

                                      SizedBox(
                                        height: 10.h,
                                      ),
                                       SizedBox(
                                         width: MediaQuery.of(context).size.width/1.2,
                                         child: TabBar(
                                           indicatorColor: AppColors.backgroundColor,
                                          padding: EdgeInsets.zero,
                                         indicatorPadding: EdgeInsets.zero,
                                         indicatorSize: TabBarIndicatorSize.label,
                                         labelPadding: const EdgeInsets.only(right: 0, left: 8 ),

                                         //  labelColor:AppColors.buttonBgColor ,
                                           tabAlignment: TabAlignment.start,

                                           isScrollable: true,
                                             labelStyle:               AppTextStyle
                                             .font10bold
                                             .copyWith(
                                                color: AppColors.black,
                                         // color: AppColors.buttonBgColor,
                                         ),
                                             // physics: NeverScrollableScrollPhysics(),
                                           controller: tabController,
                                                 tabs:
                                                  facility.map((e) => Tab(
                                                    // child: Icon( Icons.add),
                                                    
                                                    // icon: Icon(Icons.home),


                                                    icon: GestureDetector(
                                                      onTap: (){ 
                                                        print("object");
                                                        if(e.id == 0){
                                                          print("object");
                                                            if( planId == null ){
                                                               showModalBottomSheet(
                                                                backgroundColor: Colors.transparent,
                                                                // isScrollControlled: true,
                                                                context: context, 
                                                               
                                                               builder:(context) {
                                                                  return  SubcriptionScreen(
                                                                    dashBoardBloc: dashBoardBloc,
                                                                    isfromFacility: false,
                                                                  );
                                                               },
                                                               
                                                               );

                                                  //   Navigator.of(context).push( MaterialPageRoute(builder: (context) {
                                                  //  return const SubcriptionScreen();
                                                  //     }, ) );

                                                  }else{

                                                          Navigator.of(context).push( MaterialPageRoute(builder: (context) {
                                                            return const Home(
                                                              isFromDashboard: true,
                                                            );
                                                          }, ) );

                                              }
                                                          

                                                     
                                                        }
                                                        else{
                                                          tabController!.animateTo(facility.indexOf(e));
                                                        }
                                                      },
                                                      child: TabbarWidget(
                                                        id: e.id,
                                                        title: e.facilityName,

                                                      ),
                                                    ),
                                                  )).toList(),
                                         
                                               ),
                                       ),
                                      Expanded(
                                        // flex: 1,
                                       // height: MediaQuery.of(context).size.height/2.1,
                    child: TabBarView(
                      // viewportFraction: 3,
                      physics: const NeverScrollableScrollPhysics(),
                      controller: tabController,
                          children:
                          facility.map((e) =>
                                Charts(
                                  facilityId: e.id,
                                )

                          ).toList(),
                        ),
                  ),
                              ]
                                  );
             }
           );
  }
}
