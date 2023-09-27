import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:dio_log/overlay_draggable_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:janitor/core/local/global_storage.dart';
import 'package:janitor/screens/cluster_screen/view/cluster_screen.dart';
import 'package:janitor/screens/issue_list_screen/view/issue_list.dart';
import 'package:janitor/screens/janitor_screen/view/janitor_screen.dart';
import 'package:janitor/screens/supervisor_dashboard/pages/templates_screen.dart';
import 'package:janitor/utils/app_color.dart';
import 'package:janitor/utils/app_constants.dart';
import 'package:janitor/utils/app_images.dart';

class SupervisorDashboard extends StatefulWidget {
  const SupervisorDashboard({
    Key? key,
  }) : super(key: key);

  @override
  State<SupervisorDashboard> createState() => _SupervisorDashboardState();
}

class _SupervisorDashboardState extends State<SupervisorDashboard> {
  int _currentIndex = 0;
  String? supervisorName;

  final _controller = PageController(
    initialPage: 4,
  );

  final imageList = [
    AppImages.cluster_icon,
    AppImages.janitor_icon,
    AppImages.report_issue_icon,
    AppImages.customer_request_icon,
  ];
  final labelList = <String>[
    BottomNavigatiionBarConstants.CLUSTER,
    BottomNavigatiionBarConstants.JANITORS,
    BottomNavigatiionBarConstants.REPORT_ISSUE,
    BottomNavigatiionBarConstants.ACCOUNT,
  ];
  var _bottomNavIndex = 0; // efault index of first screen
  GlobalStorage globalStorage = GetIt.instance();

  @override
  void initState() {
    supervisorName = globalStorage.getSupervisorName();
    print(supervisorName);

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: GestureDetector(
        onTap: () {
          _controller.animateToPage(
            4,
            duration: const Duration(
              milliseconds: 200,
            ),
            curve: Curves.bounceOut,
          );
        },
        child: Container(
          width: 58,
          height: 58,
          decoration: ShapeDecoration(
            color: Color(0xFF3D443D),
            shape: OvalBorder(
              side: BorderSide(
                width: 1.50,
                strokeAlign: BorderSide.strokeAlignCenter,
                color: Color(0xFFFFE22C),
              ),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 10.w,
              vertical: 10.h,
            ),
            child: Image.asset(
              AppImages.fab_img,
              height: 26.h,
              width: 26.w,
            ),
          ),
        ),
      ),
      bottomNavigationBar: AnimatedBottomNavigationBar.builder(
        itemCount: imageList.length, height: 60.h,
        tabBuilder: (int index, bool isActive) {
          // final color = isActive
          //     ? colors.activeNavigationBarColor
          //     : colors.notActiveNavigationBarColor;

          return Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                imageList[index],
                height: 20.h,
                width: 20.w,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5.h),
                child: Text(
                  labelList[index],
                  // maxLines: 1,
                  style: TextStyle(
                      color: AppColors.labelColor,
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w400),
                ),
              )
            ],
          );
        },

        backgroundColor: AppColors.bottomNavigationColor,
        activeIndex: _bottomNavIndex,
        splashSpeedInMilliseconds: 300,
        notchSmoothness: NotchSmoothness.softEdge,
        gapLocation: GapLocation.center,
        // leftCornerRadius: 32,
        // rightCornerRadius: 32,
        onTap: (index) {
          _controller.animateToPage(
            index,
            duration: const Duration(
              milliseconds: 200,
            ),
            curve: Curves.bounceOut,
          );
          // setState(() => _bottomNavIndex = index);
        },
      ),
      backgroundColor: AppColors.white,
      body: PageView(
        controller: _controller,
        onPageChanged: (index) {
          setState(
            () {
              _bottomNavIndex = index;
            },
          );
        },
        children: [
          ClusterList(),
          JanitorList(
            isFromDashboard: true,
            isFromCluster: false,
            isFromDashboardAssignment: false,
          ),
          IssuesList(),
          Container(
            child: Center(
              child: Text("This screen is in progress"),
            ),
          ),
          TemplateScreen(
            supervisorName: supervisorName ?? '',
          ),
        ],
      ),
    );
  }
}
