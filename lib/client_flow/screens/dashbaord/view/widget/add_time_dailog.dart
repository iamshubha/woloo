

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:time_picker_spinner/time_picker_spinner.dart';
import 'package:woloo_smart_hygiene/client_flow/screens/dashbaord/data/model/tasktime_model.dart';
import 'package:woloo_smart_hygiene/client_flow/screens/dashbaord/view/widget/dailog.dart';
import 'package:woloo_smart_hygiene/client_flow/utils/client_images.dart';
import 'package:woloo_smart_hygiene/utils/app_textstyle.dart';

import '../../../../../screens/dashboard/controller/dash_controller.dart';
import '../../../../../utils/app_color.dart';
import '../../../../../utils/app_constants.dart';
import '../../../../widgets/CustomButton.dart';
import '../../bloc/dashboard_bloc.dart';
import '../../bloc/dashboard_event.dart';
import '../../bloc/dashboard_state.dart';
import '../../controller/dashbaord_controller.dart';
import '../../data/model/check_task_model.dart';

class AddTimeDailog extends StatefulWidget {
 int estimatedTime;
 TimeOfDay? startTime;
 String? endTime;
 bool? isFromExisting;
 int? janitorId;
    //  List<TimeOfDay>? taskStartTime;
    //  List<TimeOfDay>? taskEndTime;
     // List<Map<String, String>>? taskTimes;
   

   AddTimeDailog({super.key,
     required this.estimatedTime,
     this.startTime,
     this.endTime,
     required this.isFromExisting,
     this.janitorId

   });

  @override
  State<AddTimeDailog> createState() => _AddTimeDailogState();
}

class _AddTimeDailogState extends State<AddTimeDailog> {
  DateTime dateTime = DateTime.now();
  bool? isSafeToAdd = true ; 

   DashBoardController dashController = Get.put(DashBoardController());
     ClientDashBoardBloc dashBoardBloc  = ClientDashBoardBloc();
  TimeOfDay? timeOfDay;
  bool isAfterDate = false;
  CheckTaskModel? checkModel;
      @override
  void initState() {
    // TODO: implement initState
    super.initState();
   
    // taskTimes = widget.taskTimes!;
  }

