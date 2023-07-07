import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:janitor/screens/choose_facility_screen/view/choose_facility.dart';
import 'package:janitor/screens/common_widgets/cluster_list.dart';
import 'package:janitor/utils/app_color.dart';
import 'package:janitor/utils/app_constants.dart';

class ClusterList extends StatefulWidget {
  const ClusterList({Key? key}) : super(key: key);

  @override
  State<ClusterList> createState() => _ClusterListState();
}

class _ClusterListState extends State<ClusterList> {
  final TextEditingController _searchController = TextEditingController();
  bool cancelButtonTap = true;
  bool yesButtonTap = false;
  int selectedCard = -1;

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
              vertical: 10.h,
            ),
            child: Text(
              "List of Cluster",
              style: TextStyle(
                color: AppColors.clusterTitleColor,
                fontSize: 20.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Expanded(
            child: ClusterListWidget(
              title: 'Cluster 1',
              pincode: '441256',
              janitorName: 'Uma Jadhav',
              total_tasks: "4",
              pending_tasks: "4",
              onTapItem: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const ChooseFacilityList(
                      isFromClusterScreen: true,
                      isFromAuthenticationScreen: false,
                    ),
                  ),
                );
              },
            ),

            // ListView.builder(
            //   physics: const BouncingScrollPhysics(),
            //   itemCount: 6,
            //   scrollDirection: Axis.vertical,
            //   shrinkWrap: true,
            //   itemBuilder: (
            //     BuildContext context,
            //     int index,
            //   ) {
            //     return Padding(
            //       padding: EdgeInsets.symmetric(
            //         vertical: 7.h,
            //       ),
            //       child: ClusterListWidget(
            //         title: 'Cluster 1',
            //         pincode: '441256',
            //         janitorName: 'Uma Jadhav',
            //         total_tasks: "4",
            //         pending_tasks: "4",
            //         onTapItem: () {
            //           setState(() {
            //             selectedCard = index;
            //           });
            //           Navigator.of(context).push(
            //             MaterialPageRoute(
            //               builder: (context) => const ChooseFacilityList(
            //                 isFromClusterScreen: true,
            //                 isFromAuthenticationScreen: false,
            //               ),
            //             ),
            //           );
            //         },
            //       ),
            //     );
            //   },
            // ),
          ),
        ],
      ),
    );
  }
}
