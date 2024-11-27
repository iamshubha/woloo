import 'package:Woloo_Smart_hygiene/core/local/global_storage.dart';
import 'package:Woloo_Smart_hygiene/screens/common_widgets/button_widget.dart';
import 'package:Woloo_Smart_hygiene/screens/login/view/login_screen.dart';
import 'package:Woloo_Smart_hygiene/utils/app_color.dart';
import 'package:Woloo_Smart_hygiene/utils/app_constants.dart';
import 'package:Woloo_Smart_hygiene/utils/app_images.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';

import '../../../utils/app_textstyle.dart';
import '../../common_widgets/image_provider.dart';
import '../../janitor_profile_screen/upload_profile.dart';
import '../../login/bloc/login_bloc.dart';
import '../../login/data/model/Update_token_model.dart';

class SupervisorAccountScreen extends StatefulWidget {
  final String supervisorName;
  final String mobile_number;

  const SupervisorAccountScreen({
    Key? key,
    required this.supervisorName,
    required this.mobile_number,
  }) : super(key: key);

  @override
  State<SupervisorAccountScreen> createState() =>
      SupervisorAccountScreenState();
}

class SupervisorAccountScreenState extends State<SupervisorAccountScreen> {
  LoginBloc? profileBloc;
  List<UpdateTokenModel>? profile;


     updat()async{
          var firebase = FirebaseMessaging.instance;
                          var token = await firebase.getToken();
    profileBloc?.add( UpdateTokenOnVerifyOTP(
        token:token!

         //   "e2E8G5n5T0OAm4aH7PIcTf:APA91bG9pDBP0RAvMBYuQM9ZHAvva_GsgsnAaUHLU4n7xF6gcytrAzDC6HJiWSn0nOsO8m4mrZy9GpuaCAXQAoM6854kdlRvCVYAnUYxtlVL62A-e3Y442lm5FItZY60htbBCv6qdYx1"

    ));
   }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
        profileBloc = BlocProvider.of<LoginBloc>(
      context,
    );
  //  updat();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(

          elevation: 0,
          backgroundColor: AppColors.white,
          title: Text(
            MyAccountScreenConstants.MY_ACCOUNT.tr(),
            style:
              AppTextStyle.font24bold.copyWith(
                  color: AppColors.black,
                  )
            //  TextStyle(
            //   fontSize: 24.sp,
            //   fontWeight: FontWeight.w400,
            //   color: AppColors.yellowSplashColor,
            // ),
          ),
          // leading: IconButton(
          //   color: AppColors.black30,
          //   icon: const Icon(
          //     Icons.arrow_back,
          //     color: Colors.black,
          //     size: 30,
          //   ),
          //   // color: AppColors.black,
          //   onPressed: () {
          //     Navigator.pop(context);
          //   },
          // ),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [


