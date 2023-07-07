import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:janitor/screens/common_widgets/disabled_checkbox_widget.dart';
import 'package:janitor/screens/task_details_screen/model/task_list_img_model.dart';
import 'package:janitor/screens/task_list/model/task_model.dart';
import 'package:janitor/utils/app_color.dart';
import 'package:janitor/utils/app_constants.dart';
import 'package:janitor/utils/app_images.dart';

class TaskDetailsScreen extends StatefulWidget {
  const TaskDetailsScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<TaskDetailsScreen> createState() => _TaskDetailsScreenState();
}

class _TaskDetailsScreenState extends State<TaskDetailsScreen> {
  bool submitButtonTap = true;
  bool skipButtonTap = false;
  final List<TaskImgModel> _list = [
    TaskImgModel(id: 0, imgString: AppImages.task_img),
    TaskImgModel(id: 1, imgString: AppImages.task_img),
    TaskImgModel(id: 2, imgString: AppImages.task_img),
  ];
  final List<TaskModel> _data = [
    TaskModel(
      id: 0,
      name: "Cleaning Floor",
    ),
    TaskModel(
      id: 1,
      name: "Wipe mirror",
    ),
    TaskModel(
      id: 2,
      name: "Wipe Toilets",
    ),
    TaskModel(
      id: 3,
      name: "Empty Trash",
    ),
    TaskModel(
      id: 4,
      name: "Wipe sink and fittings",
    ),
    TaskModel(
      id: 5,
      name: "Refill Hand lotion",
    ),
    TaskModel(
      id: 6,
      name: "Refill Toilet paper ",
    ),
  ];
  List<int> _selectedProductIds = [];

  @override
  void initState() {
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
            color: Colors.black,
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
            MyTaskListConstants.APP_BAR,
            textAlign: TextAlign.start,
            style: TextStyle(
              color: AppColors.appBarTitleColor,
              fontSize: 24.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        backgroundColor: AppColors.white,
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: _list.length,
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemBuilder: (
                  BuildContext context,
                  int index,
                ) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.w),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10), // Image border
                      child: Container(
                        height: 20.h,
                        child: Image.asset(_list[index].imgString, fit: BoxFit.cover),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: 15.h,
              horizontal: 20.w,
            ),
            child: Text(
              MyTaskDetailsScreenConstants.TITLE,
              textAlign: TextAlign.start,
              style: TextStyle(
                color: AppColors.titleColor,
                fontSize: 24.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: 8.h,
              ),
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemCount: _data.length,

                // shrinkWrap: true,
                itemBuilder: (
                  BuildContext context,
                  int index,
                ) {
                  return Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 7.h,
                      ),
                      child: DisabledCheckboxListWidget(
                        name: _data[index].name,
                        onChecked: () {},
                      ));
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
