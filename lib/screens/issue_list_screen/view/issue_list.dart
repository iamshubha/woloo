import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:janitor/screens/common_widgets/custom_dialogue_widget.dart';
import 'package:janitor/screens/common_widgets/issue_list_widget.dart';
import 'package:janitor/screens/report_issue_screen/view/report_issue_form.dart';
import 'package:janitor/utils/app_color.dart';
import 'package:janitor/utils/app_constants.dart';

class IssuesList extends StatefulWidget {
  const IssuesList({Key? key}) : super(key: key);

  @override
  State<IssuesList> createState() => _IssuesListState();
}

class _IssuesListState extends State<IssuesList> {
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
        title: Padding(
          padding: EdgeInsets.symmetric(vertical: 10.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                MyIssuesListScreenConstants.TITLE_TEXT,
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ReportIssueScreen(),
                    ),
                  );
                },
                child: Container(
                  height: 32.h,
                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                    color: AppColors.buttonColor,
                  ),
                  child: Center(
                    child: Text(
                      "Report Issue",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: AppColors.black,
                        fontSize: 16.sp,
                      ),
                    ),
                  ),
                ),
              )
            ],
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
          Expanded(
            child: IssueListWidget(
              onTapItem: () {
                // openDialog();
                // Navigator.of(context).push(
                //   MaterialPageRoute(
                //     builder: (context) => JanitorDetails(id: 12),
                //   ),
                // );
              },
              name: 'Cluster 1',
              facilityName: "Facility Name - OPD",
              janitorName: 'Janitor name- Uma Jadhav',
              status: "Pending",
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
          text: MyFacilityListConstants.POPUP_TEXT,
          onTapSubmit: () {
            setState(() {
              yesButtonTap = true;
              cancelButtonTap = false;
            });
            // Navigator.of(context).push(
            //   MaterialPageRoute(
            //     builder: (context) => const TaskList(),
            //   ),
            // );
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