              // SizedBox(
              //   height: 70.h,
              // ),
              // Padding(
              //   padding: EdgeInsets.symmetric(horizontal: 20.w),
              //   child: Text(
              //     MyAccountScreenConstants.MY_ACCOUNT.tr(),
              //     style: TextStyle(
              //       fontWeight: FontWeight.w400,
              //       fontSize: 24.sp,
              //       color: AppColors.black,
              //     ),
              //   ),
              // ),
              SizedBox(
                height: 50.h,
              ),
              Padding(
                padding: const EdgeInsets.symmetric( horizontal: 16),
                child: Container(
                  
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25.r),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black
                            .withOpacity(0.15), // Shadow color
                        spreadRadius:
                        1, // How wide the shadow should spread
                        blurRadius:
                        10, // The blur effect of the shadow
                        offset: Offset(0,
                            0), // No offset for shadow on all sides
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20.h,
                      ),
                          Center(
                            child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.start,

                                            children: [
                                                SizedBox(  width: 20.w, ),

                            //                    BlocBuilder<LoginBloc, LoginState>(
                            //                      bloc: profileBloc,
                            //                     builder:
                            //                     (context, state) {
                            //                          print("state $state ");
                            //                        if (state is  UpdateTokenLoading ) {
                            //                          EasyLoading.show(status: "");

                            //                        }
                            //                         if (state is UpdateTokenSuccess ){
                            //                        EasyLoading.dismiss();

                            // profile =  state.data  ;
                            //                        }
                            //                         if(state is UpdateTokenError ){
                            //                         EasyLoading.show(status: state.error.message);

                            //                        }

                            //            return

                                         profile == null ?

                                         Center(
                                           child: CustomImageProvider(
                                             image: AppImages.profile_img,
                                             height: 70.h,
                                             width: 70.w,
                                             alignment: Alignment.center,
                                           ),
                                         )
                                         :

                                         Center(
                                                child: CustomImageProvider(
                                                  image: "https://woloo-taskmanagement-s3bucket.s3.ap-south-1.amazonaws.com/${profile!.first.profileImage!.replaceAll("[", "").replaceAll("]", "").replaceAll('"', '')}",
                                                  height: 70.h,
                                                  width: 70.w,
                                                  alignment: Alignment.center,
                                                ),
                                              ),

                                                // },
                                              //  ),


                                              InkWell(
                                                 onTap: () {
                            Navigator.of(context).push(  MaterialPageRoute(builder: (context) {
                                return  const UplopadProfile(

                                );
                            },  )  );
                                                 },
                                                child: CustomImageProvider(
                                                  image: AppImages.edit_icon,
                                                  width: 30,
                                                  height: 30,
                                                ),
                                              ),
                                            ],
                                          ),
                          ),
                      // Center(
                      //   child:
                      //   CustomImageProvider(
                      //     image: AppImages.profile_img,
                      //     height: 98.h,
                      //     width: 97.w,
                      //     alignment: Alignment.center,
                      //   ),

                      // ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 0.h),
                          child: Padding(
                            padding:
                            EdgeInsets.symmetric(horizontal: 10.w, vertical: 0.h),
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.w),
                              child: Text(
                                  textAlign: TextAlign.center,
                                  widget.supervisorName,
                                  style:
                                  AppTextStyle.font16.copyWith(
                                    color: AppColors.black,
                                  )
                                //  TextStyle(
                                //   fontWeight: FontWeight.w400,
                                //   fontSize: 16.sp,
                                //   color: AppColors.black,
                                // ),
                              ),
                            ),
                          ),
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
                        child: Padding(
                          padding:
                          EdgeInsets.symmetric(horizontal: 10.w, vertical: 0.h),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            child: Text(
                                textAlign: TextAlign.center,
                                "+91 ${widget.mobile_number}",
                                style:
                                AppTextStyle.font16.copyWith(
                                  color: AppColors.black,
                                )
                              //  TextStyle(
                              //   fontWeight: FontWeight.w400,
                              //   fontSize: 16.sp,
                              //   color: AppColors.black,
                              // ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 40.h,
                      )
                    ],
                  ) ,
                ),
              ),

              SizedBox(
                height: 70.h,
              ),
              GestureDetector(
                onTap: () async {
                  EasyLoading.show(
                      status: MyJanitorProfileScreenConstants.LOGGING_OUT_TOAST
                          .tr());
                  var storage = GetIt.instance<GlobalStorage>();
                  storage.removeToken();
                  storage.removeLocation();
                  storage.removeTime();
                  await Future.delayed(const Duration(seconds: 3));
                  EasyLoading.dismiss();
                  EasyLoading.showToast(MyJanitorProfileScreenConstants
                      .LOG_OUT_SUCCESS_TOAST
                      .tr());
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                    (route) => false,
                  );
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 10.h,
                    horizontal: 30.w,
                  ),
                  child: ButtonWidget(
                    text: MydashboardScreenConstants.LOG_OUT.tr(),
                  ),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
            ],
          ),
        ));
  }
}
