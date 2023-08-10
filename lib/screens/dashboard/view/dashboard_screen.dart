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
import 'package:janitor/screens/dashboard/bloc/dashboard_bloc.dart';
import 'package:janitor/screens/dashboard/bloc/dashboard_event.dart';
import 'package:janitor/screens/dashboard/bloc/dashboard_state.dart';
import 'package:janitor/screens/dashboard/view/local_widgets/dashboard_list.dart';
import 'package:janitor/screens/login/view/login_screen.dart';
import 'package:janitor/screens/supervisor_dashboard/view/local_widgets/supervisor_dashboard_list.dart';
import 'package:janitor/utils/app_color.dart';
import 'package:janitor/utils/app_constants.dart';
import 'package:janitor/utils/app_images.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class Dashboard extends StatefulWidget {
  final bool isFromJanitor;
  final bool isFromSupervisor;
  const Dashboard({
    Key? key,
    required this.isFromJanitor,
    required this.isFromSupervisor,
  }) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int selectedCard = -1;
  GlobalStorage globalStorage = GetIt.instance();

  bool servicestatus = false;
  bool haspermission = false;
  bool showList = false;
  bool onTapCheckIn = false;

  String check_in_time = "";
  String check_out_time = "";

  late LocationPermission permission;
  late Position position;
  String long = "", lat = "";

  String? _currentAddress;
  DateTime currentTime = DateTime.now();
  late final FirebaseMessaging _firebaseMessaging;

  late StreamSubscription<Position> positionStream;

  final iconList = <IconData>[
    Icons.brightness_5,
    Icons.brightness_4,
    Icons.brightness_6,
    Icons.brightness_7,
  ];
  var _bottomNavIndex = 0; // efault index of first screen
  DashboardBloc dashboardBloc = DashboardBloc();

  @override
  void initState() {
    // final pushNotificationService = PushNotificationService(_firebaseMessaging);
    // pushNotificationService.initialise();
    // checkGps();

    init();
    setState(() {
      onTapCheckIn = globalStorage.isCheckedIn();
      if (onTapCheckIn) showList = true;
    });

    // dashboardBloc.add();

    super.initState();
  }

  init() async {
    String deviceToken = await getDeviceToken();
    print("###### PRINT DEVICE TOKEN TO USE FOR PUSH NOTIFICATION ######");
    print("TOKENNNNNNNN.....-----" + deviceToken);
    print("############################################################");

    // listen for user to click on notification
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage remoteMessage) {
      String? title = remoteMessage.notification!.title;

      String? description = remoteMessage.notification!.body;
      //im gonna have an alertdialog when clicking from push notification
      Alert(
        context: context,
        type: AlertType.error,
        title: title, // title from push notification data
        style: AlertStyle(titleStyle: TextStyle(color: AppColors.redText), backgroundColor: AppColors.black),
        desc: description, // description from push notification data
        buttons: [
          DialogButton(
            child: Text(
              "COOL",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () => Navigator.pop(context),
            width: 120,
          )
        ],
      ).show();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: dashboardBloc,
      listener: (context, state) {
        print(state);
        if (state is ClockInLoading) {
          EasyLoading.show(status: state.message);
        }

        if (state is ClockInError) {
          EasyLoading.dismiss();
          EasyLoading.showError(state.error);
        }
        if (state is ClockInSuccessful) {
          EasyLoading.dismiss();

          setState(() {
            showList = true;
            onTapCheckIn = true;
          });
          String formattedDate = DateFormat('hh:mm:ss  a').format(currentTime);
          check_in_time = formattedDate;
        }

        if (state is ClockOutSuccessful) {
          EasyLoading.dismiss();
          print(state);
          setState(() {
            showList = false;
            onTapCheckIn = false;
          });
          String formattedDate = DateFormat('hh:mm:ss  a').format(currentTime);
          check_out_time = formattedDate;
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
          // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          // floatingActionButton: Container(
          //   width: 58,
          //   height: 58,
          //   decoration: ShapeDecoration(
          //     color: Color(0xFF3D443D),
          //     shape: OvalBorder(
          //       side: BorderSide(
          //         width: 1.50,
          //         strokeAlign: BorderSide.strokeAlignCenter,
          //         color: Color(0xFFFFE22C),
          //       ),
          //     ),
          //   ),
          //   child: Padding(
          //     padding: EdgeInsets.symmetric(
          //       horizontal: 10.w,
          //       vertical: 10.h,
          //     ),
          //     child: Image.asset(
          //       AppImages.fab_img,
          //       height: 26.h,
          //       width: 26.w,
          //     ),
          //   ),
          // ),
          // bottomNavigationBar:
          //     // widget.isFromSupervisor
          //     //     ?
          //     AnimatedBottomNavigationBar(
          //   backgroundColor: AppColors.bottomNavigationColor,
          //   icons: iconList,
          //   activeIndex: _bottomNavIndex,
          //   notchSmoothness: NotchSmoothness.softEdge,
          //
          //   gapLocation: GapLocation.center,
          //   onTap: (index) => setState(() => _bottomNavIndex = index),
          //   //other params
          // ),
          // : Container(),
          backgroundColor: AppColors.white,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: AppColors.white,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  widget.isFromJanitor ? MydashboardScreenConstants.TITLE_TEXT : MydashboardScreenConstants.SUPERVISOR_TITLE_TEXT,
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
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
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                      (route) => false,
                    );
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 10.h,
                      horizontal: 5.w,
                    ),
                    child: Icon(
                      Icons.logout,
                      color: AppColors.black,
                      size: 30.sp,
                    ),
                  ),
                )
              ],
            ),
          ),
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                if (widget.isFromJanitor) ...[
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
                                        onTap: () async {
                                          // var latitude = double.tryParse(lat) ?? 0;
                                          // var longitude = double.tryParse(long) ?? 0;
                                          // print("lattttt   " + latitude.toString());
                                          // print("longggg   " + longitude.toString());
                                          //
                                          // dashboardBloc.add(MarkAttendance(type: 'check_in', locations: [latitude, longitude]));
                                        },
                                        child: Container(
                                          height: 40.h,
                                          width: 40.w,
                                          decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.greyCircleColor),
                                          child: Center(
                                            child: Text(
                                              "In",
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
                                              "In",
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
                                              "Out",
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
                                              "Out",
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
                                        MydashboardScreenConstants.CHECK_IN,
                                        style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w400, color: Colors.black),
                                      ),
                                      onTapCheckIn
                                          ? Text(
                                              check_in_time,
                                              style: TextStyle(fontSize: 8.sp, fontWeight: FontWeight.w400, color: AppColors.timeColor),
                                            )
                                          : Container(),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        MydashboardScreenConstants.CHECK_OUT,
                                        style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w400, color: Colors.black),
                                      ),
                                      !onTapCheckIn
                                          ? Text(
                                              check_out_time,
                                              style: TextStyle(fontSize: 8.sp, fontWeight: FontWeight.w400, color: AppColors.timeColor),
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
                ],
                widget.isFromJanitor
                    ? showList
                        ? DashboardListWidget(
                            // name: "OPD, A wing",
                            // description: "Description: xyz",
                            // time: "30 min",
                            // location: "Location: Reliance hospital, Thane",
                            // booths: "Booths : 2",
                            // total_tasks: "Total task : 2",
                            // pending_tasks: "Pending task : 2",
                            // status: "In Progress",
                            current_lattitude: lat,
                            current_longitude: long,
                            onTapItem: () {
                              print(lat);
                              print(long);
                              // if (widget.isFromAuthenticationScreen) {
                              //   openDialog();
                              // }
                              // if (widget.isFromClusterScreen) {
                              //   Navigator.of(context).push(
                              //     MaterialPageRoute(
                              //       builder: (context) => TaskDetailsScreen(),
                              //     ),
                              //   );
                              // }
                            },
                            // type: '',
                            // time_slot: '',
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
                    : SupervisorDashboardListWidget(
                        onTapItem: () {},
                      )
              ],
            ),
          )),
    );
  }

  Future getDeviceToken() async {
    //request user permission for push notification
    FirebaseMessaging.instance.requestPermission();
    FirebaseMessaging _firebaseMessage = FirebaseMessaging.instance;
    String? deviceToken = await _firebaseMessage.getToken();
    print("token" + deviceToken.toString());
    return (deviceToken == null) ? "" : deviceToken;
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
      EasyLoading.showToast("GPS Service is not enabled,Please turn on GPS location");
    }

    // setState(() {
    //   //refresh the UI
    // });
  }

  getLocation() async {
    position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    print(position.longitude); //Output: 80.24599079
    print(position.latitude); //Output: 29.6593457

    long = position.longitude.toString();
    lat = position.latitude.toString();

    // setState(() {
    //   //refresh UI
    // });

    LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high, //accuracy of the location data
      distanceFilter: 100, //minimum distance (measured in meters) a
      //device must move horizontally before an update event is generated;
    );

    StreamSubscription<Position> positionStream = Geolocator.getPositionStream(locationSettings: locationSettings).listen((Position position) {
      print(position.longitude); //Output: 80.24599079
      print(position.latitude); //Output: 29.6593457

      long = position.longitude.toString();
      lat = position.latitude.toString();

      _getAddressFromLatLng(position);

      // setState(() {
      //   //refresh UI on update
      // });
    });
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(position.latitude, position.longitude).then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      setState(() {
        _currentAddress = '${place.name},${place.street}, ${place.subLocality},${place.subAdministrativeArea}, ${place.administrativeArea},${place.postalCode}';
        print("address - $_currentAddress");
        EasyLoading.showToast("Current Location Detected : $_currentAddress");
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
