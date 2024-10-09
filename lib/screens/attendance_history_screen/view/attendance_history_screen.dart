import 'dart:io';

import 'package:Woloo_Smart_hygiene/screens/attendance_history_screen/bloc/history_list_bloc.dart';
import 'package:Woloo_Smart_hygiene/screens/attendance_history_screen/bloc/history_list_event.dart';
import 'package:Woloo_Smart_hygiene/screens/attendance_history_screen/bloc/history_list_state.dart';
import 'package:Woloo_Smart_hygiene/screens/attendance_history_screen/data/model/Attendance_history_model.dart';
import 'package:Woloo_Smart_hygiene/screens/attendance_history_screen/data/model/Month_list_model.dart';
import 'package:Woloo_Smart_hygiene/screens/attendance_history_screen/view/local_widgets/history_list_widget.dart';
import 'package:Woloo_Smart_hygiene/screens/common_widgets/error_widget.dart';
import 'package:Woloo_Smart_hygiene/screens/common_widgets/image_provider.dart';
import 'package:Woloo_Smart_hygiene/utils/app_constants.dart';
import 'package:Woloo_Smart_hygiene/utils/app_images.dart';
import 'package:Woloo_Smart_hygiene/utils/app_textstyle.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:Woloo_Smart_hygiene/utils/app_color.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:excel/excel.dart' as ex;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class AttendanceHistoryScreen extends StatefulWidget {
  const AttendanceHistoryScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<AttendanceHistoryScreen> createState() =>
      AttendanceHistoryScreenState();
}

class AttendanceHistoryScreenState extends State<AttendanceHistoryScreen> {
  var monthItems = [
    MyAttendanceHistoryScreenConstants.JAN.tr(),
    MyAttendanceHistoryScreenConstants.FEB.tr(),
    MyAttendanceHistoryScreenConstants.MAR.tr(),
    MyAttendanceHistoryScreenConstants.APR.tr(),
    MyAttendanceHistoryScreenConstants.MAY.tr(),
    MyAttendanceHistoryScreenConstants.JUN.tr(),
    MyAttendanceHistoryScreenConstants.JUL.tr(),
    MyAttendanceHistoryScreenConstants.AUG.tr(),
    MyAttendanceHistoryScreenConstants.SEP.tr(),
    MyAttendanceHistoryScreenConstants.OCT.tr(),
    MyAttendanceHistoryScreenConstants.NOV.tr(),
    MyAttendanceHistoryScreenConstants.DEC.tr()
  ];
  List<MonthListModel> _data = [];
  List<AttendanceHistoryModel> _historyData = [];

  String dropdownvalue = MyAttendanceHistoryScreenConstants.SELECT.tr();
  HistoryListBloc _historyListBloc = HistoryListBloc();
  bool showList = false;
  String selectedMonth = "";
  String year = "";

