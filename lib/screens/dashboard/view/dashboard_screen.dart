import 'dart:async';
import 'package:Woloo_Smart_hygiene/core/model/App_launch_model.dart';
import 'package:Woloo_Smart_hygiene/screens/janitor_profile_screen/view/janitor_profile_screen.dart';
import 'package:Woloo_Smart_hygiene/screens/login/view/login_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get_it/get_it.dart';
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

import '../../common_widgets/empty_list_widget.dart';
import '../../common_widgets/error_widget.dart';
import '../data/model/dashboard_model_class.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({
    Key? key,
  }) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int selectedCard = -1;
  GlobalStorage globalStorage = GetIt.instance();
  bool serviceStatus = false;
  bool haspermission = false;
  bool showList = false;
  bool onTapCheckIn = false;
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
   DashboardBloc? _dashboardBloc;
  List<DashboardModelClass> _data = [];
  List<DashboardModelClass> filter = [];

  String dropdownvalue = 'All';

  // List of items in our dropdown menu
  var items = [
    'All',
    'Ongoing',
    'Pending',
    'Accepted',
    'Completed',
    'Request for closure'
  ];


  @override
  void initState() {
    dashboardBloc.add(CheckAttendance());
    dashboardBloc.add(GetTaskTamplates());
    setState(() {
      inTime = globalStorage.getTime();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
        bloc: dashboardBloc,
        listener: (context, state) {
          if (state is AppLaunchLoading) {
            EasyLoading.show(status: state.message);
          }

          if (state is AppLaunchError) {
            EasyLoading.dismiss();
          }

          if (state is AppLaunchSuccess) {
            EasyLoading.dismiss();
            setState(() {
              _appLaunchModel = state.data;
              type = _appLaunchModel.lastAttendance;
            });
            print("appLaunchResponse---->${_appLaunchModel.toJson()}");

            if (_appLaunchModel.lastAttendance == "check_in") {
              print("lastAttendance--->${_appLaunchModel.lastAttendance}");
              setState(() {
                onTapCheckIn = true;
                globalStorage.saveCheckIn(isCheckedIn: true);
                showList = true;
              });
            }

            if (_appLaunchModel.lastAttendance == "check_out") {
              setState(() {
                onTapCheckIn = false;
                showList = false;
                globalStorage.saveCheckIn(isCheckedIn: false);
              });
            }
            setState(() {
              onTapCheckIn = globalStorage.isCheckedIn();
              location = globalStorage.getLocation();
              inTime = globalStorage.getTime();
              outTime = globalStorage.getTime();
            });
          }

          print(state);

          if (state is ClockInSuccessful) {
            EasyLoading.dismiss();

            setState(() {
              onTapCheckIn = true;
              showList = true;
            });
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
            EasyLoading.showError(state.error);
            setState(() {
              onTapCheckIn = true;
              showList = true;
            });
          }

          if (state is ClockOutSuccessful) {
            EasyLoading.dismiss();
            print(state);
            setState(() {
              onTapCheckIn = false;
              showList = false;
            });
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
            EasyLoading.showError(state.error);
            setState(() {
              onTapCheckIn = false;
              showList = false;
            });
          }
        },
        child: Scaffold(
            backgroundColor: AppColors.white,
            appBar: AppBar(
              elevation: 0,
              backgroundColor: AppColors.appbarBgColor,
              title: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 5.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      MydashboardScreenConstants.TITLE_TEXT.tr(),
                      style: TextStyle(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.yellowSplashColor,
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        // EasyLoading.show(status: "Logging out...");
                        // var storage = GetIt.instance<GlobalStorage>();
                        // storage.removeToken();
                        // storage.removeFCMToken();
                        // storage.removeLocation();
                        // storage.removeTime();
                        // await Future.delayed(const Duration(seconds: 3));
                        // EasyLoading.dismiss();
                        // EasyLoading.showToast("Logout success...");
                        // Navigator.pushAndRemoveUntil(
                        //   context,
                        //   MaterialPageRoute(
                        //       builder: (context) => LoginScreen()),
                        //   (route) => false,
                        // );
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => JanitorProfileScreen()

                          ),
                        );
                      },
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.h),
                            // child: Icon(
                            //   Icons.logout,
                            //   color: AppColors.black,
                            //   size: 20.sp,
                            // ),
                            child: Icon(
                              Icons.account_circle_outlined,
                              color: AppColors.yellowSplashColor,
                              size: 25.sp,
                            ),
                          ),
                          // Padding(
                          //   padding: EdgeInsets.symmetric(
                          //       horizontal: 2.w, vertical: 2.h),
                          //   child: Text(
                          //     MydashboardScreenConstants.LOG_OUT,
                          //     style: TextStyle(
                          //         fontSize: 8.sp,
                          //         fontWeight: FontWeight.w600,
                          //         color: Colors.black),
                          //   ),
                          // )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  if (location != null && location != "") ...[
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.w,
                        vertical: 10.h,
                      ),
                      child: Row(
                        children: [
                          Image.asset(
                            AppImages.location_icon_img,
                            height: 14.h,
                            width: 11.w,
                          ),
                          Flexible(
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 5.w),
                              child: Text(
                                "$location " ?? '',
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                softWrap: false,
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.locationColor,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                      vertical: 10.h,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: AppColors.containerBorder,
                            width: 1.w,
                          ),
                          borderRadius: BorderRadius.circular(10.r)),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.w,
                          vertical: 10.h,
                        ),
                        child: Column(
                          children: [

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                onTapCheckIn
                                    ? GestureDetector(
                                        onTap: () async {},
                                        child: Container(
                                          height: 40.h,
                                          width: 40.w,
                                          decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.greyCircleColor),
                                          child: Center(
                                            child: Text(
                                              MydashboardScreenConstants.IN.tr(),
                                              style: TextStyle(color: AppColors.white, fontSize: 12.sp, fontWeight: FontWeight.w700),
                                            ),
                                          ),
                                        ),
                                      )
                                    : GestureDetector(
                                        onTap: () async {
                                          await checkGps();
                                          if (!haspermission) return;

                                          var latitude = double.tryParse(lat) ?? 0;
                                          var longitude = double.tryParse(long) ?? 0;
                                          print("lattttt   " + latitude.toString());
                                          print("longggg   " + longitude.toString());
                                          dashboardBloc.add(MarkAttendance(type: 'check_in', locations: [latitude, longitude]));
                                        },
                                        child: Container(
                                          height: 40.h,
                                          width: 40.w,
                                          decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.acceptButtonColor),
                                          child: Center(
                                            child: Text(
                                              MydashboardScreenConstants.IN,
                                              style: TextStyle(color: AppColors.white, fontSize: 12.sp, fontWeight: FontWeight.w700),
                                            ),
                                          ),
                                        ),
                                      ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 5.w,
                                  ),
                                  child: Container(height: 1.0, width: 150.w, color: AppColors.greyLineColor),
                                ),
                                !onTapCheckIn
                                    ? GestureDetector(
                                        onTap: () {},
                                        child: Container(
                                          height: 40.h,
                                          width: 40.w,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: AppColors.greyCircleColor,
                                          ),
                                          child: Center(
                                            child: Text(
                                              MydashboardScreenConstants.OUT,
                                              style: TextStyle(color: AppColors.white, fontSize: 12.sp, fontWeight: FontWeight.w700),
                                            ),
                                          ),
                                        ),
                                      )
                                    : GestureDetector(
                                        onTap: () {
                                          openDialog();
                                        },
                                        child: Container(
                                          height: 40.h,
                                          width: 40.w,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: AppColors.checkOutColor,
                                          ),
                                          child: Center(
                                            child: Text(
                                              MydashboardScreenConstants.OUT.tr(),
                                              style: TextStyle(color: AppColors.white, fontSize: 12.sp, fontWeight: FontWeight.w700),
                                            ),
                                          ),
                                        ),
                                      ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 10.w,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        MydashboardScreenConstants.CHECK_IN.tr(),
                                        style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w400, color: Colors.black),
                                      ),
                                      onTapCheckIn
                                          ? Text(
                                              inTime,
                                              style: TextStyle(fontSize: 8.sp, fontWeight: FontWeight.w400, color: AppColors.timeColor),
                                            )
                                          : Container(),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        MydashboardScreenConstants.CHECK_OUT.tr(),
                                        style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w400, color: Colors.black),
                                      ),
                                      !onTapCheckIn
                                          ? Text(
                                              outTime,
                                              style: TextStyle(fontSize: 8.sp, fontWeight: FontWeight.w400, color: AppColors.timeColor),
                                            )
                                          : Container(),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                            Center(
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 25.h,
                                    vertical: 10.h
                                ),
                                child: SizedBox(
                                  width:  210,
                                  height: 60,
                                  // height: 70,
                                  child: DropdownButtonFormField(
                                    decoration: const InputDecoration(

                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(30.0),
                                        ),
                                      ),),
                                    elevation: 0,
                                    // Initial Value
                                    value: dropdownvalue,
                                    // Down Arrow Icon
                                    icon: const Icon(Icons.keyboard_arrow_down),

                                    // Array list of items
                                    items: items.map((String items) {
                                      return DropdownMenuItem(

                                        value: items,
                                        child: Text(items.tr()),
                                      );
                                    }).toList(),
                                    dropdownColor: Colors.white,

                                    onChanged: (String? newValue) {
                                      setState(() {
                                        dropdownvalue = newValue!;
                                      });
                                      print('new $newValue ');
                                      if(newValue == "All"){
                                        filter = _data;
                                      }else {
                                        filter =  _data.where( (e)=> e.status == newValue ).toList();
                                      }


                                      print(" filter data${filter}");
                                    },
                                  ),
                                ),
                              ),
                            ),

                          ],
                        ),
                      ),
                    ),
                  ),
                  showList
                      ?



                  BlocConsumer(
                    bloc: dashboardBloc,
                    listener: (context, state) {
                      if (state is GetDashboardDataSuccess) {
                        EasyLoading.dismiss();
                        setState(() {
                          _data = state.data;

                         // filter =  _data  ;

                          if(dropdownvalue == "All"){
                            filter = _data;
                          }else {
                            filter =  _data.where( (e)=> e.status == dropdownvalue ).toList();
                          }

                           print(" filteredddd   $filter");
                        });
                      }

                      if (state is UpdateStatusSuccessful) {
                        EasyLoading.dismiss();
                        print("status updated");
                      }
                    },
                     builder: (context, state) {

                       if (state is DashboardLoading && _data.isEmpty) {
                         EasyLoading.show(status: MydashboardScreenConstants.LOADING_TOAST.tr());
                       }

                       if (state is DashboardError) {
                         return CustomErrorWidget(error: state.error);
                       }

                       if (state is UpdateStatusError) {
                         return CustomErrorWidget(error: state.error);
                       }
                       if (state is UpdateStatusLoading) {
                         EasyLoading.show(status: MydashboardScreenConstants.LOADING_TOAST.tr());
                       }

                       if (state is GetDashboardDataSuccess && _data.isEmpty) {
                         EasyLoading.dismiss();
                         return EmptyListWidget();
                       }

                    return   DashboardListWidget(
                         current_lattitude: lat,
                         current_longitude: long,
                          filter: filter,
                          dashboardBloc: dashboardBloc,
                         onTapItem: () {
                           print("lattitudeee " + lat!);
                           print("longitudeee " + long!);
                         },
                       );
                     }
                  )
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
                                Image.asset(
                                  AppImages.blank_list_img,
                                  height: 100.h,
                                  width: 100.w,
                                ),
                                Text(
                                  MydashboardScreenConstants.BLANK_LIST_TEXT.tr(),
                                  maxLines: 2,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: AppColors.black,
                                    fontSize: 24.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                ],
              ),
            )));
  }

  checkGps() async {
    EasyLoading.show(status: MydashboardScreenConstants.LOCATION_FETCHING_TOAST.tr());
    serviceStatus = await Geolocator.isLocationServiceEnabled();
    if (serviceStatus) {
      permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          print('Location permissions are denied');
        } else if (permission == LocationPermission.deniedForever) {
          print("'Location permissions are permanently denied");
        } else {
          haspermission = true;
        }
      } else {
        haspermission = true;
      }

      if (haspermission) {
        await getLocation();
      }

      EasyLoading.dismiss();
    } else {
      EasyLoading.dismiss();
      EasyLoading.showToast(MydashboardScreenConstants.GPS_DISABLED_TOAST.tr());
    }
  }

  getLocation() async {
    position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    print(position.longitude); //Output: 80.24599079
    print(position.latitude); //Output: 29.6593457

    long = position.longitude.toString();
    lat = position.latitude.toString();

    LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high, //accuracy of the location data
      distanceFilter: 100, //minimum distance (measured in meters) a
    );

    StreamSubscription<Position> positionStream = Geolocator.getPositionStream(locationSettings: locationSettings).listen((Position position) {
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
    await placemarkFromCoordinates(position.latitude, position.longitude).then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      setState(() {
        _currentAddress = '${place.name},${place.street}, ${place.subLocality},${place.subAdministrativeArea}, ${place.administrativeArea},${place.postalCode}';
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

            dashboardBloc.add(MarkAttendance(type: 'check_out', locations: [latitude, longitude]));
          },
          onTapCancel: () {
            Navigator.pop(context);
          },
        );
      },
    );
  }
}
