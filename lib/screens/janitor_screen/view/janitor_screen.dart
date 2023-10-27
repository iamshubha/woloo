import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Woloo_Smart_hygiene/screens/choose_facility_screen/view/choose_facility.dart';
import 'package:Woloo_Smart_hygiene/screens/common_widgets/custom_dialogue_widget.dart';
import 'package:Woloo_Smart_hygiene/screens/common_widgets/janitor_list.dart';
import 'package:Woloo_Smart_hygiene/screens/janitor_details_screen/view/janitor_details.dart';
import 'package:Woloo_Smart_hygiene/screens/janitor_screen/data/model/Janitor_list_model.dart';
import 'package:Woloo_Smart_hygiene/utils/app_color.dart';
import 'package:Woloo_Smart_hygiene/utils/app_constants.dart';

class JanitorList extends StatefulWidget {
  final bool isFromCluster;
  final bool isFromDashboard;
  final bool isFromDashboardAssignment;

  final String? clusterId;
  List<String>? allocationId;
  JanitorList(
      {Key? key,
      required this.isFromCluster,
      required this.isFromDashboard,
      required this.isFromDashboardAssignment,
      this.allocationId,
      this.clusterId})
      : super(key: key);

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
        leading: widget.isFromCluster || widget.isFromDashboardAssignment
            ? IconButton(
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
              )
            : Container(),
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
                controller: _searchController,
                clusterId: widget.clusterId,
                onTapItem: (JanitorListModel data) {
                  if (widget.isFromCluster && data.isPresent == true) {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ChooseFacilityList(
                          janitorId: data.id ?? '',
                          clusterId: widget.clusterId ?? '',
                        ),
                      ),
                    );
                  }
                  if (widget.isFromDashboard) {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => JanitorDetails(
                          id: data.id ?? '',
                          shift: data.shift.toString(),
                          check_in_time: data.startTime.toString(),
                          check_out_time: data.endTime.toString(),
                          complete_task: data.completedTaskCount!,
                          pending_task: data.pendingTaskCount.toString(),
                          total_task: data.totalTaskCount.toString(),
                          name: data.name.toString(),
                          mobile: data.mobile.toString(),
                          isPresent: data.isPresent ?? false,
                        ),
                      ),
                    );
                  }
                },
                isFromCluster: widget.isFromCluster,
                isFromDashboard: widget.isFromDashboard,
                isFromFacility: false,
                allocationId: widget.allocationId ?? [],
                isFromDashboardAssignment: widget.isFromDashboardAssignment,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