  @override
  void initState() {
    // TODO: implement initState
    _historyListBloc.add(const GetAllMonths());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
              size: 30,
            ),
            color: AppColors.appBarIconColor,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 15.w,
              vertical: 10.h,
            ),
            child: Text(
              MyJanitorProfileScreenConstants.ATTENDANCE_HISTORY.tr(),
              textAlign: TextAlign.start,
              style:
              AppTextStyle.font24.copyWith(
                color:AppColors.yellowSplashColor,
              )
            ),
          ),
          backgroundColor: AppColors.appbarBgColor,
          elevation: 0,
        ),
        body: BlocConsumer(
            bloc: _historyListBloc,
            listener: (context, state) {
              // if (state is MonthListSuccess) {
              //   EasyLoading.dismiss();

               
              // }
              // if (state is HistoryListSuccess) {
              //   EasyLoading.dismiss();

              // }
            },
            builder: (context, state) {
               print("  attendance history   $state ");
              if (state is MonthListLoading) {
                EasyLoading.show(
                    status: MydashboardScreenConstants.LOADING_TOAST.tr());
              }
               else 
              if (state is MonthListError) {
                EasyLoading.dismiss();
                return CustomErrorWidget(error: state.error);
              }
            else
              if (state is MonthListSuccess  ) {
                _data = state.data;
                EasyLoading.dismiss();
             
                return 
             SingleChildScrollView(
                  child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                  
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20.w,
                          vertical: 10.h,
                        ),
                        child: SizedBox(
                          width: 140.w,
                          height: 50.h,
                          child: DropdownButtonFormField(
                         //   isDense: true,
                            isExpanded: true,

                            // Initial Value
                            decoration: const InputDecoration(
                                // labelText:'Select City',
                              border: OutlineInputBorder(
                                 borderSide: BorderSide(
                                   color: AppColors.black
                                 ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10.0),


                                ),

                              ),
                            focusedBorder:
                            OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: AppColors.black
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.0),


                              ),

                            ),
                            //  hintMaxLines: 1,

                            //focusColor: AppColors.yellowCardColor
                            ),

                            focusColor: AppColors.yellowCardColor,
                            // Down Arrow Icon
                            //icon: const Icon(Icons.arrow_drop_down_outlined),

                            // Array list of items
                            items:
                            _data.map((MonthListModel items) {
                              return DropdownMenuItem(
                                value: items,
                                child: Text(
                                  "${monthItems[(int.tryParse(items.month.toString()) ?? 1) - 1] } ${items.year}",
                                  style: 
                                  AppTextStyle.font14w6.copyWith(
                                    color: AppColors.darkGreyText
                                  )
                                ),
                              );
                            }).toList(),
                           alignment: Alignment.topCenter,
                            hint: Text( MyAttendanceHistoryScreenConstants
                                .SELECT
                                .tr(),
                             style:  TextStyle(
                                 color: Colors.grey[800]),
                            ),

                            // onChanged: (String? value) {  },
                            // After selecting the desired option,it will
                            // change button value to selected value
                            onChanged: (item) {
                              
                              var i = item as MonthListModel;
                                 selectedMonth = i.month!;
                                 year = i.year!;
                              _historyListBloc.add(GetAllHistory(
                                  month: i.month ?? '', year: i.year ?? ''));
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  // !showList
                  //     ? 
                  Center(
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
                                CustomImageProvider(
                                  image: AppImages.blank_list_img,
                                  height: 100.h,
                                  width: 100.w,
                                ),
                                Text(
                                  MyAttendanceHistoryScreenConstants
                                      .BLANK_LIST_TEXT
                                      .tr(),
                                  maxLines: 2,
                                  textAlign: TextAlign.center,
                                  style: 
                                  AppTextStyle.font24.copyWith(
                                    color: AppColors.black,
                                  )
                                )
                              ],
                            ),
                          ),
                        )
                  //     : HistoryListWidget(
                  //         onTapItem: () {},
                  //         data: _historyData,
                  //       ),
                ],
              )
              );
                
                
                //const EmptyListWidget();
              }
              else
              if (state is HistoryListLoading) {
                EasyLoading.show(
                    status: MydashboardScreenConstants.LOADING_TOAST.tr());
              }
               else

              if (state is HistoryListError) {
                EasyLoading.dismiss();
                return CustomErrorWidget(error: state.error);
              }
              else

              if (state is HistoryListSuccess  ) {
                 _historyData = state.data;
                  showList = true;
                EasyLoading.dismiss();
               return 
                 SingleChildScrollView(
                  child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                          Padding(
                        padding: EdgeInsets.only(
                          left: 15.w,
                          // vertical: 10.h,
                        ),
                            child: InkWell(
                              onTap: () {
                                     var month =  monthItems[(int.tryParse(selectedMonth.toString()) ?? 1) - 1];
                                        // setState(() {
                                          
                                        // });
                                       export( _data, _historyData, month, year, context);
                            
                              },
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
                                child: Container(
                                  width: 140.w,
                                  height: 48.h,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.r),
                                    color: AppColors.acceptButtonColor,
                                  ),
                                  child: Text(
                                    textAlign: TextAlign.center,
                                    MyAttendanceHistoryScreenConstants.DOWNLOAD_TO_EXCEL.tr(),
                                   style: AppTextStyle.font12w7.copyWith(
                                    color: AppColors.white
                                   ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20.w,
                          vertical: 10.h,
                        ),
                        child: SizedBox(
                          width: 140.w,
                          height: 50.h,
                          child: DropdownButtonFormField(
                         //   isDense: true,
                            isExpanded: true,

                            // Initial Value
                            decoration: const InputDecoration(
                                // labelText:'Select City',
                              border: OutlineInputBorder(
                                 borderSide: BorderSide(
                                   color: AppColors.black
                                 ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10.0),


                                ),

                              ),
                            focusedBorder:
                            OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: AppColors.black
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.0),


                              ),

                            ),
                            //  hintMaxLines: 1,

                            //focusColor: AppColors.yellowCardColor
                            ),

                            focusColor: AppColors.yellowCardColor,
                            // Down Arrow Icon
                            //icon: const Icon(Icons.arrow_drop_down_outlined),

                            // Array list of items
                            items:
                            _data.map((MonthListModel items) {
                              return DropdownMenuItem(
                                value: items,
                                child: Text(
                                  "${monthItems[(int.tryParse(items.month.toString()) ?? 1) - 1]} ${items.year}",
                                  style: 
                                  AppTextStyle.font14w6.copyWith(
                                    color: AppColors.darkGreyText
                                  )
                                ),
                              );
                            }).toList(),
                           alignment: Alignment.topCenter,
                            hint: Text( MyAttendanceHistoryScreenConstants
                                .SELECT
                                .tr(),
                             style:  TextStyle(
                                 color: Colors.grey[800]),
                            ),

                            // onChanged: (String? value) {  },
                            // After selecting the desired option,it will
                            // change button value to selected value
                            onChanged: (item) {
                              var i = item as MonthListModel;
                                 selectedMonth = i.month!;
                                 year = i.year!;

                              _historyListBloc.add(GetAllHistory(
                                  month: i.month ?? '', year: i.year ?? ''));

                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  !showList
                      ? Center(
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
                                CustomImageProvider(
                                  image: AppImages.blank_list_img,
                                  height: 100.h,
                                  width: 100.w,
                                ),
                                Text(
                                  MyAttendanceHistoryScreenConstants
                                      .BLANK_LIST_TEXT
                                      .tr(),
                                  maxLines: 2,
                                  textAlign: TextAlign.center,
                                  style: 
                                  AppTextStyle.font24.copyWith(
                                    color: AppColors.black,
                                  )
                                )
                              ],
                            ),
                          ),
                        )
                      : HistoryListWidget(
                          onTapItem: () {
                            
                          },
                          data: _historyData,
                        ),
                ],
              )
              );
               
               
               //const EmptyListWidget();
              }
              return  SizedBox();
    
            }
            )
            
            );
  }


   }








  snacbar( String title, Color color){
     return   SnackBar(
  backgroundColor: color,
  content: Text(
    title
    //'Excel Exported successfully'
    ),

);
  }


  Future<void> export(List<MonthListModel> monthlyData, List<AttendanceHistoryModel> historyData, String month, String year, BuildContext context ) async {
     
 
               
 if (Platform.isAndroid ) {
  await Permission.manageExternalStorage.request();
} else {
  await Permission.storage.request();
}  
  
    print("monthhtttt  $month ");

   var status = await Permission.storage.status;
         print("statd $status");

    final excel = ex.Excel.createExcel();

     var columnIterableSheet = excel['MonthHistory'];
   //    var sheet = excel['mySheet'];
            excel.delete('Sheet1');

  /// unlinking the sheet if any link function is used !!
              excel.unLink('sheet1');
      
      //  var columnIterabl = excel['ColumnIterables'];

       var date =    historyData.map( (e)=>  "${e.date}-$month-$year").toList();
       date.insert(0,"Dates" );
     //  var columnIterables = date;

       var chekIn =    historyData.map( (e)=>  e.checkIn ).toList();
       chekIn.insert(0,"Check In");

        var checkInColumn = chekIn;
   
       var chekOut =    historyData.map( (e)=>  e.checkOut ).toList();
       chekOut.insert(0,"Check Out");

         var checkOutColumn = chekOut;

       var  attendance  =    historyData.map( (e)=>  e.attendance ).toList();
       attendance.insert(0,"Attendance");

          var attendanceColumn = attendance;

        List<List<String?>> columnIterables = [
        date,
        chekIn,
        chekOut,
        attendance
        ];



    for (int columnIndex = 0; columnIndex < columnIterables.length; columnIndex++) {
    for (int rowIndex = 0; rowIndex < columnIterables[columnIndex].length; rowIndex++) {
      columnIterableSheet.cell(ex.CellIndex.indexByColumnRow(
        rowIndex: rowIndex, 
        columnIndex: columnIndex))
        ..value =
         columnIterables[columnIndex][rowIndex] == null ?
           ex.TextCellValue("-")

        : ex.TextCellValue(columnIterables[columnIndex][rowIndex]!);
    }
  }



     


 
       try {
         
      List<int>? fileBytes = excel.save();

          Directory? directory = Platform.isAndroid
      ? await getExternalStorageDirectory()
      : await getApplicationDocumentsDirectory();


           print(" ios path ${directory!.path}");

     String path = 
      Platform.isAndroid ?
     '/storage/emulated/0/download/$month-$year.xlsx'
     : '${directory!.path}/$month-$year.xlsx';
   
      var file = File(path);
     file..createSync()..writeAsBytesSync(fileBytes!);  
       ScaffoldMessenger.of(context).showSnackBar(snacbar(
           MyAttendanceHistoryScreenConstants.DOWNLOAD_SUCCESS_MESSAGE.tr(), AppColors.greenText ));
       } catch (e) {
           ScaffoldMessenger.of(context).showSnackBar(snacbar( e.toString(), AppColors.rejectButtonColor ));
       }

       


}
