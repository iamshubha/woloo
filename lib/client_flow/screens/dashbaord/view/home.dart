

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_extra_fields/form_builder_extra_fields.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:get_it/get_it.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:time_picker_spinner/time_picker_spinner.dart';
import 'package:woloo_smart_hygiene/client_flow/screens/dashbaord/bloc/dashboard_state.dart';
import 'package:woloo_smart_hygiene/client_flow/screens/dashbaord/view/widget/congrats_dailog.dart';
import 'package:woloo_smart_hygiene/client_flow/widgets/CustomButton.dart';
import 'package:woloo_smart_hygiene/screens/common_widgets/image_provider.dart';

import '../../../../core/local/global_storage.dart';
import '../../../../screens/common_widgets/dropdown_dialogue.dart';
import '../../../../screens/common_widgets/multiselect_dropdown.dart';
// import '../../../../screens/report_issue_screen/data/model/facility_dropdown_model.dart';
import '../../../../utils/app_color.dart';
import '../../../../utils/app_constants.dart';
import '../../../../utils/app_images.dart';
import '../../../../utils/app_textstyle.dart';
import '../../../utils/client_images.dart';
import '../../../widgets/CustomTextField.dart';
import '../../../widgets/custom_dropdown.dart';
import '../../login/view/login_as.dart';
import '../../subcription/view/subcription.dart';
import '../bloc/dashboard_bloc.dart';
import '../bloc/dashboard_event.dart';
import '../controller/dashbaord_controller.dart';
// import '../data/model/facility_model.dart';
import '../data/model/facility_dropdown_model.dart';
import '../data/model/facility_model.dart';
import '../data/model/task_model.dart';
import '../data/model/tasklist_model.dart';
// import '../model/facility_model.dart';
import '../model/facility_model.dart';
import 'dashboard.dart';
import 'widget/add_time_dailog.dart';
import 'widget/buddy_list_dailog.dart';
import 'widget/select_buddy_dailog.dart';

class Home extends StatefulWidget {
 final bool? isFromDashboard;
  const Home({super.key, required this.isFromDashboard});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  ClientDashBoardBloc dashBoardBloc  = ClientDashBoardBloc();
     final TextEditingController  facilityController = TextEditingController();
     final TextEditingController  typeController = TextEditingController();
      TextEditingController  locationController = TextEditingController();
     final TextEditingController  nameController = TextEditingController();
     final TextEditingController  mobileController = TextEditingController();
     final TextEditingController  janNameController = TextEditingController();
     final TextEditingController  janMobileController = TextEditingController();
     final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
     final GlobalKey<DropdownSearchState> _facilityKey = GlobalKey<DropdownSearchState>();
    GlobalStorage globalStorage = GetIt.instance();

     final GlobalKey<DropdownSearchState> _clusterNameKey = GlobalKey<DropdownSearchState>();
     final  addSuperVisorKey = GlobalKey<FormState>();
     final  addJanitorKey = GlobalKey<FormState>();
     final  facilityKey = GlobalKey<FormState>();
          Map<String, dynamic>? decodedToken;
          TextEditingController controller = TextEditingController();
   int selectedIndex = 0;
     int selectedAdmin = 0;
     int selectedGender = 0;
    String? janitorGender;

  List<Facility> facilityList = [];

   List<TaskDropdownModel> facilityNames = [

   ];
     List<FacilityDropdownModel> facilitydropdownNames = [

   ];

   List<TaskDropdownModel> gender = [
     TaskDropdownModel(
         id: 1,
         facilityName: "Male"
     ),
     TaskDropdownModel(
         id: 1,
         facilityName: "Female"
     )
   ];
   int? clusterId;



   @override
  void initState() {
    // TODO: implement initState
    super.initState();

        var some =   globalStorage.getToken();


     decodedToken = JwtDecoder.decode(some);
         dashBoardBloc.add( ClientEvent(
      id: decodedToken!["id"]
    ) );

     
    debugPrint(" toeknm ${decodedToken!["id"]}");

  }

