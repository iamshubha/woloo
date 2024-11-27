import 'dart:async';
import 'package:Woloo_Smart_hygiene/core/model/App_launch_model.dart';
import 'package:Woloo_Smart_hygiene/screens/common_widgets/image_provider.dart';
import 'package:Woloo_Smart_hygiene/screens/dashboard/controller/dash_controller.dart';
import 'package:Woloo_Smart_hygiene/screens/dashboard/view/dashboard_screen.dart';
import 'package:Woloo_Smart_hygiene/screens/janitor_profile_screen/view/janitor_profile_screen.dart';
import 'package:Woloo_Smart_hygiene/utils/app_textstyle.dart';
import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart' hide Trans;
// import 'package:get/state_manager.dart';
import 'package:get_it/get_it.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:Woloo_Smart_hygiene/core/local/global_storage.dart';
import 'package:Woloo_Smart_hygiene/screens/common_widgets/custom_dialogue_widget.dart';
import 'package:Woloo_Smart_hygiene/screens/dashboard/bloc/dashboard_bloc.dart';
import 'package:Woloo_Smart_hygiene/screens/dashboard/bloc/dashboard_event.dart';
import 'package:Woloo_Smart_hygiene/screens/dashboard/bloc/dashboard_state.dart';
import 'package:Woloo_Smart_hygiene/screens/dashboard/view/local_widgets/dashboard_list.dart';
import 'package:Woloo_Smart_hygiene/utils/app_color.dart';
import 'package:Woloo_Smart_hygiene/utils/app_constants.dart';
import 'package:Woloo_Smart_hygiene/utils/app_images.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../common_widgets/error_widget.dart';
import '../../common_widgets/swipe_button.dart';
import '../data/model/dashboard_model_class.dart';
import 'iot_task.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({
    Key? key,
  }) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> with SingleTickerProviderStateMixin, WidgetsBindingObserver{
  int selectedCard = -1;
  GlobalStorage globalStorage = GetIt.instance();
  bool serviceStatus = false;
  bool haspermission = false;
  bool showList = false;
  bool onTapCheckIn = false;
  String profileName = "";
  String profileImage = "";
   String profileshift = "";
  String check_in_time = "";
  String check_out_time = "";
  String inTime = "";
  String outTime = "";
  late LocationPermission permission;
  late Position position;
  String long = "", lat = "";
  String? _currentAddress;
  DateTime currentTime = DateTime.now();
  late StreamSubscription<Position> positionStream;
  String? location;
  DashboardBloc dashboardBloc = DashboardBloc();
  AppLaunchModel _appLaunchModel = AppLaunchModel();
  String? type;
  List<DashboardModelClass> _data = [];
  List<DashboardModelClass> filter = [];
  DashController dashController = Get.put(DashController());
  final AppinioSwiperController pendingCtrl = AppinioSwiperController();
  final AppinioSwiperController acceptCtrl = AppinioSwiperController();
  final AppinioSwiperController rfcCtrl = AppinioSwiperController();
  final AppinioSwiperController ongoingCtrl = AppinioSwiperController();
  final AppinioSwiperController completeCtrl = AppinioSwiperController();
  String dropdownvalue = 'All';
        int _selectedIndex = 0;
   static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
    List<Widget> _widgetOptions = <Widget>[ ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
    int? _selectedLanguage;
  final List<String> _languages = ["English", "हिंदी", "मराठी"];
  final List<Locale> _locales = const [
    Locale('en', 'US'),
    Locale('hi', 'IN'),
    Locale('mr', 'IN')
  ];


  // List of items in our dropdown menu
  var items = [
    'All',
    'Ongoing',
    'Pending',
    'Accepted',
    'Completed',
    'Request for closure'
  ];
 
  //  @override
  // void didChangeAppLifecycleState(AppLifecycleState state) {
  //   super.didChangeAppLifecycleState(state);
  //   print('Current state = ${state}');

    

  // }


  @override
  void initState() {
      WidgetsBinding.instance.addObserver(this);

     
  
   dashboardBloc.add(CheckAttendance());

    setState(() {
      inTime = globalStorage.getTime();

      profileName  =      globalStorage.getProfileName() ;
         profileImage  =      globalStorage.getProfileImage() ;
         profileshift  =      globalStorage.getShift() ;
    });
            dashboardBloc.add(const GetTaskTamplates());
     print("profile $profileImage");
     // if(_appLaunchModel.lastAttendance == "check_in"){
     //   setUpTimedFetch();
     // }

    super.initState();
  }
 

   setUpTimedFetch() {
    Timer.periodic(Duration(milliseconds: 5000), (timer) {
      // setState(() {
       print("df ${_appLaunchModel.lastAttendance}");
          if( _appLaunchModel.lastAttendance == "check_in" ){
            dashboardBloc.add(const GetTaskTamplates());
          }

      //  _future = getSakaryaAir();
      // });
    });
  }

  @override
  void dispose() {
     WidgetsBinding.instance.removeObserver(this);
    // TODO: implement dispose
    super.dispose();
  }
 
  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      bloc: dashboardBloc,
      listener: (context, state) {
        print(" dashbaordddd $state ");
      },
      builder: (context, state) {
        print("dashboard ka state $state ");
        if (state is AppLaunchLoading) {
          EasyLoading.show(status: state.message);
        }

        if (state is AppLaunchError) {
          EasyLoading.dismiss();
        }

        if (state is AppLaunchSuccess) {
          EasyLoading.dismiss();

          _appLaunchModel = state.data;
          type = _appLaunchModel.lastAttendance;

          print("appLaunchResponse---->${_appLaunchModel.toJson()}");

          if (_appLaunchModel.lastAttendance == "check_in") {
            dashboardBloc.add(const GetTaskTamplates());

            print("lastAttendance--->${_appLaunchModel.lastAttendance}");

            onTapCheckIn = true;
            globalStorage.saveCheckIn(isCheckedIn: true);
            showList = true;
          }

          if (_appLaunchModel.lastAttendance == "check_out") {
            onTapCheckIn = false;
            showList = false;
            globalStorage.saveCheckIn(isCheckedIn: false);
          }

          onTapCheckIn = globalStorage.isCheckedIn();
          location = globalStorage.getLocation();
          inTime = globalStorage.getTime();
          outTime = globalStorage.getTime();
        }

        print(state);

        if (state is ClockInSuccessful) {
          EasyLoading.dismiss();
          dashboardBloc.add(const GetTaskTamplates());
          dashController.mapGetDashboardToState();
          onTapCheckIn = true;
          showList = true;

          String formattedDate = DateFormat('hh:mm:ss  a').format(currentTime);
          check_in_time = formattedDate;

          globalStorage.saveTime(accessTime: check_in_time);
          inTime = globalStorage.getTime();
        }
        if (state is ClockInLoading) {
          EasyLoading.show(status: state.message);
        }

        if (state is ClockInError) {
          EasyLoading.dismiss();
          EasyLoading.showError(state.error.message);

          onTapCheckIn = true;
          showList = true;

        }

        if (state is ClockOutSuccessful) {
          EasyLoading.dismiss();
          print(state);

          onTapCheckIn = false;
          showList = false;

          String formattedDate = DateFormat('hh:mm:ss  a').format(currentTime);
          check_out_time = formattedDate;
          globalStorage.saveTime(accessTime: check_out_time);
          outTime = globalStorage.getTime();
        }
        if (state is ClockOutLoading) {
          EasyLoading.show(status: state.message);
        }
        if (state is ClockOutError) {
          EasyLoading.dismiss();
          print("onTapCheckIn----->$onTapCheckIn");
          EasyLoading.showError(state.error.message);

          onTapCheckIn = false;
          showList = false;
        }
        _widgetOptions = [
          Obx(
            ()=> RegularTask(
                dashboardBloc: dashboardBloc,
                filter: dashController.filterData.value,
                lat: lat,
                long: long
            ),
          ),
          Obx(
             ()=> IotTask(
              dashboardBloc: dashboardBloc,
              filter: dashController.filterData.value.where( (e)=> e.requestType  == "IOT" ).toList(),
              lat: lat,
              long: long
              ,
            ),
          )
        ];
        return Scaffold(
            backgroundColor: AppColors.white,
            appBar: AppBar(
              elevation: 0,
              backgroundColor: AppColors.white,
              title: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 5.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      MydashboardScreenConstants.TITLE_TEXT.tr(),
                      style: AppTextStyle.font24.copyWith(
                          color: AppColors.black, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              actions: [
                InkWell(
                  onTap: () {
                    settingModalBottomSheet(context);
                  },
                  child: Container(
                    // width: 35.w,
                    //   height: 35.h,
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2), // Shadow color
                          spreadRadius: 1, // How wide the shadow should spread
                          blurRadius: 10, // The blur effect of the shadow
                          offset:
                              Offset(0, 0), // No offset for shadow on all sides
                        ),
                      ],
                    ),
                    child: Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                      child: CustomImageProvider(
                        image: AppImages.languageIcons,
                        width: 30.w,
                        height: 30.h,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const JanitorProfileScreen()),
                    );
                  },
                  child: SizedBox(
                    width: 65.w,
                    height: 65.h,
                    child: CustomImageProvider(
                      image: AppImages.profileIcons,
                      width: 75.w,
                      height: 75.h,
                      fit: BoxFit.cover,
                    ),
                  ),
                )
              ],
            ),
            body: RefreshIndicator(
              onRefresh: () {
                return Future.delayed(
                  Duration(seconds: 1),
                      () {
                    dashboardBloc.add(const GetTaskTamplates());
                  },
                );
              },
              child: SingleChildScrollView(
                 // physics: NeverScrollableScrollPhysics(),
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                      vertical: 10.h,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                          color: AppColors
                              .white, // Background color of the container
                          boxShadow: [
                            BoxShadow(
                              color:
                                  Colors.black.withOpacity(0.2), // Shadow color
                              spreadRadius:
                                  1, // How wide the shadow should spread
                              blurRadius: 10, // The blur effect of the shadow
                              offset: Offset(
                                  0, 0), // No offset for shadow on all sides
                            ),
                          ],
                          // border:
                          // Border.all(
                          //   color: AppColors.containerBorder,
                          //   width: 0.w,
                          // ),
                          borderRadius: BorderRadius.circular(25.r)),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.w,
                          vertical: 10.h,
                        ),
                        child: Column(
                          // mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              // mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                               // Image.network(
                               //      "https://woloo-taskmanagement-s3bucket.s3.ap-south-1.amazonaws.com/$profileImage"),
                                SizedBox(
                                  width: 12.w,
                                ),
                                Column(
                                  children: [
                                    Container(
                                      width: 220.w,
                                      child: Row(
                                        children: [
                                          Text(
                                           profileName,
                                            style: AppTextStyle.font14w7,
                                          ),
                                          Spacer(),
                                          Text(
                                            profileshift,
                                            style: AppTextStyle.font14w7,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Divider(),
                                    if (location != null && location != "") ...[
                                      Container(
                                        width: 224.w,
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                Flexible(
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: Colors.black
                                                                .withOpacity(
                                                                    0.2), // Shadow color
                                                            spreadRadius:
                                                                1, // How wide the shadow should spread
                                                            blurRadius:
                                                                10, // The blur effect of the shadow
                                                            offset: Offset(0,
                                                                0), // No offset for shadow on all sides
                                                          ),
                                                        ],
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                25.r),
                                                        color: AppColors.white),
                                                    padding: EdgeInsets.all(4.w),
                                                    child: Text(
                                                        "$location " ?? '',
                                                        overflow:
                                                            TextOverflow.ellipsis,
                                                        maxLines: 1,
                                                        softWrap: false,
                                                        style: AppTextStyle
                                                            .font14bold
                                                            .copyWith(
                                                          color: AppColors
                                                              .locationColor,
                                                        )
                                                        // TextStyle(
                                                        //   fontSize: 12.sp,
                                                        //   fontWeight: FontWeight.w400,
                                                        //   color: AppColors.locationColor,
                                                        // ),
                                                        ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      // SizedBox(
                                      //   height: 5.h,
                                      // ),
                                    ],
                                  ],
                                ),
                              ],
                            ),

                            Divider(),

                            // SizedBox(
                            //   height: 12.h,
                            // ),

                            Center(
                              child: Container(
                                width: 108.w,
                                height: 28.w,
                                decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black
                                            .withOpacity(0.2), // Shadow color
                                        spreadRadius:
                                            1, // How wide the shadow should spread
                                        blurRadius:
                                            10, // The blur effect of the shadow
                                        offset: Offset(0,
                                            0), // No offset for shadow on all sides
                                      ),
                                    ],
                                    borderRadius: BorderRadius.circular(25.r),
                                    color: AppColors.acceptButtonColor),
                                child: Center(
                                  child: Text(
                                    MyJanitorsListScreenConstants.JANITOR_PRESENT.tr(),
                                    // MydashboardScreenConstants.,
                                    style: AppTextStyle.font14bold,
                                  ),
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                onTapCheckIn
                                    ? GestureDetector(
                                        onTap: () async {},
                                        child: Container(
                                          height: 70.h,
                                          width: 70.w,
                                          decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: AppColors.greyCircleColor),
                                          child: Center(
                                            child: Text(
                                                MydashboardScreenConstants.IN
                                                    .tr(),
                                                style: AppTextStyle.font24bold
                                                    .copyWith(
                                                  color: AppColors.white,
                                                )
                                                //  TextStyle(
                                                //     color: AppColors.white,
                                                //     fontSize: 12.sp,
                                                //     fontWeight: FontWeight.w700),
                                                ),
                                          ),
                                        ),
                                      )
                                    : GestureDetector(
                                        onTap: () async {
                                          await checkGps();
                                          if (!haspermission) return;

                                          var latitude =
                                              double.tryParse(lat) ?? 0;
                                          var longitude =
                                              double.tryParse(long) ?? 0;
                                          print(
                                              "lattttt   " + latitude.toString());
                                          print("longggg   " +
                                              longitude.toString());
                                          dashboardBloc.add(MarkAttendance(
                                              type: 'check_in',
                                              locations: [latitude, longitude]));
                                        },
                                        child: Container(
                                          height: 70.h,
                                          width: 70.w,
                                          decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: AppColors.acceptButtonColor),
                                          child: Center(
                                            child: Text(
                                                MydashboardScreenConstants.IN,
                                                style: AppTextStyle.font24bold
                                                    .copyWith(
                                                  color: AppColors.white,
                                                )
                                                //  TextStyle(
                                                //     color: AppColors.white,
                                                //     fontSize: 12.sp,
                                                //     fontWeight: FontWeight.w700),
                                                ),
                                          ),
                                        ),
                                      ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 5.w,
                                  ),
                                  child:
                                  Column(
                                    children: [
                                      Container(
                                          height: 1.0,
                                          width: 90.w,
                                          color: AppColors.greyLineColor),
                                       SizedBox(
                                         height: 10.h,
                                       ),
                                       Text(MydashboardScreenConstants.PULL_TO_REFRESH.tr(),
                                        style: AppTextStyle.font12bold,
                                       )
                                    ],
                                    
                                  ),
                                ),
                                !onTapCheckIn
                                    ? GestureDetector(
                                        onTap: () {},
                                        child: Container(
                                          height: 70.h,
                                          width: 70.w,
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: AppColors.greyCircleColor,
                                          ),
                                          child: Center(
                                            child: Text(
                                                MydashboardScreenConstants.OUT,
                                                style: AppTextStyle.font24bold
                                                    .copyWith(
                                                  color: AppColors.white,
                                                )
                                                //  TextStyle(
                                                //     color: AppColors.white,
                                                //     fontSize: 12.sp,
                                                //     fontWeight: FontWeight.w700),
                                                ),
                                          ),
                                        ),
                                      )
                                    : GestureDetector(
                                        onTap: () {
                                          openDialog();
                                        },
                                        child: Container(
                                          height: 70.h,
                                          width: 70 .w,
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: AppColors.checkOutColor,
                                          ),
                                          child: Center(
                                            child: Text(
                                                MydashboardScreenConstants.OUT
                                                    .tr(),
                                                style: AppTextStyle.font20bold
                                                    .copyWith(
                                                  color: AppColors.white,
                                                )
                                                //  TextStyle(
                                                //     color: AppColors.white,
                                                //     fontSize: 12.sp,
                                                //     fontWeight: FontWeight.w700),
                                                ),
                                          ),
                                        ),
                                      ),
                              ],
                            ),
                            // Padding(
                            //   padding: EdgeInsets.symmetric(
                            //     horizontal: 10.w,
                            //   ),
                            //   child: Row(
                            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //     crossAxisAlignment: CrossAxisAlignment.start,
                            //     children: [
                            //       Column(
                            //         children: [
                            //           Text(
                            //               MydashboardScreenConstants.CHECK_IN
                            //                   .tr(),
                            //               style: AppTextStyle.font12
                            //                   .copyWith(color: Colors.black)
                            //               // TextStyle(
                            //               //     fontSize: 12.sp,
                            //               //     fontWeight: FontWeight.w400,
                            //               //     color: Colors.black),
                            //               ),
                            //           onTapCheckIn
                            //               ? Text(inTime,
                            //                   style: AppTextStyle.font8
                            //                       .copyWith(color: Colors.black)
                            //                   //  TextStyle(
                            //                   //     fontSize: 8.sp,
                            //                   //     fontWeight: FontWeight.w400,
                            //                   //     color: AppColors.timeColor),
                            //                   )
                            //               : Container(),
                            //         ],
                            //       ),
                            //       Column(
                            //         children: [
                            //           Text(
                            //               MydashboardScreenConstants.CHECK_OUT
                            //                   .tr(),
                            //               style: AppTextStyle.font12
                            //                   .copyWith(color: Colors.black)
                            //               // TextStyle(
                            //               //     fontSize: 12.sp,
                            //               //     fontWeight: FontWeight.w400,
                            //               //     color: Colors.black),
                            //               ),
                            //           !onTapCheckIn
                            //               ? Text(outTime,
                            //                   style: AppTextStyle.font8.copyWith(
                            //                       color: AppColors.timeColor)
                            //                   //  TextStyle(
                            //                   //     fontSize: 8.sp,
                            //                   //     fontWeight: FontWeight.w400,
                            //                   //     color: AppColors.timeColor),
                            //                   )
                            //               : Container(),
                            //         ],
                            //       ),
                            //     ],
                            //   ),
                            // ),
                            // Center(
                            //   child: Padding(
                            //     padding: EdgeInsets.symmetric(
                            //         horizontal: 25.h, vertical: 10.h),
                            //     child: SizedBox(
                            //       width: 210,
                            //       height: 60,
                            //       // height: 70,
                            //       child: DropdownButtonFormField(
                            //         decoration: const InputDecoration(
                            //           border: OutlineInputBorder(
                            //             borderRadius: BorderRadius.all(
                            //               Radius.circular(30.0),
                            //             ),
                            //           ),
                            //         ),
                            //         elevation: 0,
                            //         // Initial Value
                            //         value: dropdownvalue,
                            //         // Down Arrow Icon
                            //         icon: const Icon(Icons.keyboard_arrow_down),

                            //         // Array list of items
                            //         items: items.map((String items) {
                            //           return DropdownMenuItem(
                            //             value: items,
                            //             child: Text(items.tr()),
                            //           );
                            //         }).toList(),
                            //         dropdownColor: Colors.white,

                            //         onChanged: (String? newValue) {
                            //           setState(() {
                            //             dropdownvalue = newValue!;
                            //           });

                            //           print('new $newValue ');
                            //           if (newValue == "All") {
                            //             dashController.filterData.value =
                            //                 dashController.data.value;
                            //           } else {
                            //             dashController.filterData.value =
                            //                 dashController.data.value
                            //                     .where(
                            //                         (e) => e.status == newValue)
                            //                     .toList();
                            //           }

                            //           print(
                            //               " filter data${dashController.filterData.value}");
                            //         },
                            //       ),
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  showList
                      ? BlocConsumer(
                          bloc: dashboardBloc,
                          listener: (context, state) {
                            print("innnner dashvaord $state ");
                            if (state is GetDashboardDataSuccess) {
                              EasyLoading.dismiss();
                            }

                            if (state is UpdateStatusSuccessful) {
                              EasyLoading.dismiss();
                              print("status updated");
                            }
                          },
                          builder: (context, state) {
                            if (state is DashboardLoading && _data.isEmpty) {
                              EasyLoading.show(
                                  status: MydashboardScreenConstants.LOADING_TOAST
                                      .tr());
                            }

                            if (state is DashboardError) {
                              return CustomErrorWidget(error: state.error.message);
                            }

                            if (state is UpdateStatusError) {
                              return CustomErrorWidget(error: state.error.message);
                            }
                            if (state is UpdateStatusLoading) {
                              EasyLoading.show(
                                  status: MydashboardScreenConstants.LOADING_TOAST
                                      .tr());
                            }

                            if (state is GetDashboardDataSuccess) {
                              EasyLoading.dismiss();

                              // filter =  dashController.data.value!;

                              //    if(dropdownvalue == "All"){
                              //            print(" data from gextg ${dashController.data.value}");
                              //                filter.value = dashController.data.value;
                              //    //   filter = _data;
                              //    }else {
                              //      filter.value =
                              //      //  dashController.data.value.where()
                              //     dashController.data.value.where( (e)=> e.status == dropdownvalue ).toList();
                              //    }
                              //    print(" Allll   ${filter.map( (e) =>  e.requestType)}");
                            }

                            return Container(
                              height: 425.h,
                                child: _widgetOptions.elementAt(_selectedIndex));
                          })
                      : Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 20.w,
                              vertical: 10.h,
                            ),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 100.h,
                                ),
                                CustomImageProvider(
                                  image: AppImages.blank_list_img,
                                  height: 100.h,
                                  width: 100.w,
                                ),
                                Text(
                                    MydashboardScreenConstants.BLANK_LIST_TEXT
                                        .tr(),
                                    maxLines: 2,
                                    textAlign: TextAlign.center,
                                    style: AppTextStyle.font24.copyWith(
                                      color: AppColors.black,
                                    )
                                    //  TextStyle(
                                    //   color: AppColors.black,
                                    //   fontSize: 24.sp,
                                    //   fontWeight: FontWeight.w400,
                                    // ),
                                    )
                              ],
                            ),
                          ),
                        )
                ]),
              ),
            ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: AppColors.white,
        elevation: 15,
        unselectedItemColor:  AppColors.black,
        unselectedLabelStyle:  AppTextStyle.font12bold,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.task_outlined,
             size: 30,
            ),
            label: 'Regular Task',

          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bus_alert),
            label: 'IOT Task',

          ),
        
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: AppColors.buttonBgColor,
        onTap: _onItemTapped,
      ),
            );
      },

      //  child:
    );
    //
    // );
  }

  checkGps() async {
    // EasyLoading.show(
    //     status: MydashboardScreenConstants.LOCATION_FETCHING_TOAST.tr());
    serviceStatus = await Geolocator.isLocationServiceEnabled();
    if (serviceStatus) {
      permission = await Geolocator.checkPermission();

      print("permission $permission");
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          print('Location permissions are denied');
          // permission = await Geolocator.requestPermission();
        } else if (permission == LocationPermission.deniedForever) {
          print('print me');
          //  print("Location permissions are permanently denied");
          openAppSettings();
          //  permission = await Geolocator.requestPermission();
        } else if (permission == LocationPermission.always ||
            permission == LocationPermission.whileInUse) {
          haspermission = true;
        }
      } else if (permission == LocationPermission.deniedForever) {
        print('denieddsdddd forever');
        openAppSettings();
        //  permission = await Geolocator.requestPermission();
      } else if (permission == LocationPermission.always ||
          permission == LocationPermission.whileInUse) {
        haspermission = true;
      }

      print("given the permsiion $haspermission");
      print("permission222222 $permission");
      if (haspermission) {
        await getLocation();
      }

      EasyLoading.dismiss();
    } else {
      EasyLoading.dismiss();
      EasyLoading.showToast(MydashboardScreenConstants.GPS_DISABLED_TOAST.tr());
    }

    return haspermission;
  }

  getLocation() async {
    print("get location");
    position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    print(" posr${position.longitude}"); //Output: 80.24599079
    print(position.latitude); //Output: 29.6593457

    long = position.longitude.toString();
    lat = position.latitude.toString();

    LocationSettings locationSettings = const LocationSettings(
      accuracy: LocationAccuracy.high, //accuracy of the location data
      distanceFilter: 100, //minimum distance (measured in meters) a
    );

    StreamSubscription<Position> positionStream =
        Geolocator.getPositionStream(locationSettings: locationSettings)
            .listen((Position position) {
      print(position.longitude); //Output: 80.24599079
      print(position.latitude); //Output: 29.6593457

      long = position.longitude.toString();
      lat = position.latitude.toString();
      globalStorage.saveLattitude(accessLatitude: lat);
      globalStorage.saveLongitude(accessLongitude: long);

      print(" lattttt---- > ${globalStorage.getLatitude()}");
      print(" longitttt---- > ${globalStorage.getLongitude()}");

      _getAddressFromLatLng(position);
    });
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(position.latitude, position.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      setState(() {
        _currentAddress =
            '${place.name},${place.street}, ${place.subLocality},${place.subAdministrativeArea}, ${place.administrativeArea},${place.postalCode}';
        print("address - $_currentAddress");

        globalStorage.saveLocation(accessLocation: _currentAddress ?? '');
        location = globalStorage.getLocation();

        print("locccccc --- > ${globalStorage.getLocation()}");
      });
    }).catchError((e) {
      debugPrint(e);
    });
  }

  openDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomDialogueWidget(
          text: MydashboardScreenConstants.POPUP_TITLE.tr(),
          onTapSubmit: () async {
            Navigator.pop(context);
            await checkGps();

            if (!haspermission) return;

            double latitude = double.tryParse(lat) ?? 0;
            double longitude = double.tryParse(long) ?? 0;

            dashboardBloc.add(MarkAttendance(
                type: 'check_out', locations: [latitude, longitude]));
          },
          onTapCancel: () {
            Navigator.pop(context);
          },
        );
      },
    );
  }

    void settingModalBottomSheet(BuildContext context) async {
    await Future.delayed(const Duration(milliseconds: 500));
    if (!context.mounted) return;
    await showModalBottomSheet(
      context: context,
      isDismissible: true,
      builder: (BuildContext cont) {
        return Container(
          height: 200.h,
          decoration: BoxDecoration(
            color: Colors.transparent,
            border: Border.all(
              color: AppColors.yellowIcon,
              width: 2,
            ),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.r),
              topRight: Radius.circular(20.r),
            ),
          ),
          child: Column(
            children: [
              SizedBox(height: 10.h),
              Text(
                "Select Language",
                style: TextStyle(fontSize: 18.sp),
              ),
              SizedBox(height: 10.h),
              Expanded(
                child: ListView.separated(
                  itemCount: _languages.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(_languages[index]),
                      titleAlignment: ListTileTitleAlignment.center,
                      onTap: () {
                        _selectedLanguage = index;
                        context.setLocale(_locales[_selectedLanguage ?? 0]);
                        Get.updateLocale(_locales[_selectedLanguage ?? 0]);
                        Navigator.pop(context);
                      },
                    );
                  },
                  separatorBuilder: (context, index) =>
                      const Divider(height: 0),
                ),
              ),
            ],
          ),
        );
      },
    );
    if (!context.mounted) return;
    context.setLocale(_locales[_selectedLanguage ?? 0]);
  }
}
