import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:janitor/screens/common_widgets/button_widget.dart';
import 'package:janitor/screens/dashboard/view/dashboard_screen.dart';
import 'package:janitor/utils/app_color.dart';
import 'package:janitor/utils/app_constants.dart';
import 'package:janitor/utils/app_images.dart';

import 'local_widgets/otp_widget.dart';

class OTPScreen extends StatefulWidget {
  final String phoneNumber;
  const OTPScreen({Key? key, required this.phoneNumber}) : super(key: key);

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  String _pin = '';
  bool servicestatus = false;
  bool haspermission = false;
  late LocationPermission permission;
  late Position position;
  String long = "", lat = "";
  String? _currentAddress;
  late StreamSubscription<Position> positionStream;

  @override
  void initState() {
    super.initState();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverFillRemaining(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 20.w,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: Container()),
                    Center(
                      child: Container(
                        height: 120.h,
                        width: 120.w,
                        decoration: BoxDecoration(color: AppColors.greyContainer, borderRadius: BorderRadius.circular(100)
                            //more than 50% of width makes circle
                            ),
                        child: Center(
                          child: Image.asset(
                            AppImages.otp_img,
                            height: 78.h,
                            alignment: Alignment.center,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Center(
                      child: Text(
                        MyLoginConstants.OTP_VERIFICATION,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 24.sp,
                          color: AppColors.black,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    // Row(
                    //   children: [
                    Center(
                      child: RichText(
                        text: TextSpan(
                          text: MyLoginConstants.ENTER_OTP,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14.sp,
                            color: AppColors.greyText,
                          ),
                          children: [
                            TextSpan(
                              text: widget.phoneNumber,
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 14.sp,
                                color: AppColors.boldTextColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    //   ],
                    // ),
                    SizedBox(
                      height: 20.h,
                    ),
                    OTPWidget(
                      onTapResend: () {
                        // context.read<LoginBloc>().add(SendOTP(phoneNumber: widget.phoneNumber));
                      },
                      onComplete: (pin) => _pin = pin,
                    ),
                    SizedBox(
                      height: 7.h,
                    ),
                    Expanded(child: Container()),
                    GestureDetector(
                      onTap: () async {
                        // if (_pin.isNotEmpty) {
                        // context.read<LoginBloc>().add(VerifyOTP(otp: _pin));
                        if (_pin.isEmpty) {
                          EasyLoading.showToast("please enter the OTP to proceed");
                        }

                        if (_pin.isNotEmpty) {
                          await checkGps();
                        }

                        if (!haspermission) return;

                        print("button pressed");

                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Dashboard(
                              isFromJanitor: true,
                              isFromSupervisor: false,
                            ),
                          ),
                        );
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
                        child: const ButtonWidget(
                          text: MyLoginConstants.VERIFY_OTP_BTN,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
