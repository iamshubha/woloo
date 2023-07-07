import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:janitor/screens/common_widgets/checkbox_list_widget.dart';
import 'package:janitor/screens/common_widgets/custom_dialogue_widget.dart';
import 'package:janitor/screens/common_widgets/dialogue_box_simple.dart';
import 'package:janitor/screens/common_widgets/white_button_widget.dart';
import 'package:janitor/screens/task_list/model/task_model.dart';
import 'package:janitor/screens/washroom_image_screen/view/task_completion_screen.dart';
import 'package:janitor/utils/app_color.dart';
import 'package:janitor/utils/app_constants.dart';

class TaskList extends StatefulWidget {
  const TaskList({Key? key}) : super(key: key);

  @override
  State<TaskList> createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  bool submitButtonTap = true;
  bool skipButtonTap = false;
  List<int> _selectedProductIds = [];
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
          SizedBox(
            height: 15.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: 15.h,
              horizontal: 20.w,
            ),
            child: Text(
              "List of tasks",
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
                itemCount: _data.length,
                scrollDirection: Axis.vertical,
                // shrinkWrap: true,
                itemBuilder: (
                  BuildContext context,
                  int index,
                ) {
                  return Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 7.h,
                      ),
                      child: CheckboxListWidget(
                        name: _data[index].name,
                        isChecked: _selectedProductIds.contains(_data[index].id),
                        onChecked: (bool selected, String s) {
                          if (selected) {
                            _selectedProductIds.add(_data[index].id);
                            print(_selectedProductIds);
                          } else {
                            _selectedProductIds.removeWhere((element) => element == _data[index].id);
                            print(_selectedProductIds);
                          }
                          setState(() {});
                        },
                      ));
                },
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: 5.h,
              horizontal: 30.w,
            ),
            child: WhiteButtonWidget(
              text: MyTaskListConstants.SUBMIT_BTN,
              color: submitButtonTap ? AppColors.buttonColor : AppColors.white,
              onTap: () {
                setState(() {
                  submitButtonTap = true;
                  skipButtonTap = false;
                });
                openDialog();
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: 5.h,
              horizontal: 30.w,
            ),
            child: WhiteButtonWidget(
              text: MyTaskListConstants.SKIP_BTN,
              color: skipButtonTap ? AppColors.buttonColor : AppColors.white,
              onTap: () {
                setState(() {
                  submitButtonTap = false;
                  skipButtonTap = true;
                });
                openSkipButtonDialog();
              },
            ),
          ),
        ],
      ),
    );
  }

  openDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomDialogueWidget(
          text: MyTaskListConstants.POPUP_TITLE,
          onTapSubmit: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const TaskCompletionScreen()),
            );
          },
          onTapCancel: () {
            Navigator.pop(context);
          },
        );
      },
    );
  }

  openSkipButtonDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialogueWidget(
          text: MyTaskListConstants.SKIP_BTN_DIALOGUE,
          onTapSubmit: () {
            Navigator.pop(context);
          },
        );
      },
    );
  }
}
