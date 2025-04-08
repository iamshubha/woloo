

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:woloo_smart_hygiene/screens/common_widgets/image_provider.dart';
import 'package:woloo_smart_hygiene/screens/login/view/login_screen.dart';

import '../../../../utils/app_color.dart';
import '../../../../utils/app_textstyle.dart';
import '../../../utils/client_images.dart';
import 'login.dart';

class LoginAs extends StatefulWidget {
  const LoginAs({super.key});

  @override
  State<LoginAs> createState() => _LoginAsState();
}

class _LoginAsState extends State<LoginAs> {
  String? dropdownValue;
  @override
  Widget build(BuildContext context) {

    return   Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Center(
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [

             const SizedBox(
               height: 300,
             ),




             CustomImageProvider(
              image: ClientImages.taskMaster,
               width: 255,
             ),

             SizedBox(
              height: 50.h,
            ),

               Padding(
                      padding: const EdgeInsets.only(right : 20),
                      child: DecoratedBox(
                        decoration:  ShapeDecoration(
                          color: AppColors.white,
                          shadows: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.2), // Shadow color
                              spreadRadius: 1, // How wide the shadow should spread
                              blurRadius: 10, // The blur effect of the shadow
                              offset: const Offset(0, 0), // No offset for shadow on all sides
                            ),
                          ],

                          // color: Colors.cyan,
                          shape: const RoundedRectangleBorder(
                            // side: BorderSide(
                            //     width: 1.0,
                            //     style: BorderStyle.solid,
                            //     color: Colors.cyan),
                            borderRadius: BorderRadius.all(Radius.circular(5.0)

                            ),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 0.0),
                          child: DropdownButton<String>(
                            value: dropdownValue,
                            icon: const Icon( Icons.keyboard_arrow_down,
                             size: 30,
                            ),
                            elevation: 16,
                            onChanged: (newValue) {
                              setState(() {
                                dropdownValue = newValue;
                                 // print("new $newValue ");
                              });
                               //
                               if(dropdownValue == "Admin" ){
                                 Navigator.of(context).push( MaterialPageRoute(builder: (context) {
                                    return ClientLogin();
                                 },  ) );
                               } 
                               else{
                                   Navigator.of(context).push( MaterialPageRoute(builder: (context) {
                                    return LoginScreen();
                                 },  ) );
                               }

                            },
                            hint: Text("Login as",
                             style: AppTextStyle.font10bold,
                            ),
                            underline: const SizedBox(),
                            items: <String>['Admin', 'Task Buddy', 'Supervisor']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    )
          ],
        ),
      ),
    );
  }
}