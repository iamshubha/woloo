import 'dart:async';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:janitor/core/local/global_storage.dart';
import 'package:janitor/screens/common_widgets/custom_dialogue_widget.dart';
import 'package:janitor/screens/common_widgets/empty_list_widget.dart';
import 'package:janitor/screens/common_widgets/error_widget.dart';
import 'package:janitor/screens/dashboard/bloc/dashboard_bloc.dart';
import 'package:janitor/screens/dashboard/bloc/dashboard_event.dart';
import 'package:janitor/screens/dashboard/bloc/dashboard_state.dart';
import 'package:janitor/screens/dashboard/data/model/dashboard_model_class.dart';
import 'package:janitor/screens/dashboard/view/local_widgets/dashboard_list.dart';
import 'package:janitor/screens/login/view/login_screen.dart';
import 'package:janitor/screens/supervisor_dashboard/view/local_widgets/supervisor_dashboard_list.dart';
import 'package:janitor/utils/app_color.dart';
import 'package:janitor/utils/app_constants.dart';
import 'package:janitor/utils/app_images.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class Dashboard extends StatefulWidget {
  // final bool isFromJanitor;
  // final bool isFromSupervisor;
  const Dashboard({
    Key? key,
    // required this.isFromJanitor,
    // required this.isFromSupervisor,
  }) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  late final FirebaseMessaging _messaging;

  int selectedCard = -1;
  GlobalStorage globalStorage = GetIt.instance();

  bool servicestatus = false;
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
  late final FirebaseMessaging _firebaseMessaging;
  late DashboardBloc _dashboardBloc;

  late StreamSubscription<Position> positionStream;
  String? location;
  final iconList = <IconData>[
    Icons.brightness_5,
    Icons.brightness_4,
    Icons.brightness_6,
    Icons.brightness_7,
  ];
  DashboardBloc dashboardBloc = DashboardBloc();
  List<DashboardModelClass> _data = [];

  @override
  void initState() {
    setState(() {
      onTapCheckIn = globalStorage.isCheckedIn();
      location = globalStorage.getLocation();

      if (onTapCheckIn) showList = true;

      inTime = globalStorage.getTime();
      outTime = globalStorage.getTime();
      _dashboardBloc = DashboardBloc();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
        bloc: dashboardBloc,
        listener: (context, state) {
          print(state);

          if (state is ClockInSuccessful) {
            EasyLoading.dismiss();

            setState(() {
              showList = true;
              onTapCheckIn = true;
              print("clockIn ---- >" + location.toString());
            });
            String formattedDate =
                DateFormat('hh:mm:ss  a').format(currentTime);
            check_in_time = formattedDate;

            globalStorage.saveTime(accessTime: check_in_time);
            inTime = globalStorage.getTime();

            // String date = DateFormat('dd-MM-yyyy').format(currentTime);
            // print("Date : $date");
          }
          if (state is ClockInLoading) {
            EasyLoading.show(status: state.message);
          }

          if (state is ClockInError) {
            EasyLoading.dismiss();
            EasyLoading.showError(state.error);
          }

          if (state is ClockOutSuccessful) {
            EasyLoading.dismiss();
            print(state);
            setState(() {
              showList = false;
              onTapCheckIn = false;
              print("clockOut ---- >" + location.toString());
            });
            String formattedDate =
                DateFormat('hh:mm:ss  a').format(currentTime);
            check_out_time = formattedDate;
            globalStorage.saveTime(accessTime: check_out_time);

            outTime = globalStorage.getTime();

            //
            // String date = DateFormat('dd-MM-yyyy').format(currentTime);
            // print("Date : $date");
          }
          if (state is ClockOutLoading) {
            EasyLoading.show(status: state.message);
          }
          if (state is ClockOutError) {
            EasyLoading.dismiss();
            EasyLoading.showError(state.error);
          }
        },
        child: Scaffold(
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
                      MydashboardScreenConstants.TITLE_TEXT,
                      style: TextStyle(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    ),
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () async {
                            EasyLoading.show(status: "Logging out...");
                            var storage = GetIt.instance<GlobalStorage>();
                            storage.removeToken();
                            await Future.delayed(const Duration(seconds: 3));
                            EasyLoading.dismiss();
                            EasyLoading.showToast("Logout success...");
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginScreen()),
                              (route) => false,
                            );
                          },
                          child: Icon(
                            Icons.logout,
                            color: AppColors.black,
                            size: 25.sp,
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            EasyLoading.show(status: "Logging out...");
                            var storage = GetIt.instance<GlobalStorage>();
                            storage.removeToken();
                            await Future.delayed(const Duration(seconds: 3));
                            EasyLoading.dismiss();
                            EasyLoading.showToast("Logout success...");
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginScreen()),
                              (route) => false,
                            );
                          },
                          child: Text(
                            MydashboardScreenConstants.LOG_OUT,
                            style: TextStyle(
                              fontSize: 8.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            body: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
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
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: AppColors.greyCircleColor),
                                          child: Center(
                                            child: Text(
                                              "In",
                                              style: TextStyle(
                                                  color: AppColors.white,
                                                  fontSize: 12.sp,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                          ),
                                        ),
                                      )
                                    : GestureDetector(
                                        onTap: () async {
                                          await checkGps();
                                          if (!haspermission) return;

                                          var latitude =
                                              double.tryParse(lat!) ?? 0;
                                          var longitude =
                                              double.tryParse(long!) ?? 0;
                                          print("lattttt   " +
                                              latitude.toString());
                                          print("longggg   " +
                                              longitude.toString());
                                          dashboardBloc.add(MarkAttendance(
                                              type: 'check_in',
                                              locations: [
                                                latitude,
                                                longitude
                                              ]));
                                        },
                                        child: Container(
                                          height: 40.h,
                                          width: 40.w,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color:
                                                  AppColors.acceptButtonColor),
                                          child: Center(
                                            child: Text(
                                              "In",
                                              style: TextStyle(
                                                  color: AppColors.white,
                                                  fontSize: 12.sp,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                          ),
                                        ),
                                      ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 5.w,
                                  ),
                                  child: Container(
                                      height: 1.0,
                                      width: 150.w,
                                      color: AppColors.greyLineColor),
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
                                              "Out",
                                              style: TextStyle(
                                                  color: AppColors.white,
                                                  fontSize: 12.sp,
                                                  fontWeight: FontWeight.w700),
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
                                              "Out",
                                              style: TextStyle(
                                                  color: AppColors.white,
                                                  fontSize: 12.sp,
                                                  fontWeight: FontWeight.w700),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        MydashboardScreenConstants.CHECK_IN,
                                        style: TextStyle(
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.black),
                                      ),
                                      onTapCheckIn
                                          ? Text(
                                              inTime,
                                              style: TextStyle(
                                                  fontSize: 8.sp,
                                                  fontWeight: FontWeight.w400,
                                                  color: AppColors.timeColor),
                                            )
                                          : Container(),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        MydashboardScreenConstants.CHECK_OUT,
                                        style: TextStyle(
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.black),
                                      ),
                                      !onTapCheckIn
                                          ? Text(
                                              outTime,
                                              style: TextStyle(
                                                  fontSize: 8.sp,
                                                  fontWeight: FontWeight.w400,
                                                  color: AppColors.timeColor),
                                            )
                                          : Container(),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  showList
                      ? DashboardListWidget(
                          current_lattitude: lat,
                          current_longitude: long,
                          onTapItem: () {
                            print("lattitudeee " + lat!);
                            print("longitudeee " + long!);
                          },
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
                                  MydashboardScreenConstants.BLANK_LIST_TEXT,
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
    EasyLoading.show(status: "Please wait we are fetching your location...");
    servicestatus = await Geolocator.isLocationServiceEnabled();
    if (servicestatus) {
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
        // setState(() {
        //   //refresh the UI
        // });

        await getLocation();
      }

      EasyLoading.dismiss();
    } else {
      EasyLoading.dismiss();
      EasyLoading.showToast(
          "GPS Service is not enabled,Please turn on GPS location");
    }
  }

  getLocation() async {
    position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    print(position.longitude); //Output: 80.24599079
    print(position.latitude); //Output: 29.6593457

    long = position.longitude.toString();
    lat = position.latitude.toString();

    LocationSettings locationSettings = LocationSettings(
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
        // EasyLoading.showToast("Current Location Detected : $_currentAddress");
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
          text: MydashboardScreenConstants.POPUP_TITLE,
          onTapSubmit: () async {
            Navigator.pop(context);
            await checkGps();

            if (!haspermission) return;

            double latitude = double.tryParse(lat!) ?? 0;
            double longitude = double.tryParse(long!) ?? 0;

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
}
