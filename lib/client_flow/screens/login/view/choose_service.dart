


import 'package:flutter/material.dart';
import 'package:woloo_smart_hygiene/screens/common_widgets/image_provider.dart';
import 'package:woloo_smart_hygiene/utils/app_textstyle.dart';

import '../../../../utils/app_color.dart';
import '../../../../utils/app_images.dart';
import '../../dashbaord/view/dashboard.dart';
import '../../dashbaord/view/home.dart';

class ChooseService extends StatefulWidget {
  const ChooseService({super.key});

  @override
  State<ChooseService> createState() => _ChooseServiceState();
}

class _ChooseServiceState extends State<ChooseService> {
  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric( horizontal: 16),
        child: Column(
          children: [
             const SizedBox(
               height: 200,
             ),
              CustomImageProvider(
                image: AppImages.whiteLogo,
                width: 178,
                height: 127,
              ),
             const  SizedBox(
                height: 20,
               ),
        
               Container(
                 padding: EdgeInsets.all(10),
                height: 171,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  
                  borderRadius:  BorderRadius.circular(30)
        
                ),
                child:  Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                  children: [
        
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                   
                        Text("TASKMASTER",
                        style: AppTextStyle.font20bold,
                        ),
                         SizedBox(
                           height: 10,
                         ),

                        Text(
                          // textAlign: TextAlign.center,
                          "Monitor your hygiene withWoloo’s\nSmart Hygiene Technology Service.",
                          style: AppTextStyle.font12bold.copyWith(
                            color: AppColors.greyBorder
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        
                         ElevatedButton.icon(
                           style: ElevatedButton.styleFrom(
                             backgroundColor: AppColors.buttonYellowColor,
                             shape: RoundedRectangleBorder(
                               borderRadius: BorderRadius.circular(12), // <-- Radius
                             ),
                           ),
                           iconAlignment: IconAlignment.end,
                             icon: const Icon(Icons.arrow_forward,
                             color:  AppColors.black,
                             size: 34,
                             ),
                             onPressed: (){
                              Navigator.of(context).push( MaterialPageRoute(builder:  (context) {
                                 return const Home(
                                  isFromDashboard: false,
                                 );
                              }, ));
                             }, label: Text("Explore",
                          style: AppTextStyle.font16bold.copyWith(
                            color: AppColors.black
                          ),
                         ) )
                      ],
                    ),
                    CustomImageProvider(
                      image:  AppImages.dashboard,
                      height: 119,
                      width: 55,
                    )
        
                  ],
                ),
               )
        
          ],
        ),
      ),
    );
  }
}