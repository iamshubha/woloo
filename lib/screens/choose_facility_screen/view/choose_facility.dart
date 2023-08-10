import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:janitor/screens/common_widgets/custom_dialogue_widget.dart';
import 'package:janitor/screens/common_widgets/list_widget.dart';
import 'package:janitor/utils/app_color.dart';
import 'package:janitor/utils/app_constants.dart';

class ChooseFacilityList extends StatefulWidget {
  final bool isFromAuthenticationScreen;
  final bool isFromClusterScreen;

  const ChooseFacilityList({
    Key? key,
    this.isFromAuthenticationScreen = false,
    this.isFromClusterScreen = false,
  }) : super(key: key);

  @override
  State<ChooseFacilityList> createState() => _ChooseFacilityListState();
}

class _ChooseFacilityListState extends State<ChooseFacilityList> {
  final TextEditingController _searchController = TextEditingController();
  bool cancelButtonTap = true;
  bool yesButtonTap = false;

  // final List<FacilityModel> _list = [
  //   FacilityModel(
  //     id: 0,
  //     name: "Restroom",
  //     description: '',
  //     location: '',
  //     booths: '',
  //     total_task: '',
  //     pending_task: '',
  //     time: '',
  //   ),
  //   FacilityModel(
  //     id: 1,
  //     name: "Gents Restroom",
  //     description: '',
  //     location: '',
  //     booths: '',
  //     total_task: '',
  //     pending_task: '',
  //     time: '',
  //   ),
  //   FacilityModel(
  //     id: 2,
  //     name: "Ladies Rest Room",
  //     description: '',
  //     location: '',
  //     booths: '',
  //     total_task: '',
  //     pending_task: '',
  //     time: '',
  //   ),
  //   FacilityModel(
  //     id: 3,
  //     name: "PWD Restroom",
  //     description: '',
  //     location: '',
  //     booths: '',
  //     total_task: '',
  //     pending_task: '',
  //     time: '',
  //   ),
  //   FacilityModel(
  //     id: 4,
  //     name: "Gents Rest Room",
  //     description: '',
  //     location: '',
  //     booths: '',
  //     total_task: '',
  //     pending_task: '',
  //     time: '',
  //   ),
  //   FacilityModel(
  //     id: 5,
  //     name: "Ladies Rest Room",
  //     description: '',
  //     location: '',
  //     booths: '',
  //     total_task: '',
  //     pending_task: '',
  //     time: '',
  //   ),
  // ];

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
            MyFacilityScreenConstants.TITLE_TEXT,
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
          )),
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
              "Facility",
              style: TextStyle(
                color: AppColors.titleColor,
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Expanded(child: ListWidget(
            // name: "OPD, A wing",
            // description: "Description: xyz",
            // time: "30 min",
            // location: "Location: Reliance hospital, Thane",
            // booths: "Booths : 2",
            // total_tasks: "Total task : 2",
            // pending_tasks: "Pending task : 2",
            // status: "In Progress",
            // itemCount: 6,
            onTapItem: () {
              // if (widget.isFromAuthenticationScreen) {
              //   openDialog();
              // }
              // if (widget.isFromClusterScreen) {
              //   Navigator.of(context).push(
              //     MaterialPageRoute(
              //       builder: (context) => TaskDetailsScreen(),
              //     ),
              //   );
              // }
            },
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
            // Navigator.of(context).push(
            //   MaterialPageRoute(
            //     builder: (context) => const TaskList(),
            //   ),
            // );
          },
          onTapCancel: () {
            Navigator.pop(context);
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
