import 'package:cool_alert/cool_alert.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:janitor/screens/choose_facility_screen/view/choose_facility.dart';
import 'package:janitor/screens/cluster_screen/view/cluster_screen.dart';
import 'package:janitor/screens/dashboard/model/dashboard_model.dart';
import 'package:janitor/screens/issue_list_screen/view/issue_list.dart';
import 'package:janitor/screens/janitor_customer_request/view/local_widgets/customer_request_list.dart';
import 'package:janitor/screens/janitor_screen/view/janitor_screen.dart';
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

  final List<DashboardModel> _list = [
    DashboardModel(
      id: 0,
      imgString: AppImages.cluster_img,
      name: MydashboardScreenConstants.CLUSTER,
    ),
    DashboardModel(
      id: 1,
      imgString: AppImages.janitor_img,
      name: MydashboardScreenConstants.JANITOR,
    ),
    DashboardModel(
      id: 2,
      imgString: AppImages.danger_img,
      name: MydashboardScreenConstants.REPORT_ISSUE,
    ),
    DashboardModel(
      id: 3,
      imgString: AppImages.custom_request_img,
      name: MydashboardScreenConstants.CUSTOMER_REQUEST,
    ),
  ];
  final List<DashboardModel> _janitorList = [
    DashboardModel(
      id: 0,
      imgString: AppImages.cluster_img,
      name: MydashboardScreenConstants.FACILITY,
    ),
    DashboardModel(
      id: 1,
      imgString: AppImages.custom_request_img,
      name: MydashboardScreenConstants.CUSTOMER_REQUEST,
    ),
  ];
  @override
  void initState() {
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
    return SafeArea(
      child: Column(
        children: [
          Container(
            height: 80.h,
            color: AppColors.white,
            width: ScreenUtil().screenWidth,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    MydashboardScreenConstants.TITLE_TEXT,
                    style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w400, color: Colors.black),
                  ),
                ],
              ),
            ),
          ),
          if (widget.isFromJanitor) ...[
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 40.w,
                vertical: 20.h,
              ),
              child: Container(
                height: 90.h,
                padding: EdgeInsets.symmetric(
                  vertical: 10.h,
                  horizontal: 10.w,
                ),
                decoration: BoxDecoration(
                    color: AppColors.alertBoxColor,
                    borderRadius: BorderRadius.circular(
                      15.r,
                    ),
                    boxShadow: const [
                      BoxShadow(
                        color: AppColors.alertShadowColor,
                        blurRadius: 6,
                        spreadRadius: 0,
                        offset: Offset(1, 1),
                      ),
                    ]),
                child: Row(
                  children: [
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        child: Image.asset(
                          AppImages.megaphone,
                          height: 42.h,
                          width: 42.w,
                        )),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 1.h,
                          ),
                          child: Text(
                            MydashboardScreenConstants.ALERT,
                            style: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w500, color: AppColors.alertTitleColor),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 1.h,
                          ),
                          child: Text(
                            MydashboardScreenConstants.ALERT_REQUEST,
                            style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w600, color: Colors.black),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 1.h,
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppColors.buttonColor,
                              borderRadius: BorderRadius.circular(5.r),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 12.w,
                                vertical: 1.h,
                              ),
                              child: Text(
                                MydashboardScreenConstants.BUTTON,
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.black,
                                  fontSize: 12.sp,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20.w,
                vertical: 10.h,
              ),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 10,
                  crossAxisCount: 2,
                ),
                itemCount: widget.isFromJanitor ? _janitorList.length : _list.length,
                itemBuilder: (BuildContext ctx, index) {
                  return Container(
                    // Image b// order
                    height: 140.h,
                    width: 140.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: selectedCard == index ? AppColors.yellowSplashColor : AppColors.dashboardContainerColor,
                      boxShadow: const [
                        BoxShadow(
                          color: AppColors.boxShadowColor,
                          blurRadius: 15,
                          spreadRadius: 0,
                          offset: Offset(1, 1),
                        ),
                      ],
                    ),
                    // child: Material(
                    //   borderRadius: BorderRadius.circular(20.r),
                    //   color: selectedCard == index ? AppColors.yellowSplashColor : AppColors.white,
                    child: GestureDetector(
                      // splashColor: AppColors.yellowSplashColor,
                      onTap: () {
                        setState(() {
                          // ontap of each card, set the defined int to the grid view index
                          selectedCard = index;
                        });
                        print(selectedCard);
                        try {
                          Widget screenToPush = Container();

                          if (widget.isFromJanitor) {
                            switch (_janitorList[index].id) {
                              case 0:
                                screenToPush = const ChooseFacilityList(
                                  isFromAuthenticationScreen: true,
                                  isFromClusterScreen: false,
                                );
                                break;
                              case 1:
                                screenToPush = const CustomerRequestList();
                                break;
                            }
                          }
                          if (widget.isFromSupervisor) {
                            switch (_list[index].id) {
                              case 0:
                                screenToPush = const ClusterList();
                                break;
                              case 1:
                                screenToPush = const JanitorList();
                                break;
                              case 2:
                                screenToPush = const IssuesList();
                                break;
                              case 3:
                                screenToPush = const IssuesList();
                                break;
                            }
                          }
                          // switch (_list[index].id) {
                          //   case 0:
                          //     screenToPush = const ClusterList();
                          //     break;
                          //   case 1:
                          //     screenToPush = const JanitorList();
                          //     break;
                          //   case 2:
                          //     screenToPush = const IssuesList();
                          //     break;
                          // }

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => screenToPush,
                            ),
                          );
                        } catch (e) {
                          CoolAlert.show(
                            context: context,
                            type: CoolAlertType.error,
                            text: "You are not authorised to view this page.",
                          );
                        }
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: 2.h,
                            ),
                            child: Image.asset(
                              widget.isFromJanitor ? _janitorList[index].imgString : _list[index].imgString,
                              fit: BoxFit.cover,
                              // height: 60.h,
                              width: 70.w,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5.w),
                            child: Text(
                              widget.isFromJanitor ? _janitorList[index].name : _list[index].name,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    // ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
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
}
