import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:janitor/screens/common_widgets/custom_dialogue_widget.dart';
import 'package:janitor/screens/dashboard/view/local_widgets/dashboard_list.dart';
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
  int selectedCard = -1;

  bool servicestatus = false;
  bool haspermission = false;
  bool showList = false;
  bool onTapCheckIn = false;
  bool onTapCheckOut = false;

  String check_in_time = "";
  String check_out_time = "";

  late LocationPermission permission;
  late Position position;
  String long = "", lat = "";
  String? _currentAddress;
  DateTime currentTime = DateTime.now();

  late StreamSubscription<Position> positionStream;

  @override
  void initState() {
    init();
    setState(() {
      onTapCheckOut = true;
    });
    super.initState();
  }

  init() async {
    String deviceToken = await getDeviceToken();
    print("###### PRINT DEVICE TOKEN TO USE FOR PUSH NOTIFCIATION ######");
    print(deviceToken);
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
        desc: description, // description from push notifcation data
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
    return Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: AppColors.white,
          title: Text(
            MydashboardScreenConstants.TITLE_TEXT,
            style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
          ),
        ),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
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
                            GestureDetector(
                              onTap: () async {
                                await checkGps();

                                if (!haspermission) return;
                                setState(() {
                                  showList = true;
                                  onTapCheckIn = true;
                                  onTapCheckOut = false;
                                });
                                String formattedDate = DateFormat('hh:mm:ss  a').format(currentTime);
                                // String formattedDate = DateFormat.jm().format(DateFormat("hh:mm:ss a").parse(currentTime.toString()));
                                check_in_time = formattedDate;
                              },
                              child: Container(
                                height: 40.h,
                                width: 40.w,
                                decoration: BoxDecoration(shape: BoxShape.circle, color: onTapCheckIn ? AppColors.greyCircleColor : AppColors.acceptButtonColor),
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
                            GestureDetector(
                              onTap: () async {
                                openDialog();
                              },
                              child: Container(
                                height: 40.h,
                                width: 40.w,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: onTapCheckOut ? AppColors.greyCircleColor : AppColors.checkOutColor,
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
                                  onTapCheckOut
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
              showList
                  ? DashboardListWidget(
                      // name: "OPD, A wing",
                      // description: "Description: xyz",
                      // time: "30 min",
                      // location: "Location: Reliance hospital, Thane",
                      // booths: "Booths : 2",
                      // total_tasks: "Total task : 2",
                      // pending_tasks: "Pending task : 2",
                      // status: "In Progress",
                      onTapItem: () {
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
                      current_lattitude: 12.8888,
                      current_longitude: 70.4356544,
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
            ],
          ),
        ));
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

        getLocation();
      }
    } else {
      print("GPS Service is not enabled, turn on GPS location");
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
            setState(() {
              showList = false;
              onTapCheckOut = true;
              onTapCheckIn = false;
            });
            String formattedDate = DateFormat('hh:mm:ss  a').format(currentTime);
            check_out_time = formattedDate;
          },
          onTapCancel: () {
            Navigator.pop(context);
          },
        );
      },
    );
  }
}