  @override
  Widget build(BuildContext context) {
     return  
          // StatefulBuilder(
          //    builder: (context, setState) {
          //      return 
               
               BlocConsumer(
                 bloc: dashBoardBloc,
                listener: (context, state) {
                 if (state is DashboarLoading) {
                   EasyLoading.show(status: state.message);
                 }
                 if (state is CheckTaskTime ) {

                   checkModel =   state.checkTaskModel;
                   EasyLoading.dismiss();


                   if(checkModel!.results!.message == "Task time Added"){
                     print("primtnx asd");
                     isAfterDate = false;
                     String? formattedStartDate = "";
                     String? formattedEndDate = "" ;
                     // setState(() {
                     //
                     //
                     // });
                     var endTime =  dateTime.add(Duration(minutes: widget.estimatedTime!));
                     TimeOfDay endTimeofDay = TimeOfDay.fromDateTime(endTime);
                     dashController.taskStartTime.add(timeOfDay!);
                     dashController.taskEndTime.add(endTimeofDay);
                     formattedStartDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(dateTime);
                     formattedEndDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(endTime);

                                      // dashController.taskTimeModel.( 
                                      //         TaskTimeModel(taskId: 0, endTime: endTimeofDay, startTime: timeOfDay!, facilityName:"" , facilityType: "")

                                      //     );
                                           isSafeToAdd = !dashController.taskTimeModel.any((e) {
                                           return timeOfDay!.isBefore(e.endTime) && endTimeofDay.isAfter(e.startTime);
                                                    });    
                                           if(isSafeToAdd!){
                                             showDialog(context: context, builder: (context) {
                                                 return  Dailog(
                                                  image: ClientImages.verify,
                                                  title: "Task timing has been saved successfully",
                                                  subTitle: "Okay, Thanks!",
                                                 );
                                               }, ).then((value) {
                                                 Navigator.of(context).pop();
                                               }, );
                                              // Navigator.of(context).pop();
                                              dashController.taskTimeModel.insert(0, TaskTimeModel(taskId: 0, endTime: endTimeofDay, startTime: timeOfDay!, facilityName:"" , facilityType: ""));

                                           }
                                          //  else{
                                             
                                          //  }
          
                     dashController.taskTimes.add(
                         {
                           "start_time" : formattedStartDate ,
                           "end_time" : formattedEndDate
                         }

                     );

                  

                   }
             
                 }
                if (state is DashboarError) {
                    EasyLoading.dismiss();
                    EasyLoading.showError(state.error);
                  }   
                },
                 builder: (context, state) {
                   return AlertDialog(
                     backgroundColor: AppColors.white,
                     title: const Text(DashboardConst.scheduleTask,),
                     content:  Container(
                      width: double.infinity,
                       child: SingleChildScrollView(
                         child: ListBody(
                           children: <Widget>[
                             // Text(DashboardConst.scheduleTask,
                             //   style: AppTextStyle.font14w7,
                             // ),
                             const SizedBox(
                               height: 10,
                             ),
                             TimePickerSpinner(
                               locale: const Locale('en', ''),
                               time: dateTime,
                               is24HourMode: false,
                               isShowSeconds: false,
                               spacing: 60,
                               itemWidth: 25,
                               itemHeight: 50,
                               normalTextStyle: const TextStyle(
                                 fontSize: 13,
                                 color: AppColors.greyIcon,
                                 fontWeight: FontWeight.bold,
                                          
                               ),
                               // isShowSeconds: false,
                               highlightedTextStyle:
                               const TextStyle(
                                   fontWeight: FontWeight.bold,
                                   fontSize: 13, color: Colors.black),
                               isForce2Digits: true,
                               onTimeChange: (time) {
                                 setState(() {
                                   dateTime = time;
                                          
                                          
                                          
                                  //  taskTimes.add( { });
                           
                                  //  timevar =
                                  //  {
                                  //    "taskStartTime": taskStartTime!,
                                  //    "taskEndTime": taskEndTime!,
                                  //  };
                               
                                          
                                  //  print("to send in api ${widget.taskTimes}");
                                   // final localizations = MaterialLocalizations.of(context);
                                   // final formattedTimeOfDay = localizations.;
                                   print("time $time");
                                 });
                               },
                             ),
                             Row(
                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                               children: [
                                 GestureDetector(
                                     onTap:(){
                       
                                       String? formattedStartDate = "";
                                       String? formattedEndDate = "" ;
                                       var endTime =  dateTime.add(Duration(minutes: widget.estimatedTime!));
                                       print("end timessss $endTime");
                                       print("estiamged ${widget.estimatedTime}");
                                       // estimatedTime;
                                       // taskTimes.add({"end_time" :  });
                                          
                                          
                                       timeOfDay = TimeOfDay.fromDateTime(dateTime);
                                       TimeOfDay endTimeofDay = TimeOfDay.fromDateTime(endTime);
                                          
                                       print("end fo time $endTimeofDay");
                                          
                                       timeOfDay;
                                       print("is befro ${isAfter(timeOfDay!, widget.startTime! )}");
                                       print("is befro ${isAfter(widget.startTime!, timeOfDay!  )}");
                                       if( isAfter(timeOfDay!, widget.startTime! ) ){
                                         isAfterDate = false;
                                         setState(() {
                                          
                                          
                                         });
                       
                                         if(widget.isFromExisting! ){
                                           formattedStartDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(dateTime);
                                           formattedEndDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(endTime);
                       
                       
                                           dashBoardBloc.add(CheckTaskEvent(
                                               janitorId: widget.janitorId!,
                                               endTime: formattedEndDate,
                                               startTime: formattedStartDate
                       
                                           ) );
                       
                       
                       
                       
                                         }else {
                                          //  dashController.taskStartTime.add(timeOfDay!);
                                          //  dashController.taskEndTime.add(endTimeofDay);
                                          // GetAllJanito 
                                            // print("check timeeeeeee ${  dashController.taskTimeModel.where((e){
                                            //     return timeOfDay!.isBefore(e.startTime) || endTimeofDay.isAfter(e.endTime);
                                            // } ).toList()}");
                                             isSafeToAdd = !dashController.taskTimeModel.any((e) {
                                           return timeOfDay!.isBefore(e.endTime) && endTimeofDay.isAfter(e.startTime);
                                                    });      
                       
                                                    print(" safe to add $isSafeToAdd");
                       
                                                     if (isSafeToAdd!) {
                       
                                                         dashController.taskTimeModel.add( 
                                                TaskTimeModel(taskId: 0, endTime: endTimeofDay, startTime: timeOfDay!, facilityName:"" , facilityType: "")
                       
                                                   );
                       
                                                         formattedStartDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(dateTime);
                                                  formattedEndDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(endTime);
                                           dashController.taskTimes.add(
                                               {
                                                 "start_time" : formattedStartDate ,
                                                 "end_time" : formattedEndDate
                                               }
                                           );
                       
                                           }
      
                                         }
                                         print("timessss ${dashController.taskTimeModel}");
                       
                       
                                         print("end fo time ${ dashController.taskTimes}");
                       
                                           if(widget.isFromExisting!){
                       
                                           }
                                           else{
                                             if (isSafeToAdd!) {

                                               showDialog(context: context, builder: (context) {
                                                 return  Dailog(
                                                  image: ClientImages.verify,
                                                  title: "Task timing has been saved successfully",
                                                  subTitle: "Okay, Thanks!",
                                                 );
                                               }, ).then((value) {
                                                 Navigator.of(context).pop();
                                               }, );
                                                // Navigator.of(context).pop();
                                               
                                             }
                                           
                       
                                           }
                                          
                       
                                       }
                                       else {
                                         isAfterDate = true;
                                         setState(() {
                                          
                                         });
                                          
                                       }
                                          
                                     TimeOfDay endtimeTask =  stringToTimeOfDay12Hour( widget.endTime!);
                                          
                                        print("is after ${isAfter(endTimeofDay!,endtimeTask )} ");
                                          
                       
                                          
                                          
                                       // Navigator.of(context).pop();
                                      //  Navigator.of(context).pop(taskTimes);
                                        //  print("timeing ${dateTime. }");
                                       // janitorBottomSheet()
                                        // Navigator.pop(context,t;
                                          
                                                                  } ,
                                     child: Custombutton(text: DashboardConst.save, width: 137.w)),
                                 // GestureDetector(
                                 //     onTap:(){
                                 //       // janitorBottomSheet()
                                 //       ;                             } ,
                                 //     child: Custombutton(text: DashboardConst.addMoreTi
                                 //     mings, width: 164.w))
                               ],
                             ),
                              const SizedBox(
                                height: 10,
                              ),
                                          
                             timeOfDay == null ?
                                  SizedBox() :
                                          
                             isAfterDate ?
                                          
                              Text("Select Time when shift start ",
                              style: AppTextStyle.font12.copyWith(
                                color: AppColors.red
                              ),
                              )
                                 :
                                 isSafeToAdd! ? 
                                 SizedBox() :
                                 Text("Task already assigned for this time slot",
                                  style: AppTextStyle.font12.copyWith(
                                    color: AppColors.red
                                  ),
                                 ),
                                 
                                   SizedBox(),
                       
                             checkModel != null ?
                       
                       
                             checkModel!.results!.message == "Task time Added" ?
                                  SizedBox() :
                       
                                  Text(" ${checkModel!.results!.message}",
                                   style: AppTextStyle.font12.copyWith(
                                color: AppColors.red
                              ),
                                  )
                           : SizedBox()
                       
                       
                                          
                                          
                           ],
                         ),
                       ),
                     ),
                   
                   
                     // actions: <Widget>[
                     //   TextButton(
                     //     child: const Text('Approve'),
                     //     onPressed: () {
                     //       Navigator.of(context).pop();
                     //     },
                     //   ),
                     // ],
                   );
                 }
               );
             }
          //  );
  bool isBefore(TimeOfDay time1, TimeOfDay time2) {
    return time1.hour * 60 + time1.minute <= time2.hour * 60 + time2.minute;
  }

  bool isAfter(TimeOfDay time1, TimeOfDay time2) {
    return time1.hour * 60 + time1.minute >= time2.hour * 60 + time2.minute;
  }


  TimeOfDay stringToTimeOfDay12Hour(String time) {
    DateTime dateTime = DateFormat("hh:mm a").parse(time); // Parses "10:30 PM"
    return TimeOfDay(hour: dateTime.hour, minute: dateTime.minute);
  }

  bool isSame(TimeOfDay time1, TimeOfDay time2) {
    return time1.hour == time2.hour && time1.minute == time2.minute;
  }

// }
}