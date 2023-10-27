import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Woloo_Smart_hygiene/screens/choose_facility_screen/view/choose_facility.dart';
import 'package:Woloo_Smart_hygiene/screens/cluster_screen/data/model/Cluster_model.dart';
import 'package:Woloo_Smart_hygiene/screens/common_widgets/cluster_list.dart';
import 'package:Woloo_Smart_hygiene/screens/janitor_screen/view/janitor_screen.dart';
import 'package:Woloo_Smart_hygiene/utils/app_color.dart';
import 'package:Woloo_Smart_hygiene/utils/app_constants.dart';

class ClusterList extends StatefulWidget {
  const ClusterList({Key? key}) : super(key: key);

  @override
  State<ClusterList> createState() => _ClusterListState();
}

class _ClusterListState extends State<ClusterList> {
  bool cancelButtonTap = true;
  bool yesButtonTap = false;
  int selectedCard = -1;
  final TextEditingController _searchController = TextEditingController();
  ClusterModel _clusterModel = ClusterModel();
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
          MyClusterListScreenConstants.TITLE_TEXT,
          style: TextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
        ),
        // leading: IconButton(
        //   color: AppColors.black30,
        //   icon: const Icon(
        //     Icons.arrow_back,
        //     color: Colors.black,
        //     size: 30,
        //   ),
        //   // color: AppColors.black,
        //   onPressed: () {
        //     Navigator.pop(context);
        //   },
        // ),
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
          Expanded(
            child: ClusterListWidget(
              controller: _searchController,
              onTapItem: (ClusterModel list) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => JanitorList(
                      isFromCluster: true,
                      isFromDashboard: false,
                      clusterId: list.clusterId.toString(),
                      isFromDashboardAssignment: false,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