  @override
  Widget build(BuildContext context) {
    return   Padding(
      padding: const EdgeInsets.symmetric( horizontal: 10),
      child: SingleChildScrollView(
        child: Column(
          children: [
          const  SizedBox(
                height: 100,
               ),
        
            Text(DashboardConst.welcomeMessage,
              style: AppTextStyle.font32bold,
            ),
        
             CustomImageProvider(
              image:  ClientImages.taskMaster,
              width: 139,
              height: 119,
               color: AppColors.black,
             ),
        
               const  SizedBox(
                height: 30,
                 ),
        
                 CustomImageProvider(
              image:  AppImages.welcome,
              width: 332,
               height: 223,
             ),
        
                SizedBox(
                height: 30.h,
                 ),
        
        
                      //  const  SizedBox(
                      // height: 10,
                      //   ),
                     //
                     //  Text(DashboardConst.dashboardTitle,
                     //   style: AppTextStyle.font18bold,
                     // ),
                        const  SizedBox(
                        height: 20,
                        ),
        
                       Text(DashboardConst.onboardingMessage,
                        textAlign: TextAlign.center,
                        style: AppTextStyle.font14,
                      ),
        
                            const  SizedBox(
                           height: 30,
                             ),
                          BlocConsumer(
                             bloc: dashBoardBloc,
                             listener: (context, state) {
        
                                   print("dashboar $state ");
        
                                  if ( state is DashboarLoading  ){
        
                                         EasyLoading.show(status: state.message);
                                   }
        
                                  if (state is ClientSetUp  ) {
                                       EasyLoading.dismiss();
                                          String clientId =   globalStorage.getClientId();
                                      clusterId =     state.clientSetupModel.results.data.clusterId;
                                      
                                       dashBoardBloc.add(
                                             AddUserEvent(
                                              mobile: mobileController.text,
                                              name: nameController.text,
                                              roleId: "2",
                                              clientId: clientId,
                                              clusterId: [state.clientSetupModel.results.data.clusterId]
                                         )  );
                                        // adminBottomSheet();
        
                                  }
                                 if(state is AddUser ){
                                      String clientId =   globalStorage.getClientId();
        
                                   print("add user succcesfull");
                                    dashBoardBloc.add(
                                         AddJanitorEvent(
                                           mobile: janMobileController.text,
                                           name: janNameController.text,
                                           gender: janitorGender,
                                           roleId: "1",
                                           clientId: clientId,
                                           clusterId: [clusterId!]
                                         ));
        
                                   EasyLoading.dismiss();
                                 }
        
                                  if( state is Addjanitor ){
                                      print("add jantor succcesfull");
                                        String clientId =   globalStorage.getClientId();
                                      dashBoardBloc.add(
                                         AssignTaskEvent(clientId: int.parse(clientId),
                                             shiftTime: "${shiftTime!.hour}:${shiftTime!.minute}:00",
                                             taskIds: taksIds,
                                             estimatedTime: estimatedTime.toString(),
                                             taskTimes: dashController.taskTimes,
                                             janitorId: state.superVisorModel!.results!.data!.value!,
        
                                         ));
        
                                  }
        
                                  if( state is GetTask ){
                                    EasyLoading.dismiss();
                                    // gender = state.tasklist;
        
                                  }
        
                                  if( state is GetClient){
                                    EasyLoading.dismiss();
        
                                  }
        
        
                                   if( state is  AssignTask ){
                                     EasyLoading.dismiss();
        
                                    
        
        
        
        
                                      congratDailog();
                                    //  showDialog(context: context, builder:
                                    //   (context) {
                                    //      return CongratsDailog(buddyName: "dskjdfkj");
                                    //   },
                                    //  ).then((v){
                                    //    Navigator.of(context, rootNavigator: true).pop();
                                    //    Navigator.of(context, rootNavigator: true).pop();
                                    //    Navigator.of(context, rootNavigator: true).pop();
                                    //    Navigator.of(context, rootNavigator: true).pop();
                                    //    Navigator.of(context, rootNavigator: true).pop();
                                    //  } );
                                     
        
                                   }
        
        
                                  if(state is GetAllJanitor ){
        
                                    EasyLoading.dismiss();
        
                                     // state.taskModel.
        
                                    // facilityNames
        
                                    // showDialog(context: context, builder:
                                    //     (context) {
                                    //   return BuddyListDailog( taskModel: state.taskModel, );
                                    // },
                                    // );
                                    // taskModel =  state.taskModel;
        
                                  }
        
                                   if(state is GetAllFacility ){
        
                                     EasyLoading.dismiss();
                                     facilityList = state.facilityModel!.results!.facilities!;
        
                                     // facilityNames.
        
                                      // facilityList.map( ( e)=>  facilityList.add(  e.facilityName! )   );
        
                                     for (var item in facilityList ) {
                                        print(" fasfkljfas list ${item.id}");
                                       // print( "testing ${item["required_time"] = 15 }");
                                       // item["required_time"] = 15;
                                       facilitydropdownNames.add(FacilityDropdownModel(
        
                                         id: item.id,
                                         facilityName: item.facilityName,
                                         locationName: item.locationName
        
        
        
                                       ) );
        
                                     }
        
                                      print("falicit namessss $facilitydropdownNames ");
        
                                       // for( var facilit from facilityList ){
                                       //
                                       // }
        
                                   }

                                
        
        
        
        
                                   if(state is DashboarError  ){
                                     EasyLoading.dismiss();
                                     EasyLoading.showError( state.error.message);
        
                                   }
                                
                             },
                            builder:  (context, state) {
                                  print(" state $state");
                                  if( state is GetTask ){
        
                                    facilityNames = state.tasklist;
        
                                  }
        
                          return  
                           // Builder(
                             // builder: ( BuildContext builderContext) {
                                    
                                    widget.isFromDashboard == true ?
                          Column(children: [
        
                                    ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                     minimumSize:  const Size(190, 59),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12), // <-- Radius
                                    ),
                                  backgroundColor: AppColors.backgroundColor
        
                                ),
                                onPressed: (){

                                 
                                  //  else{
                                   dashBoardBloc.add( const GetTaskEvent(
                                      category: "Home"
                                  ) );
                                  // //
                                  facilityBottomSheet();

                                  //  }
                                  //  print("object ${ globalStorage.getClientId()}" );
                                  // janitorBottomSheet();
                          
                               
        
        
                                }, child: Text(DashboardConst.addNewFacility,
                                                      style: AppTextStyle.font20bold.copyWith(
                               color: AppColors.black
                                                      ),
                                                     ) ),
                                                     SizedBox(
                                                        height: 20.h,
                                                     ),
                                                             ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                     minimumSize:  const Size(190, 59),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12), // <-- Radius
                                    ),
                                  backgroundColor: AppColors.backgroundColor
        
                                ),
                                onPressed: (){
                                  //  print("object ${ globalStorage.getClientId()}" );
                                  // janitorBottomSheet();
                                  dashBoardBloc.add( const GetTaskEvent(
                                      category: "Home"
                                  ) );
                                  // //
                                  // facilityBottomSheet();
                                       selectBuddyDailog();
                           
        
        
                                }, child: Text(DashboardConst.addNewTask,
                                                      style: AppTextStyle.font20bold.copyWith(
                               color: AppColors.black
                                                      ),
                                                     ) )
        
                          ],)
        
        
                                    :              
                                ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                     minimumSize:  const Size(190, 59),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12), // <-- Radius
                                    ),
                                  backgroundColor: AppColors.buttonBgColor
        
                                ),
                                onPressed: (){
                                  //  print("object ${ globalStorage.getClientId()}" );
                                  // janitorBottomSheet();
                                  dashBoardBloc.add( const GetTaskEvent(
                                      category: "Home"
                                  ) );
                                  // //
                                  facilityBottomSheet();
                                  // adminBottomSheet();
                                  // taskBottomSheet();
                                  //    print(  globalStorage.getClientId());
        
                                  // dashBoardBloc.add(GetAllJanitorEvent(
                                  //   clientId: 340,
                                  // ) );
                                  // showDailog(context);
                                  // selectBuddyDailog();
                                  //  congratDailog();
        
        
                                }, child: Text(DashboardConst.getStarted,
                                                      style: AppTextStyle.font20bold.copyWith(
                               color: AppColors.black
                                                      ),
                                                     ) );
                             }
                           ),
                            // },
        
        
        
                            SizedBox(
                              height: 20.h,
                            ),
            // GestureDetector(
            //     onTap: ()async {
            //       // status: MyJanitorProfileScreenConstants.LOGGING_OUT_TOAST
            //       //     .tr());
            //       var storage = GetIt.instance<GlobalStorage>();
            //       storage.removeToken();
            //       storage.removeLocation();
            //       storage.removeTime();
            //       storage.removeClientId();
            //       await Future.delayed(const Duration(seconds: 3));
            //       EasyLoading.dismiss();
            //       EasyLoading.showToast(MyJanitorProfileScreenConstants
            //           .LOG_OUT_SUCCESS_TOAST );
            //       if (!context.mounted) return;
            //       Navigator.pushAndRemoveUntil(
            //         context,
            //         MaterialPageRoute(
            //             builder: (context) => const LoginAs()),
            //             (route) => false,
            //       );
            //     },
            //     child: const Custombutton(text: "Log out", width: 360)),
        
        
            SizedBox(
              height: 20.h,
            ),
        
        
        
                             Text(
                                 textAlign: TextAlign.center,
                                 "The Task Master service of Woloo Smart Hygiene is a paid service. You are eligible for a 7-day free trial, during which you can add only one facility. After the trial period ends, you must pay ₹499 + GST to continue using the Task Master service.",
                              style: AppTextStyle.font8,
        
                             )
        
        
            // Padding(
            //   padding: EdgeInsets.symmetric(
            //     horizontal: 14.w,
            //     vertical: 10.h,
            //   ),
            //   child: CustomDropDownDialog(
            //     // key: dropDownKey,
            //     // selected: null,
            //     widgetKey:_clusterNameKey,
            //     hint:  DashboardConst.selectCleaningTasks,
            //     // key: Key('${_editMarketModel.city?.label}T4'),
            //     // selected: cities.firstWhereOrNull((element) => element.value == _editMarketModel.city?.value),
            //     // widgetKey: _keys[2],xx
            //     items: gender,
            //     itemAsString: (TaskDropdownModel item) =>
            //     item.facilityName,
            //
            //     onChanged: (TaskDropdownModel item) {
            //       print("click on the page $item");
            //       // facilityId = item.id!;
            //       // debugPrint("facilityId --->$facilityId");
            //       // dashBoardBloc.add(const GetTaskEvent(
            //       //     category: "Home"
            //       // ) );
            //
            //     },
            //
            //     validator: (value) => value == null
            //         ? MyReportIssueScreenConstants.FACILITY_VALIDATION
            //         .tr()
            //         : null,
            //   ),
            // ),
        
        
            // )
        
        
        
            ],
        ),
      ),
    ) ;
  }


  showDailog( BuildContext context ){
    showDialog(
      context: context,
      builder:
          (_) {
        return
          // BlocProvider.value(
          //   value: builderContext.read<ClientDashBoardBloc>(),
          //   child: const
          SelectBuddyDailog();
        // );

      },
    );
  }




     Widget adminCard( String image, String title, int index){
       return
         Padding(
           padding: const EdgeInsets.all(8.0),
           child: Container(
             width: 120,
             height: 151,
             decoration: BoxDecoration(
                 color: AppColors.white,
                 borderRadius: BorderRadius.circular(16),
                 boxShadow: [
                   BoxShadow(
                     color: Colors.black.withOpacity(0.2), // Shadow color
                     spreadRadius: 1, // Spread effect
                     blurRadius: 10, // Blur effect
                     offset: const Offset(0, 5), // Bottom shadow
                   ),
                 ],

                 border:  Border.all(
                     color: selectedAdmin == index ?  AppColors.backgroundColor : AppColors.white
                 )
             ),
             child:  Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                 const SizedBox(
                   height: 50,
                 ),
                 CustomImageProvider(
                   image: image ,
                   width: 106,
                   height: 106,
                 ),
                 const SizedBox(
                   height: 10,
                 ),
                 Text(title,
                   style:  AppTextStyle.font32bold.copyWith(color:  AppColors.greyBorder ),
                 ),
                 const SizedBox(
                   width: 10,
                 ),

               ],
             )
                  ),
         );

     }


     Widget genderCard( String image, String title, int index){
       return   Container(
           width: 151,
           height: 151,
           decoration: BoxDecoration(
               boxShadow: [
                 BoxShadow(
                   color: Colors.black.withOpacity(0.2), // Shadow color
                   spreadRadius: 1, // Spread effect
                   blurRadius: 10, // Blur effect
                   offset: const Offset(0, 5), // Bottom shadow
                 ),
               ],
               color: AppColors.white,
               borderRadius: BorderRadius.circular(16),

               border:  Border.all(
                   color: selectedGender == index ?  AppColors.backgroundColor : AppColors.white
               )
           ),
           child:  Column(
             mainAxisAlignment: MainAxisAlignment.center,
             // crossAxisAlignment: CrossAxisAlignment.center,
             children: [
               const SizedBox(
                 height: 10,
               ),
               CustomImageProvider(
                 image: image ,
                 width: 46,
                 height: 46,
               ),
               const SizedBox(
                 height: 10,
               ),
               Text(title,
                 style:  AppTextStyle.font13.copyWith(color:  AppColors.greyBorder ),
               )

             ],
           )
       );

     }




  Widget card( String image, String title, int index){
    return   Container(
                   width: 110,
                  height: 96,
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2), // Shadow color
                          spreadRadius: 1, // Spread effect
                          blurRadius: 10, // Blur effect
                          offset: const Offset(0, 5), // Bottom shadow
                        ),
                      ],
                    color: AppColors.white,
                  borderRadius: BorderRadius.circular(16),

                  border:  Border.all(
                    color: selectedIndex == index ?  AppColors.backgroundColor : AppColors.white
                  )
               ),
            child:  Column(
              children: [
                   const SizedBox(
                     height: 10,
                   ),
                  CustomImageProvider(
                    image: image ,
                    width: 46,
                    height: 46,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(title,
                  style:  AppTextStyle.font13.copyWith(color:  AppColors.greyBorder ),
                  )

              ],
            )                                      
       );

  }
     bool? value = false;
     bool? assing = false;
     bool isSelected = false;
     DateTime dateTime = DateTime.now();
     TimeOfDay? shiftTime;
        DashBoardController dashController = Get.put(DashBoardController());
    facilityBottomSheet(){
        locationController.clear();
        facilityController.clear();
      showModalBottomSheet<void>(
         backgroundColor: Colors.transparent,


        // context and builder are
        // required properties in this widget
        context: context,
        isScrollControlled: true,
        // backgroundColor: AppColors.appbarBgColor,
        builder: (BuildContext context) {
          // we set up a container inside which
          // we create center column and display text

          // Returning SizedBox instead of a Container
          return  StatefulBuilder(

            builder: (context, StateSetter setState) {

              return Form(
                key: facilityKey,

                child: Container(

                  decoration: const BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(80.0),
                      topRight: Radius.circular(80.0),
                    ),
                  ),
                  height: 650,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric( horizontal: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                           const SizedBox(
                             height: 20,
                           ),
                          Center(
                            child: Text(DashboardConst.listYourFacility,
                             style: AppTextStyle.font18bold,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),

                          facilitydropdownNames.isNotEmpty ?

                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20.w, vertical: 10.h),
                            child: DropDownDialog(
                              isprop: true,

                              // selected: clusterNames.first,
                              // key: _dropDownKey,
                              widgetKey: _clusterNameKey,
                              hint:DashboardConst.organizationName,

                              items: facilitydropdownNames,

                              itemAsString: (FacilityDropdownModel item) =>
                              item.facilityName,
                              onChanged: (FacilityDropdownModel item) {
                                debugPrint("in drop down ${item.locationName}");
                                try {

                                  locationController.text =   item.locationName!;
                                  facilityController.text = item.facilityName!;
                                  setState(() {});

                                  // clusterId = item..id!;
                                  // reportIssueBloc.add(GetAllFacilityDropdown(
                                  //     clusterId: item.clusterId ?? 0));
                                  //
                                  //   // if(state is GetFacilityDropdownSuccess ){
                                  //     reportIssueBloc.add(GetAllTasksDropdown(
                                  //         clusterId: item.clusterId! ?? 0
                                  //     ));
                                  //   // }else
                                  //    // if( state is  GetTasksDropdownSuccess ){
                                  //      reportIssueBloc.add(GetAllJanitorsDropdown(
                                  //          clusterId: item.clusterId ?? 0));
                                  // }


                                } catch (e) {
                                  debugPrint("dropppppp$e");
                                }
                              },
                              validator: (value) =>
                              value == null
                                  ?
                                  "Please select facility"
                                  : null,
                            ),
                          )
                          :

                           CustomTextField(
                            hintText:DashboardConst.organizationName,
                            controller: facilityController,

                             validator: (valu) {
                               if (valu == null || valu.isEmpty) {
                                 return "Facility Name is required";
                               }
                             },
                           ),
                         
                           const SizedBox(
                            height: 10,
                           ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 5.h),
                            child: Container(
                              height: 36.h,
                              decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2), // Shadow color
                                  spreadRadius: 1, // Spread effect
                                  blurRadius: 10, // Blur effect
                                  offset: const Offset(0, 5), // Bottom shadow
                                ),
                              ],
                            ),
                              child: GooglePlaceAutoCompleteTextField(
                                textEditingController:locationController,
                                googleAPIKey:"AIzaSyCkPmUz4UlRdzcKG9gniW9Qfrgzsjhnb_4",
                                inputDecoration:  InputDecoration(
                                  hintText: DashboardConst.location,
                                    hintStyle: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 16.sp,
                                      ),
                                   border: OutlineInputBorder(
                                   borderRadius: BorderRadius.circular(12),
                                   borderSide: BorderSide.none,
                                   ),
                                   fillColor: AppColors.white,
                                   filled: true
                                  // enabledBorder: InputBorder.none,
                                ),
                                validator: (valu, p1) {
                                      FocusManager.instance.primaryFocus?.unfocus();
                                  if (valu == null || valu.isEmpty) {
                                    return "Location is required";
                                  }
                                },

                                // debounceTime: 400,
                                countries: ["in", "fr"],
                                isLatLngRequired: true,
                                getPlaceDetailWithLatLng: (Prediction prediction) {
                                  print("placeDetails" + prediction.lat.toString());
                                },

                                itemClick: (Prediction prediction) {
                              
                                  // facilityController.dispose();
                                  locationController.text = prediction.description ?? "";
                                  locationController.selection = TextSelection.fromPosition(
                                      TextPosition(offset: prediction.description?.length ?? 0));
                                },

                                seperatedBuilder: const Divider(),
                                containerHorizontalPadding: 10,
                                // OPTIONAL// If you want to customize list view item builder
                                itemBuilder: (context, index, Prediction prediction) {
                                  return Container(
                                    padding: const EdgeInsets.all(10),
                                    child: Row(
                                      children: [
                                        const Icon(Icons.location_on),
                                        const SizedBox(
                                          width: 7,
                                        ),
                                        Expanded(child: Text("${prediction.description ?? ""}"))
                                      ],
                                    ),
                                  );
                                },

                                isCrossBtnShown: true,

                                // default 600 ms ,
                              ),
                            ),
                          ),
                           //  CustomTextField(
                           //  hintText:DashboardConst.location,
                           //  controller:  locationController,
                           // ),
                           const SizedBox(
                            height: 10,
                           ),
                          Text(DashboardConst.typeOfFacility,
                           style: AppTextStyle.font14bold,
                          ),
                          const SizedBox(
                            height: 10,
                           ),

                                                  Container(
                                                      width: MediaQuery.of(context).size.width,
                                                      // height: 120,
                                                      child:
                                                      Wrap(
                                                        spacing: 1.0, // Adjust spacing between items
                                                        children: List.generate(facility.length, (index) {
                                                          return GestureDetector(
                                                            onTap: () {
                                                              setState(() {
                                                                selectedIndex = index;
                                                                print("title ${facility[selectedIndex].title!}");

                                                              });
                                                              facility[selectedIndex].title == "Other"   ? isSelected = true

                                                                  : isSelected = false;
                                                                 print("is slec $isSelected");
                                                              dashBoardBloc.add( GetTaskEvent(
                                                                  category:  facility[selectedIndex].title!
                                                              ) );
                                                              setState((){});

                                                            },
                                                            child: Padding(
                                                              padding: const EdgeInsets.all(8.0),
                                                              child: card(facility[index].image!, facility[index].title!, index),
                                                            ),
                                                          );
                                                        }),
                                                    ),),
                          const SizedBox(
                            height: 10,
                          ),
                          isSelected ?
                          CustomTextField(
                            hintText:DashboardConst.ifOthersMentionFacility,
                            controller: typeController,
                            validator: (valu) {
                              if (valu == null || valu.isEmpty) {
                                return "Please mention other type";
                              }
                            },
                          )
                           : const SizedBox()
                          ,

                          const SizedBox(
                            height: 10,
                          ),

                           GestureDetector(
                             onTap: () {

                                if(facilityKey.currentState!.validate()){

                                  facilitydropdownNames.isNotEmpty ?

                                  selectedbuddy == null ?
                                  taskBottomSheet() :

                                  taskExistingBottomSheet(selectedbuddy!)
                                  : taskBottomSheet()
                                  ;

                                }


                             },
                            child: Custombutton(text: "Next", width: 328.w))

                        ],
                      ),
                    ),
                  ),
                ),
              );
            }
          );
        },
      ).then((v){
        facilitydropdownNames.clear();
      } );
    }

   adminBottomSheet(){
     showModalBottomSheet<void>(
       context: context,
       isScrollControlled: true,
       backgroundColor: Colors.transparent,
       builder: (BuildContext context) {
         return  StatefulBuilder(
             builder: (context, StateSetter setState) {
               return  Container(
                 decoration: const BoxDecoration(
                   color: AppColors.white,
                   borderRadius: BorderRadius.only(
                     topLeft: Radius.circular(80.0),
                     topRight: Radius.circular(80.0),
                   ),

                 ),
                 height: 680,
                 // height: 560,
                 child: Center(
                   child: Padding(
                     padding: const EdgeInsets.symmetric( horizontal: 15),
                     child: Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       mainAxisAlignment: MainAxisAlignment.start,
                       children: <Widget>[
                         const SizedBox(
                           height: 20,
                         ),
                         Center(
                           child: Text(DashboardConst.chooseAdmin,
                             style: AppTextStyle.font18bold,
                           ),
                         ),
                         const SizedBox(
                           height: 20,
                         ),

                          ListView.builder(
                            shrinkWrap: true,
                               itemCount: admin.length,
                              itemBuilder:
                           (context, index) {
                              return
                                GestureDetector(
                                    onTap: (){
                                      selectedAdmin =index;
                                      setState((){});
                                    },
                                    child: adminCard( admin[index].image!, admin[index].title!, index));
                           },
                          ),

                          const SizedBox(height: 680/3.3 ),

                         GestureDetector(
                             onTap: (){
                               superVisorBottomSheet();

                             },
                             child: Custombutton(text: "Next", width: 328.w))

                       ],
                     ),
                   ),
                 ),
               );
             }
         );
       },
     );
   }



   superVisorBottomSheet(){
     showModalBottomSheet<void>(
       context: context,
       backgroundColor: Colors.transparent,
       isScrollControlled: true,
       builder: (BuildContext context) {
         return  StatefulBuilder(
             builder: (context, StateSetter setState) {
               return Container(
                 decoration: const BoxDecoration(
                   color: AppColors.white,
                   borderRadius: BorderRadius.only(
                     topLeft: Radius.circular(80.0),
                     topRight: Radius.circular(80.0),
                   ),
                 ),
                 height: 680,
                 child: Form(
                     key: addSuperVisorKey,
                   child: Center(
                     child: Padding(
                       padding: const EdgeInsets.symmetric( horizontal: 15),
                       child: Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         mainAxisAlignment: MainAxisAlignment.start,
                         children: <Widget>[
                           const SizedBox(
                             height: 20,
                           ),
                           Center(
                             child: Text(DashboardConst.assignsupervisor,
                               style: AppTextStyle.font18bold,
                             ),
                           ),
                           const SizedBox(
                             height: 20,
                           ),
                           CustomTextField(
                             controller: nameController,
                             hintText:  DashboardConst.fullName,
                             keyboardType: TextInputType.text,
                            //  maxLength: 10,

                             validator:
                              validateName
                             // prefixIcon: Icons.phone,
                           ),
                           const SizedBox(height: 20),

                           CustomTextField(
                             controller: mobileController,
                             hintText:  DashboardConst.number,
                             keyboardType: TextInputType.number,
                             maxLength: 10,
                             validator: validateMobile
                             // prefixIcon: Icons.phone,
                           ),

                           const SizedBox(height: 290),

                           GestureDetector(
                               onTap: (){
                                    if(addSuperVisorKey.currentState!.validate()){

                                      // dashBoardBloc.add(
                                      //     AddUserEvent(
                                      //      mobile: mobileController.text,
                                      //      name: nameController.text,
                                      //      roleId: "2",
                                      //      clientId: decodedToken!["id"].toString(),
                                      // )  );

                                      // taskBottomSheet();
                                 janitorBottomSheet();
                                    }

                               },
                               child: Custombutton(text: "Next", width: 328.w))

                         ],
                       ),
                     ),
                   ),
                 ),
               );
             }
         );
       },
     );
   }

     int? estimatedTime = 0;
     int? len;
     List<int?> taksIds = [];
     bool isNext = false;
     String?  use12hour;


     taskBottomSheet(){

     showModalBottomSheet<void>(
       context: context,
       backgroundColor: Colors.transparent,
       isScrollControlled: true,
       builder: (BuildContext context) {

         return 
          StatefulBuilder(
             builder: (context, StateSetter setState) {
               return Form(
                 key: _formKey,
                 child: Container(
                   decoration: const BoxDecoration(
                     color: AppColors.white,
                     borderRadius: BorderRadius.only(
                       topLeft: Radius.circular(80.0),
                       topRight: Radius.circular(80.0),
                     ),

                   ),
                   height: 780,
                   child: Center(
                     child: Padding(
                       padding: const EdgeInsets.symmetric( horizontal: 15),
                       child: Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         mainAxisAlignment: MainAxisAlignment.start,
                         children: <Widget>[
                           const SizedBox(
                             height: 20,
                           ),
                           Center(
                             child: Text(DashboardConst.assignTasks,
                               style: AppTextStyle.font18bold,
                             ),
                           ),
                           const SizedBox(
                             height: 20,
                           ),


                           Padding(
                             padding: EdgeInsets.symmetric(
                               horizontal: 20.w,
                               vertical: 10.h,
                             ),
                             child: Container(
                               decoration: BoxDecoration(
                                 color: Colors.white,

                                 borderRadius: BorderRadius.circular(25.r),
                                 boxShadow: [
                                   BoxShadow(
                                     color: Colors.black.withValues(alpha: 0.2), // Shadow color
                                     spreadRadius: 1, // How wide the shadow should spread
                                     blurRadius: 10, // The blur effect of the shadow
                                     offset: const Offset(0,
                                         5), // Shadow offset, with y-offset for bottom shadow
                                   ),
                                 ],
                               ),
                               child: MultiselectDropDownDialog(
                                 widgetKey: _facilityKey,
                                 hint: DashboardConst.selectCleaningTasks,
                                 // key: Key(
                                 //     '${_editProductModel.paymentMethodId?.firstOrNull?.label}T5'),
                                 // selected: _editProductModel.paymentMethodId,
                                 items: facilityNames,
                                 itemAsString: (TaskDropdownModel item) {
                                   return
                                     "${item.facilityName}   ${item.requiredTime} min" ;  },
                                 validator: (value) {
                                    print("slecrte $value");
                                   value == []
                                     ? "Please select tasks"

                                     : null;
                                 },

                                 onSaved: (List<TaskDropdownModel> i) {
                                   // selectedIds.add(i[1].taskId!);
                                   // selectedIds =
                                   //     i.map((e) => e.taskId.toString()).toList();
                                 },
                                 onChanged: (List<TaskDropdownModel> i) {
                                    // print(" car $i ");
                                   List<int?> listTime = [];

                                   len =  i.length;

                                   listTime =  i.map( (e) =>  e.requiredTime).toList();

                                    print("total time $estimatedTime");
                                     if(i.isEmpty){
                                       estimatedTime = null;
                                     }else
                                      if( i.isNotEmpty){
                                        estimatedTime = listTime.reduce((a, b) => a! + b!);
                                        taksIds =  i.map( (e) => e.id ).toList();
                                      }
                                     else
                                   if( i.isNotEmpty && len! < i.length    ){
                                     listTime =  i.map( (e) =>  e.requiredTime).toList();
                                     estimatedTime = listTime.reduce((a, b) => a! - b!);
                                   }

                                    print("estimagte $estimatedTime ");

                                   // if(i.isEmpty ){
                                   //    estimatedTime = 0;
                                   // }
                                    setState( (){});


                                   // selectedIds =
                                   //     i.map((e) => e.taskId.toString()).toList();
                                   // debugPrint(selectedIds.toString());
                                 },
                                 // label: 'Template Name',
                               ),
                             ),
                           ),


                           const SizedBox(
                             height: 10,
                           ),

                            Text( DashboardConst.estimatedTaskCompletionTime,
                             style: AppTextStyle.font20bold.copyWith(
                               color: const Color(0xff8F8F8F)
                             ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Center(
                              child:
                              estimatedTime == null ?
                              Text('00:00',
                                style: AppTextStyle.font24bold,
                              )
                                  : Text("$estimatedTime min",
                                style: AppTextStyle.font24bold,
                              )

                              ,
                            ),
                           const SizedBox(
                             height: 10,
                           ),
                           Row(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             children: [
                               Text(DashboardConst.scheduleShift,
                                 style: AppTextStyle.font14w7,
                               ),

                               InkWell(
                                 onTap: ()async{

                                    // if(  estimatedTime ==  null ) return;


                                   shiftTime = await    showTimePicker(
                                     context: context,
                                     initialTime: TimeOfDay.now(),
                                     // builder: (BuildContext context, Widget? child) {
                                     //   // return Directionality(
                                     //   //   // textDirection: TextDirection.rtl,
                                     //   //   child: child!,
                                     //   // );
                                     // },
                                   );
                                   DateTime date = DateTime.now();
                                   // date.add( Duration( hours: shiftTime!.hour, minutes: shiftTime!.minute  ) );
                                    // print("duration ${}");

                                   DateTime dateTime = DateTime(date.year, date.month, date.day, shiftTime!.hour, shiftTime!.minute);
                                   DateTime newDateTime = dateTime.add(const Duration(hours: 12));
                                   TimeOfDay newShiftTime = TimeOfDay.fromDateTime(newDateTime);
                                   final localizations = MaterialLocalizations.of(context);
                                      use12hour =   localizations.formatTimeOfDay(newShiftTime, alwaysUse24HourFormat: false);
                                    // DateTime  hour =   date.add( Duration(hours: 12, minutes: 0 ));
                                   print("timen $newDateTime ");
                                     print("hour $use12hour ");
                                   setState((){});
                                 },
                                 child: Container(
                                   width: 110,
                                   height: 40,
                                   decoration: BoxDecoration(
                                     color: AppColors.white,
                                     borderRadius: BorderRadius.circular(8),
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
                                   // ),
                                   ),
                                   child: Center(child:
                                   shiftTime != null ?

                                     Text(shiftTime!.format(context),
                                       style: AppTextStyle.font14w7,
                                     ) :

                                   Text("Start Time *",
                                    style: AppTextStyle.font14w7,
                                   )),

                                 ),
                               )

                             ],
                           ),

                           shiftTime == null && isNext ?
                                Column(
                                  children: [
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text("Please select shift Timing",
                                     style: AppTextStyle.font12.copyWith(color: AppColors.red ),
                                    ),
                                  ],
                                )
                            : const SizedBox(
                             // height: ,
                            ),

                           const SizedBox(
                             height: 20,
                           ),

                           Container(
                             // height:
                            // 70 ,
                             decoration: BoxDecoration(
                               color: AppColors.white,

                               borderRadius: BorderRadius.circular(16),
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
                               padding: const EdgeInsets.symmetric( horizontal: 15),
                               child: Column(
                                 crossAxisAlignment: CrossAxisAlignment.start,
                                 children: [
                                   const SizedBox(
                                     height: 15,
                                   ),
                                   Row(
                                     crossAxisAlignment: CrossAxisAlignment.center,
                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                     children: [
                                        const SizedBox(
                                          height: 10,
                                        ),
                                       Text(DashboardConst.scheduleTask,
                                         style: AppTextStyle.font14w7,
                                       ),
                                       GestureDetector(
                                           onTap:(){
                                              Datum? buddy;

                                             _showMyDialog(false,  );

                                             // janitorBottomSheet()
                                           } ,
                                           child: Custombutton(text: DashboardConst.addTimings, width: 164.w))

                                     ],
                                   ),

                                   dashController.taskStartTime.isEmpty && isNext ?
                                   Column(
                                     crossAxisAlignment: CrossAxisAlignment.start,
                                     mainAxisAlignment: MainAxisAlignment.start,
                                     children: [
                                       const SizedBox(
                                         height: 10,
                                       ),
                                       Text("Please add Timing for tasks",
                                         style: AppTextStyle.font12.copyWith(color: AppColors.red ),
                                       ),
                                     ],
                                   )
                                       : const SizedBox(
                                     // height: ,
                                   ),
                                   const SizedBox(
                                     height: 15,
                                   ),
                                   Obx(


                                      ()=>
                                        SizedBox(
                                          height:dashController.taskStartTime.isEmpty ? 0:200,
                                          child:                    ListView.builder(
                                                                               shrinkWrap: true,
                                                                               itemCount: dashController.taskStartTime.length ,
                                                                               itemBuilder: (context, index) {
                                                                                 return ListTile(
                                            trailing: IconButton(
                                               onPressed: () {
                                                 dashController.taskStartTime.removeAt(index);
                                                 dashController.taskEndTime.removeAt(index);
                                                  dashController.taskTimes.removeAt(index);
                                                //  setState((){});
                                               } ,

                                              icon:  const Icon(  Icons.delete,),
                                             color: AppColors.red,
                                            ),
                                           title:  Row(
                                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                             children: [
                                               Text( dashController.taskStartTime[index].format(context) ,
                                                style: AppTextStyle.font14bold,
                                               ),
                                               // taskEndTime
                                               Text( dashController.taskEndTime[index].format(context) ,
                                                 style: AppTextStyle.font14bold,
                                               ),
                                             ],
                                           ),
                                                                                 );
                                                                             }, ),
                                        ),
                                   )
                                 ],
                               ),
                             ),
                           ),



                           const SizedBox(height: 10),
                             Center(child: Text("The shift shall start at ${ shiftTime == null ? '00:00' : shiftTime!.format(context)}")),
                           const SizedBox(height: 5),
                            Center(child: Text(
                               textAlign: TextAlign.center,
                               "Shift shall complete at ${use12hour}" )),

                           const SizedBox(height: 10),
                           // GestureDetector(
                           //   onTap: (){},
                           //   child: Center(child: Text(
                           //       style: AppTextStyle.font18bold.copyWith(
                           //         color: AppColors.backgroundColor
                           //       ),
                           //       DashboardConst.addAnotherFacility,
                           //
                           //   )
                           //   ),
                           // ),

                           const SizedBox(height: 10),


                           GestureDetector(
                               onTap:(){
                                 isNext = true;
                                 setState((){});
                                  print("curtne ${_formKey.currentState!.validate()}");
                                  if( shiftTime != null && dashController.taskStartTime.isNotEmpty && estimatedTime != null ){
                                 // && shiftTime != null && taskStartTime.isNotEmpty && estimatedTime != null
                                 adminBottomSheet();

                                  }


                                 // janitorBottomSheet()
                 ;                             } ,
                               child: Custombutton(text: "Next", width: 328.w))

                         ],
                       ),
                     ),
                   ),
                 ),
               );
             }
         );
       },
     )
     .then( (value) {
       dashController.taskStartTime.clear();
       dashController.taskEndTime.clear();
       dashController.taskTimes.clear();
       estimatedTime = null;
       shiftTime = null;
       isNext = false;
     }, ) ;
   }

    // List<TimeOfDay> taskStartTime = [];
     // List<TimeOfDay> taskEndTime = [];
     // List<Map<String, String>> taskTimes = [];


     Future<void> _showMyDialog(bool isFromExiting, {Datum? janitor}) async {

        print("shift $shiftTime ");
        print("shift $use12hour ");
        print("estima $estimatedTime ");

         showDialog<Map<String, List<TimeOfDay>>>(
         context: context,
         barrierDismissible: true, // user must tap button!
         builder: (BuildContext context) {
           return  AddTimeDailog(
              estimatedTime: estimatedTime!,
              startTime: shiftTime,
              endTime: use12hour,
              isFromExisting: isFromExiting,
              janitorId: janitor == null ? null : janitor.id,

              // taskStartTime: taskStartTime,
              // taskEndTime: taskEndTime,
              // taskTimes: taskTimes,

           );


         },
       );
             // .then((value) {
       //      // taskStartTime = value!["taskStartTime"]! ;
       //      //  taskEndTime = value["taskEndTime"]! ;
       //      // setState(() {
       //
       //
       //      // });
       //       print(" valeiu $taskTimes");
       //   // return;
       //    return  value;
       // }, );

     }




   janitorBottomSheet(){
     showModalBottomSheet<void>(
       context: context,
       isScrollControlled: true,
       backgroundColor: Colors.transparent,
       builder: (BuildContext context) {
         return  StatefulBuilder(
             builder: (context, StateSetter setState) {
               return Form(
                 key: addJanitorKey,
                 child: Container(
                   decoration: const BoxDecoration(
                     color: AppColors.white,
                     borderRadius: BorderRadius.only(
                       topLeft: Radius.circular(80.0),
                       topRight: Radius.circular(80.0),
                     ),
                   ),
                   height: 680,
                   child: Center(
                     child: Padding(
                       padding: const EdgeInsets.symmetric( horizontal: 15),
                       child: Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         mainAxisAlignment: MainAxisAlignment.start,
                         children: <Widget>[
                           const SizedBox(
                             height: 20,
                           ),
                           Center(
                             child: Text(DashboardConst.assignJanitor,
                               style: AppTextStyle.font18bold,
                             ),
                           ),
                           const SizedBox(
                             height: 20,
                           ),
                           CustomTextField(
                             controller: janNameController,
                             hintText:  DashboardConst.fullName,
                             keyboardType: TextInputType.text,
                            //  maxLength: 10,

                             validator: validateName
                            //  (value) {
                            //    if (value == null || value.isEmpty || value.length < 10) {
                            //      return "Enter a valid 10-digit number";
                            //    }
                            //    return null;
                            //  },
                             // prefixIcon: Icons.phone,
                           ),
                           const SizedBox(height: 10),

                           CustomTextField(
                             controller: janMobileController,
                             hintText:  DashboardConst.number,
                             keyboardType: TextInputType.number,
                             maxLength: 10,
                             validator: (value) {
                               if (value == null || value.isEmpty || value.length < 10) {
                                 return "Enter a valid 10-digit number";
                               }
                               return null;
                             },
                             // prefixIcon: Icons.phone,
                           ),
                           const SizedBox(
                             height: 20,
                           ),

                            Text(DashboardConst.gender,
                             style: AppTextStyle.font14bold.copyWith(
                               color: const Color(0xff8F8F8F)
                             ),
                            ),
                           const SizedBox(
                             height: 20,
                           ),
                           Container(
                             width: MediaQuery.of(context).size.width,
                             height: 151,
                             child: ListView.builder(
                               shrinkWrap: true,
                                 itemCount: genderList.length,
                                 scrollDirection: Axis.horizontal,
                                 itemBuilder:
                                 (context, index) {
                                    return GestureDetector(
                                        onTap: (){
                                           setState((){
                                              selectedGender = index;
                                           });
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: genderCard(genderList[index].image!, genderList[index].title!, index),
                                        ));
                                 },
                             ),
                           ),

                           const SizedBox(height: 680/3.8),

                           GestureDetector(
                               onTap: () {
                                 if(addJanitorKey.currentState!.validate()){
                                          print("facility ${facilityController.text} ");
                                          print("location ${locationController.text} ");
                                          print("type ${typeController.text} ");
                                          print("sup ${nameController.text} ");
                                          print("sup mo ${mobileController.text} ");
                                          print("jan naem ${janNameController.text} ");
                                          print("jan mo ${janMobileController.text} ");
                                          print("gender  ${janitorGender} ");
                                          print("shift time ${shiftTime.toString()} ");
                                          print("task id ${taksIds} ");
                                          print("estimated time ${estimatedTime} ");
                                          // print("task timing id ${taskTimes} ");

                                         String city =    globalStorage.getCity();
                                        String address =   globalStorage.getAddress();
                                       String pincode =     globalStorage.getPincode();
                                       String clientId =   globalStorage.getClientId();



                                   dashBoardBloc.add( ClientSetUpEvent(
                                       clientId: clientId,
                                       orgName: facilityController.text,
                                       locality: locationController.text,
                                       pincode: pincode,
                                       address: address,
                                       city: city,
                                      //  unitNo: "sd"
                                   )  );
                                   // dashBoardBloc.add(
                                   //     AddUserEvent(
                                   //      mobile: mobileController.text,
                                   //      name: nameController.text,
                                   //      roleId: "2",
                                   //      clientId: decodedToken!["id"].toString(),
                                   // )  );
                                   // dashBoardBloc.add(
                                   //     AddUserEvent(
                                   //       mobile: mobileController.text,
                                   //       name: nameController.text,
                                   //       gender: janitorGender,
                                   //       roleId: "1",
                                   //       clientId: decodedToken!["id"].toString(),
                                   //     ));
                                   // dashBoardBloc.add(
                                   //     AssignTaskEvent(clientId: decodedToken!["id"],
                                   //         shiftTime: shiftTime.toString(),
                                   //         taskIds: taksIds,
                                   //         estimatedTime: estimatedTime.toString(),
                                   //         taskTimes: taskTimes
                                   //     ));

                                   // taskBottomSheet();
                                 }
                               },
                               child: Custombutton(text: "Submit", width: 328.w))

                         ],
                       ),
                     ),
                   ),
                 ),
               );
             }
         );
       },
     );
   }


 String? selectedJanitor;


     Datum? selectedbuddy;


 showTaskBuddyDailog(  TaskModel taskModel){
    showDialog(context: context, builder: 
    (context) {
       return   StatefulBuilder(
         builder: (context, setState) {
           return AlertDialog(
                     backgroundColor: AppColors.white,

                     title:  Center(
                       child: Text("Choose an Existing Task Buddy",
                        style: AppTextStyle.font20bold,
                        textAlign: TextAlign.center,
                       ),
                     ),
                     content:
                     SingleChildScrollView(
                       child: ListBody(
                         children: <Widget>[



                           SizedBox(
                             height: 20.h,
                           ),

                       Container(
                         height: 300,
                         width: 300,
                         child: ListView.builder(
                           shrinkWrap: true,
                           itemCount: taskModel!.results.data.length,
                           itemBuilder: (context, index) {
                             final janitor = taskModel!.results.data[index].name;
                             return RadioListTile<String>(
                               title: Text(janitor),
                               value: "$janitor + $index ",
                               groupValue: selectedJanitor,
                               onChanged: (value) {

                                 setState(() {
                                   selectedJanitor = value;
                                    print("selected ${taskModel!.results.data[index]} ");

                                   selectedbuddy = taskModel!.results.data[index];

                                 });
                               },
                             );
                           },
                         ),
                       ),

                          SizedBox(
                            height: 20.h,
                          ),

                            GestureDetector(
                              onTap: (){
                                // Navigator.of(context).push( MaterialPageRoute(builder: (context) {
                                //    return ClientDashboard();
                                // }, ) );

                                // taskExistingBottomSheet(selectedbuddy!
                                // );
                                String clintId = globalStorage.getClientId();
                                dashBoardBloc.add( GetAllFacilityEvent(
                                    clientId: int.parse(clintId)
                                ) );

                                facilityBottomSheet();



                              },
                              child: Custombutton(
                                  height: 30.h,
                                  text:"Okay", width: 320.w ),
                            ),
                           SizedBox(
                             height: 10.h,
                           ),


                         ],
                       ),
                     ),

                   );
         }
       );
    },
    
    
    );


  

 }

 dynamic planId;

    congratDailog(){
       
    showDialog(context: context, builder:
     (context) {
        return     AlertDialog(
                 backgroundColor: AppColors.white,

                 title:  Center(
                   child: Text(DashboardConst.congratulations,
                    style: AppTextStyle.font20bold,
                   ),
                 ),
                 content: 
                   BlocBuilder(
                    bloc: dashBoardBloc,
                     
                   builder: (context, state) {
                      if ( state is DashboarLoading  ){
  
                         EasyLoading.show(status: state.message);
                      } 
                      if(state is Subcription ){
                        EasyLoading.dismiss();

                         planId =   state.subscriptionModel!.results!.planId;
                        // taskModel =  state.taskModel;
                      }
                       if(state is DashboarError  ){
                         EasyLoading.dismiss();
                         EasyLoading.showError( state.error.message);
  
                       }  
                     return
                      SingleChildScrollView(
                       child: ListBody(
                         children: <Widget>[
                           
                            CustomImageProvider(
                              image: ClientImages.celebration,
                              width: 145,
                              height: 145,
                            ),
                           // Text(DashboardConst.scheduleTask,
                           //   style: AppTextStyle.font14w7,
                           // ),
                           SizedBox(
                             height: 20.h,
                           ),
                          
                           Text(
                              textAlign: TextAlign.center,
                             "You have assigned the Task to [Task Buddy Name]",
                            style: AppTextStyle.font14w7,
                           ),
                     
                         SizedBox(
                           height: 20.h,
                         ),
                     
                        //  GestureDetector(
                        //    onTap: () {
                        //       selectBuddyDailog();
                        //       // showDialog(context: context, builder: (context) =>  SelectBuddyDailog(), );
                        //    },
                        //    child: Custombutton(
                        //         height: 30.h,
                        //        text:DashboardConst.addAnotherTask , width: 320.w ),
                        //  ),
                          
                          // SizedBox(
                          //   height: 20.h,
                          // ),
                     
                        //    GestureDetector(
                        //    onTap: () {
                        //      if ( planId == null) {
                        //       Navigator.of(context).push( MaterialPageRoute(builder: (context) {
                        //          return const SubcriptionScreen();
                        //        }, ) );
                               
                        //      } else {
                               
                        //      }
                             
                        //      facilityBottomSheet();
                          
                        //    },
                        //    child: Custombutton(
                        //         height: 30.h,
                        //        text:DashboardConst.addAnotherFacility , width: 320.w ),
                        //  ),
                     
                     
                          SizedBox(
                            height: 20.h,
                          ),
                         
                     
                            GestureDetector(
                              onTap: (){
                                Navigator.of(context).push( MaterialPageRoute(builder: (context) {
                                   return ClientDashboard();
                                }, ) );
                              },
                              child: Custombutton(
                                  height: 30.h,
                                  text:DashboardConst.noThanks , width: 320.w ),
                            ),
                           SizedBox(
                             height: 10.h,
                           ),
                      
                     
                         ],
                       ),
                     );
                   }
                 ),
                
               );
     },
    ).then((v){


                                   } );;

    }


 selectBuddyDailog(){
      
      showDialog(context: context, builder:
       (context) {
         return  AlertDialog(
                 backgroundColor: AppColors.white,


                 content:   BlocConsumer(
                   listener: (context, state) {
                        // print("dfsdfsd$state");
                     if ( state is DashboarLoading  ){

                       EasyLoading.show(status: state.message);
                     }
                     if(state is GetAllJanitor ){
                       EasyLoading.dismiss();


                       showTaskBuddyDailog( state.taskModel! );
                      //  showDialog(context: context, builder:
                      //      (context) {
                      //    return BuddyListDailog( taskModel: state.taskModel, );
                      //  },
                      //  );
                       // taskModel =  state.taskModel;

                     }
                      if(state is GetAllFacility ){
                        facilityBottomSheet();
                        dashBoardBloc.add( const GetTaskEvent(
                              category: "Home"
                          ) );


                      }

                     if(state is DashboarError  ){
                       EasyLoading.dismiss();
                       EasyLoading.showError( state.error.message);

                     }
                   },
                   bloc: dashBoardBloc,
                   builder : (context, state) =>   SingleChildScrollView(
                     child: ListBody(
                       children: <Widget>[


                          // CustomImageProvider(
                          //   image: ClientImages.celebration,
                          //   width: 145,
                          //   height: 145,
                          // ),
                         // Text(DashboardConst.scheduleTask,
                         //   style: AppTextStyle.font14w7,
                         // ),
                         SizedBox(
                           height: 20.h,
                         ),

                         Text(
                            textAlign: TextAlign.center,
                          DashboardConst.taskBuddyPrompt,
                          style: AppTextStyle.font14w7,
                         ),

                       SizedBox(
                         height: 20.h,
                       ),

                       GestureDetector(
                         onTap: (){
                           // Navigator.of(context).pop();
                           // Navigator.of(context).pop();
                           String clintId = globalStorage.getClientId();
                           dashBoardBloc.add( GetAllFacilityEvent(
                               clientId: int.parse(clintId)
                           ) );


                         },
                         child: Custombutton(
                              height: 30.h,
                             text:DashboardConst.assignNewTaskBuddy , width: 320.w ),
                       ),

                        SizedBox(
                          height: 20.h,
                        ),

                          GestureDetector(
                            onTap: () {

                               String clientId = globalStorage.getClientId();

                                print("dfgfd $clientId");
                               // context.read<ClientDashBoardBloc>().add(
                               //     GetAllJanitorEvent(
                               //       clientId: int.parse(clientId),
                               //     )
                               // );
                               dashBoardBloc.add(
                               GetAllJanitorEvent(clientId: int.parse(clientId),
                               )
                               );

                            },
                            child: Custombutton(
                                height: 30.h,
                                text:DashboardConst.assignExistingTaskBuddy , width: 320.w ),
                          ),
                         SizedBox(
                           height: 10.h,
                         ),


                       ],
                     ),
                   ),
                 ),

               );
       },
      
       );
    }






   String? validateMobile(String? value) {
     if (value == null || value.isEmpty) {
       return "Mobile number is required";
     }
     if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
       return "Enter a valid 10-digit number";
     }
     return null;
   }


   String? validateName(String? value) {
     if (value == null || value.isEmpty) {
       return "Name is required";
     }
     if (value.length < 3) {
       return "Name must be at least 3 characters";
     }
     return null;
   }

  TimeOfDay convertToTimeOfDay(String timeString) {
    DateTime dateTime = DateTime.parse(timeString);
    return TimeOfDay.fromDateTime(dateTime);
  }



  taskExistingBottomSheet( Datum buddy ){


         if(mounted){
            dashController.taskTimes.clear();
             for( var item in buddy.taskTimes ) {
                 print("start time ${item.startTime}");
                  print("end time ${item.endTime}");
               String formattedStartDate = DateFormat('yyyy-MM-dd HH:mm:ss')
                   .format(item.startTime);
               String formattedEndDate = DateFormat('yyyy-MM-dd HH:mm:ss')
                   .format(item.endTime);

               TimeOfDay startTime = convertToTimeOfDay(formattedStartDate);
               TimeOfDay endTime = convertToTimeOfDay(formattedEndDate);

                   print("start time ${startTime}");
                    print("end time ${endTime}");
               dashController.taskTimes.add({
                 "start_time": formattedStartDate!,
                 "end_time": formattedEndDate
               });

               dashController.taskStartTime.add(startTime);
               dashController.taskEndTime.add(endTime);
               
             }

             }

    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (BuildContext context) {





         

         
      // buddy.taskTimes.map((e)=> e.startTime).toList();


        // convertToTimeOfDay(buddy.taskTimes[index].startTime.toString());







        return
          StatefulBuilder(
              builder: (context, StateSetter setState) {
                return Form(
                  key: _formKey,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(80.0),
                        topRight: Radius.circular(80.0),
                      ),

                    ),
                    height: 800,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric( horizontal: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            const SizedBox(
                              height: 20,
                            ),
                            Center(
                              child: Text(DashboardConst.assignTasks,
                                style: AppTextStyle.font18bold,
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            selectedbuddy != null ?

                            Padding(
                              padding: EdgeInsets.only(left: 8.h ),
                              child: Text( "Buddy Name : ${selectedbuddy!.name}",
                                style: AppTextStyle.font14bold,
                              ),
                            ) :

                            SizedBox(),

                            selectedbuddy != null ?
                            const SizedBox(
                              height: 10,
                            ) : SizedBox(),

                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 20.w,
                                vertical: 10.h,
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,

                                  borderRadius: BorderRadius.circular(25.r),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withValues(alpha: 0.2), // Shadow color
                                      spreadRadius: 1, // How wide the shadow should spread
                                      blurRadius: 10, // The blur effect of the shadow
                                      offset: const Offset(0,
                                          5), // Shadow offset, with y-offset for bottom shadow
                                    ),
                                  ],
                                ),
                                child: MultiselectDropDownDialog(
                                  widgetKey: _facilityKey,
                                  hint: DashboardConst.selectCleaningTasks,
                                  // key: Key(
                                  //     '${_editProductModel.paymentMethodId?.firstOrNull?.label}T5'),
                                  // selected: _editProductModel.paymentMethodId,
                                  items: facilityNames,
                                  itemAsString: (TaskDropdownModel item) {
                                    return
                                      "${item.facilityName}   ${item.requiredTime} min" ;  },
                                  validator: (value) {
                                    print("slecrte $value");
                                    value == []
                                        ? "Please select tasks"

                                        : null;
                                  },

                                  onSaved: (List<TaskDropdownModel> i) {
                                    // selectedIds.add(i[1].taskId!);
                                    // selectedIds =
                                    //     i.map((e) => e.taskId.toString()).toList();
                                  },
                                  onChanged: (List<TaskDropdownModel> i) {
                                    // print(" car $i ");
                                    List<int?> listTime = [];

                                    len =  i.length;

                                    listTime =  i.map( (e) =>  e.requiredTime).toList();

                                    print("total time $estimatedTime");
                                    if(i.isEmpty){
                                      estimatedTime = null;
                                    }else
                                    if( i.isNotEmpty){
                                      estimatedTime = listTime.reduce((a, b) => a! + b!);
                                      taksIds =  i.map( (e) => e.id ).toList();
                                    }
                                    else
                                    if( i.isNotEmpty && len! < i.length    ){
                                      listTime =  i.map( (e) =>  e.requiredTime).toList();
                                      estimatedTime = listTime.reduce((a, b) => a! - b!);
                                    }

                                    print("estimagte $estimatedTime ");

                                    // if(i.isEmpty ){
                                    //    estimatedTime = 0;
                                    // }
                                    setState( (){});


                                    // selectedIds =
                                    //     i.map((e) => e.taskId.toString()).toList();
                                    // debugPrint(selectedIds.toString());
                                  },
                                  // label: 'Template Name',
                                ),
                              ),
                            ),


                            const SizedBox(
                              height: 10,
                            ),

                            Text( DashboardConst.estimatedTaskCompletionTime,
                              style: AppTextStyle.font20bold.copyWith(
                                  color: const Color(0xff8F8F8F)
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Center(
                              child:
                              estimatedTime == null ?
                              Text('00:00',
                                style: AppTextStyle.font24bold,
                              )
                                  : Text("$estimatedTime min",
                                style: AppTextStyle.font24bold,
                              )

                              ,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(DashboardConst.scheduleShift,
                                  style: AppTextStyle.font14w7,
                                ),

                                InkWell(
                                  onTap: ()async{
                                    shiftTime = await    showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.now(),
                                      // builder: (BuildContext context, Widget? child) {
                                      //   // return Directionality(
                                      //   //   // textDirection: TextDirection.rtl,
                                      //   //   child: child!,
                                      //   // );
                                      // },
                                    );
                                    DateTime date = DateTime.now();
                                    // date.add( Duration( hours: shiftTime!.hour, minutes: shiftTime!.minute  ) );
                                    // print("duration ${}");

                                    DateTime dateTime = DateTime(date.year, date.month, date.day, shiftTime!.hour, shiftTime!.minute);
                                    DateTime newDateTime = dateTime.add(const Duration(hours: 12));
                                    TimeOfDay newShiftTime = TimeOfDay.fromDateTime(newDateTime);
                                    final localizations = MaterialLocalizations.of(context);
                                    use12hour =   localizations.formatTimeOfDay(newShiftTime, alwaysUse24HourFormat: false);
                                    // DateTime  hour =   date.add( Duration(hours: 12, minutes: 0 ));
                                    print("timen $newDateTime ");
                                    print("hour $use12hour ");
                                    setState((){});
                                  },
                                  child: Container(
                                    width: 110,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: AppColors.white,
                                      borderRadius: BorderRadius.circular(8),
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
                                      // ),
                                    ),
                                    child: Center(child:
                                    shiftTime != null ?

                                    Text(shiftTime!.format(context),
                                      style: AppTextStyle.font14w7,
                                    ) :

                                    Text("Start Time *",
                                      style: AppTextStyle.font14w7,
                                    )),

                                  ),
                                )

                              ],
                            ),

                            shiftTime == null && isNext ?
                            Column(
                              children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                Text("Please select shift Timing",
                                  style: AppTextStyle.font12.copyWith(color: AppColors.red ),
                                ),
                              ],
                            )
                                : const SizedBox(
                              // height: ,
                            ),

                            const SizedBox(
                              height: 20,
                            ),

                            Container(
                              // height:
                              // 70 ,
                              decoration: BoxDecoration(
                                color: AppColors.white,

                                borderRadius: BorderRadius.circular(16),
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
                                padding: const EdgeInsets.symmetric( horizontal: 15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(DashboardConst.scheduleTask,
                                          style: AppTextStyle.font14w7,
                                        ),
                                        GestureDetector(
                                            onTap:(){
                                              _showMyDialog(true,janitor: selectedbuddy );

                                              // janitorBottomSheet()
                                            } ,
                                            child: Custombutton(text: DashboardConst.addTimings, width: 164.w))

                                      ],
                                    ),

                                    dashController.taskStartTime.isEmpty && isNext ?
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text("Please add Timing for tasks",
                                          style: AppTextStyle.font12.copyWith(color: AppColors.red ),
                                        ),
                                      ],
                                    )
                                        : const SizedBox(
                                      // height: ,
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Obx(
                                          ()=>
                                          SizedBox(
                                            height: dashController.taskStartTime.isEmpty ? 0:200,
                                            child:                    ListView.builder(
                                              shrinkWrap: true,
                                              itemCount: dashController.taskStartTime.length ,
                                              itemBuilder: (context, index) {

                                           //    TimeOfDay startTime =
                                           //    convertToTimeOfDay(buddy.taskTimes[index].startTime.toString());
                                           //    TimeOfDay endTime =    convertToTimeOfDay(buddy.taskTimes[index].endTime.toString());
                                           // String   formattedStartDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(buddy.taskTimes[index].startTime);
                                           // String   formattedEndDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(buddy.taskTimes[index].endTime);
                                           //    dashController.taskTimes.add(    {
                                           //      "start_time" : formattedStartDate! ,
                                           //      "end_time" : formattedEndDate
                                           //    });

                                                return ListTile(
                                                  trailing:

                                                  IconButton(
                                                    onPressed: () {
                                                      dashController.taskStartTime.removeAt(index);
                                                      dashController.taskEndTime.removeAt(index);
                                                      //  setState((){});
                                                    } ,

                                                    icon:  const Icon(  Icons.delete,),
                                                    color: AppColors.red,
                                                  ),
                                                  title:  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [

                                                      Text( dashController.taskStartTime[index].format(context) ,
                                                        style: AppTextStyle.font14bold,
                                                      ),
                                                      // taskEndTime
                                                      Text(dashController.taskEndTime[index].format(context),
                                                        style: AppTextStyle.font14bold,
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              }, ),
                                          ),
                                    )
                                  ],
                                ),
                              ),
                            ),



                            const SizedBox(height: 10),
                            Center(child: Text("The shift shall start at ${ shiftTime == null ? '00:00' : shiftTime!.format(context)}")),
                            const SizedBox(height: 5),
                            Center(child: Text(
                                textAlign: TextAlign.center,
                                "Shift shall complete at ${use12hour}" )),

                            const SizedBox(height: 10),
                            // GestureDetector(
                            //   onTap: (){},
                            //   child: Center(child: Text(
                            //       style: AppTextStyle.font18bold.copyWith(
                            //         color: AppColors.backgroundColor
                            //       ),
                            //       DashboardConst.addAnotherFacility,
                            //
                            //   )
                            //   ),
                            // ),

                            const SizedBox(height: 10),


                            GestureDetector(
                                onTap:(){
                                  // isNext = true;
                                  setState((){});
                                  print("curtne ${_formKey.currentState!.validate()}");
                                  print("org ${facilityController.text}");
                                  print("org ${locationController.text}");
                                  print("org ${dashController.taskTimes}");

                                  String city =    globalStorage.getCity();
                                  String address =   globalStorage.getAddress();
                                  String pincode =     globalStorage.getPincode();
                                  String clientId =   globalStorage.getClientId();


                                  dashBoardBloc.add(
                                      AssignTaskEvent(clientId: int.parse(clientId),
                                        shiftTime: "${shiftTime!.hour}:${shiftTime!.minute}:00",
                                        taskIds: taksIds,
                                        estimatedTime: estimatedTime.toString(),
                                        taskTimes: dashController.taskTimes,
                                        janitorId: buddy.id!,

                                      ));
                                  if( shiftTime != null && dashController.taskStartTime.isNotEmpty && estimatedTime != null ){
                                    // && shiftTime != null && taskStartTime.isNotEmpty && estimatedTime != null
                                    // adminBottomSheet();



                                     // print("org ${facilityController.text}");
                                     // print("org ${locationController.text}");

                                    // dashBoardBloc.add( ClientSetUpEvent(
                                    //   clientId: clientId,
                                    //   orgName: facilityController.text,
                                    //   locality: locationController.text,
                                    //   pincode: pincode,
                                    //   address: address,
                                    //   city: city,
                                    //   //  unitNo: "sd"
                                    // )  );
                                  }


                                  // janitorBottomSheet()
                                      ;                             } ,
                                child: Custombutton(text: "Submit", width: 328.w))

                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }
          );
      },
    )
        .then( (value) {
      dashController.taskStartTime.clear();
      dashController.taskEndTime.clear();
      dashController.taskTimes.clear();
      estimatedTime = null;
      shiftTime = null;
      isNext = false;
    }, ) ;
  }





}





// class BuddyListDailog extends StatefulWidget {
//  final TaskModel? taskModel;
//   const BuddyListDailog({super.key, required this.taskModel});

//   @override
//   State<BuddyListDailog> createState() => _BuddyListDailogState();
// }

// class _BuddyListDailogState extends State<BuddyListDailog> {
//   ClientDashBoardBloc dashBoardBloc  = ClientDashBoardBloc();
//   // GlobalStorage globalStorage = GetIt.instance();
//   List janitors = ["John", "David", "Emma", "Sophia"];
//   String? selectedJanitor;


//   @override
//   Widget build(BuildContext context) {
//     return 
     
//   }
// }
