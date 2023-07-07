import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:janitor/screens/common_widgets/custom_dialogue_widget.dart';
import 'package:janitor/screens/common_widgets/janitor_list.dart';
import 'package:janitor/screens/janitor_details_screen/view/janitor_details.dart';
import 'package:janitor/screens/task_list/view/task_list_screen.dart';
import 'package:janitor/utils/app_color.dart';
import 'package:janitor/utils/app_constants.dart';

class JanitorList extends StatefulWidget {
  const JanitorList({Key? key}) : super(key: key);

  @override
  State<JanitorList> createState() => _JanitorListState();
}

class _JanitorListState extends State<JanitorList> {
  final TextEditingController _searchController = TextEditingController();
  bool cancelButtonTap = true;
  bool yesButtonTap = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.white,
        title: Text(
          MyJanitorsListScreenConstants.TITLE_TEXT,
          style: TextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
        ),
        leading: IconButton(
          color: AppColors.black30,
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
            size: 30,
          ),
          // color: AppColors.black,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 20.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 20.w,
            ),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search',
                prefixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    // Perform the search here
                  },
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    10.r,
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
            child: Text(
              MyJanitorsListScreenConstants.SUB_TITLE,
              style: TextStyle(
                color: AppColors.titleColor,
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Expanded(
              child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: 7.h,
            ),
            child: JanitorListWidget(
              onTapItem: () {
                // openDialog();
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => JanitorDetails(id: 12),
                  ),
                );
              },
              janitorName: 'Uma Jadhav',
              pincode: '9876543210',
              cluster: 'Cluster 1',
              mobile: '4411526',
            ),
          )),
        ],
      ),
    );
  }

  openDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomDialogueWidget(
          text: MyFacilityListConstants.POPUP_TEXT,
          onTapSubmit: () {
            setState(() {
              yesButtonTap = true;
              cancelButtonTap = false;
            });
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const TaskList(),
              ),
            );
          },
          onTapCancel: () {
            setState(() {
              cancelButtonTap = true;
              yesButtonTap = false;
            });
          },
        );
      },
    );
  }
}
