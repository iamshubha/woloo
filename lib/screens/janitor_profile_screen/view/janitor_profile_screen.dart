import 'package:Woloo_Smart_hygiene/core/local/global_storage.dart';
import 'package:Woloo_Smart_hygiene/screens/attendance_history_screen/view/attendance_history_screen.dart';
import 'package:Woloo_Smart_hygiene/screens/common_widgets/leading_button.dart';
import 'package:Woloo_Smart_hygiene/screens/login/bloc/login_bloc.dart';
import 'package:Woloo_Smart_hygiene/screens/login/view/login_screen.dart';
import 'package:Woloo_Smart_hygiene/screens/selfie_screen/view/selfie_screen.dart';
import 'package:Woloo_Smart_hygiene/utils/app_color.dart';
import 'package:Woloo_Smart_hygiene/utils/app_constants.dart';
import 'package:Woloo_Smart_hygiene/utils/app_images.dart';
import 'package:Woloo_Smart_hygiene/utils/app_textstyle.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';

// import '../../../core/bloc/core_bloc.dart';
import '../../common_widgets/image_provider.dart';
import '../../login/data/model/Update_token_model.dart';
import '../upload_profile.dart';

class JanitorProfileScreen extends StatefulWidget {
  const JanitorProfileScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<JanitorProfileScreen> createState() => JanitorProfileScreenState();
}

class JanitorProfileScreenState extends State<JanitorProfileScreen> {
  LoginBloc? profileBloc;
  List<UpdateTokenModel>? profile;
    // CoreBloc coreBloc = CoreBloc();
  var name;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // print("sdf");
    // print(" sadas ${loginBloc.profileList}");
    profileBloc = BlocProvider.of<LoginBloc>(
      context,
    );
   // updat();
    // BlocProvider.of<LoginBloc>(context);
    name = globalStorage.getProfileName();



    print(profileBloc!.profileList);
  }

   updat()async{
          var firebase = FirebaseMessaging.instance;
                          var token = await firebase.getToken();
    profileBloc?.add( UpdateTokenOnVerifyOTP(
        token:token!

         //   "e2E8G5n5T0OAm4aH7PIcTf:APA91bG9pDBP0RAvMBYuQM9ZHAvva_GsgsnAaUHLU4n7xF6gcytrAzDC6HJiWSn0nOsO8m4mrZy9GpuaCAXQAoM6854kdlRvCVYAnUYxtlVL62A-e3Y442lm5FItZY60htbBCv6qdYx1"

    ));
   }

  final globalStorage = GetIt.instance<GlobalStorage>();

  // LoginBloc loginBloc = LoginBloc();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
           leadingWidth: 100,
          backgroundColor: AppColors.white,
          leading:
              LeadingButton()

          // IconButton(
          //   icon: const Icon(
          //     Icons.arrow_back,
          //     color: Colors.white,
          //     size: 25,
          //   ),
          //   color: AppColors.appBarIconColor,
          //   onPressed: () {
          //     Navigator.pop(context);
          //   },
          // ),
        //  title:

        //  elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 15.w,
                  vertical: 10.h,
                ),
                child: Text(MyJanitorProfileScreenConstants.MY_PROFILE.tr(),
                    textAlign: TextAlign.start,
                    style: AppTextStyle.font20bold.copyWith(
                      color: AppColors.black,
                    )
                  // TextStyle(
                  //   color: AppColors.yellowSplashColor,
                  //   fontSize: 20.sp,
                  //   fontWeight: FontWeight.w400,
                  // ),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  //  BlocBuilder<LoginBloc, LoginState>(
                  //    bloc: profileBloc,
                  //   builder: 
                  //   (context, state) {
                  //      if (state is  UpdateTokenLoading ) {
                  //        EasyLoading.show(status: "");
                              
                  //      }
                  //       if (state is UpdateTokenSuccess ){
                  //         EasyLoading.dismiss();
                 
                  //         profile =  state.data  ;
                  //      }
                  //       if(state is UpdateTokenError ){
                  //         EasyLoading.show(status: state.error.message);
                         
                  //      }
                       
                  //                    return

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
              SizedBox(
                height: 15.h,
              ),
              Center(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Name:",
                      style: AppTextStyle.font16.copyWith(
                        color: AppColors.greyText,
                      )
                      // TextStyle(
                      //   fontWeight: FontWeight.w400,
                      //   fontSize: 16.sp,
                      //   color: AppColors.greyText,
                      // ),
                      ),
                  SizedBox(
                    width: 15.h,
                  ),
                  Text(name,
                      style: AppTextStyle.font16.copyWith(
                        color: AppColors.black,
                      )
                      //  TextStyle(
                      //   fontWeight: FontWeight.w400,
                      //   fontSize: 16.sp,
                      //   color: AppColors.black,
                      // ),
                      ),
                ],
              )),
              SizedBox(
                height: 40.h,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AttendanceHistoryScreen()),
                    // (route) => false,
                  );
                },
                child: Container(
                  height: 60.h,
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                          width: 1.0.w, color: AppColors.greyBorderColor),
                    ),
                  ),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                    child: Row(
                      children: [
                        CustomImageProvider(
                          image: AppImages.history_img,
                          height: 25.h,
                          width: 25.w,
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            child: Text(
                                textAlign: TextAlign.start,
                                MyJanitorProfileScreenConstants
                                    .ATTENDANCE_HISTORY
                                    .tr(),
                                style: AppTextStyle.font16.copyWith(
                                  color: AppColors.black,
                                )
                                // TextStyle(
                                //   fontWeight: FontWeight.w400,
                                //   fontSize: 16.sp,
                                //   color: AppColors.black,
                                // ),
                                ),
                          ),
                        ),
                        // SizedBox(
                        //   width: 40.w,
                        // ),
                        const Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.black,
                          size: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () async {
                  EasyLoading.show(
                      status: MyJanitorProfileScreenConstants.LOGGING_OUT_TOAST
                          .tr());
                  var storage = GetIt.instance<GlobalStorage>();
                  storage.removeProfile();
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
                    MaterialPageRoute(
                        builder: (context) => const LoginScreen()),
                    (route) => false,
                  );
                },
                child: Container(
                  height: 60.h,
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                          width: 1.0.w, color: AppColors.greyBorderColor),
                      bottom: BorderSide(
                          width: 1.0.w, color: AppColors.greyBorderColor),
                    ),
                  ),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                    child: Row(
                      children: [
                        CustomImageProvider(
                          image: AppImages.logout_img,
                          height: 25.h,
                          width: 25.w,
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            child: Text(
                              textAlign: TextAlign.start,
                              MyJanitorProfileScreenConstants.LOG_OUT.tr(),
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
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
