import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:janitor/core/network/api_constant.dart';
import 'package:janitor/screens/choose_facility_screen/data/model/Facility_list_model.dart';
import 'package:janitor/screens/choose_facility_screen/data/model/selected_tasks.dart';
import 'package:janitor/screens/common_widgets/button_widget.dart';
import 'package:janitor/screens/common_widgets/custom_dialogue_widget.dart';
import 'package:janitor/screens/common_widgets/list_widget.dart';
import 'package:janitor/screens/reassign_janitor_screen/view/reassign_janitor_screen.dart';
import 'package:janitor/screens/task_details_screen/view/task_details.dart';
import 'package:janitor/utils/app_color.dart';
import 'package:janitor/utils/app_constants.dart';

class ChooseFacilityList extends StatefulWidget {
  final String? janitorId;
  const ChooseFacilityList({
    Key? key,
    required this.janitorId,
  }) : super(key: key);

  @override
  State<ChooseFacilityList> createState() => _ChooseFacilityListState();
}

class _ChooseFacilityListState extends State<ChooseFacilityList> {
  final TextEditingController _searchController = TextEditingController();
  bool cancelButtonTap = true;
  bool yesButtonTap = false;
  bool selectAll = false;
  bool isDisabled = false;
  List<String> selectedIds = [];
  String allocationId = "";

  List<FacilityListModel> _facilityListModel = [];
  List<bool> _checkList = [];
  SelectTaskModel selectTaskModel = SelectTaskModel();

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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
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
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      selectAll = !selectAll;
                      print(
                          "_facilityListModel---->${_facilityListModel.length}");
                      if (selectAll) {
                        for (var i = 0; i < _facilityListModel.length; i++) {
                          if (!selectedIds
                              .contains(_facilityListModel[i].id.toString())) {
                            selectedIds
                                .add(_facilityListModel[i].id.toString());
                          }
                          _checkList[i] = true;
                        }
                        print("add---->$selectedIds");
                      } else {
                        for (int i = 0; i < _facilityListModel.length; i++) {
                          _checkList[i] = false;
                        }
                        //_selectedProductIds.removeWhere((element) => element == data.tasks?[index].taskId);
                        selectedIds = [];
                        print("remove---->$selectedIds");
                      }

                      setState(() {});
                    });
                  },
                  child: Row(
                    children: [
                      Text('Select All '),
                      Container(
                        width: 15.w,
                        height: 15.h,
                        decoration: BoxDecoration(
                          color: selectAll
                              ? AppColors.buttonColor
                              : AppColors.white,
                          borderRadius: BorderRadius.circular(3.r),
                          border: Border.all(
                              color: selectAll
                                  ? Colors.transparent
                                  : AppColors.checkboxGreyBorder),
                        ),
                        child: !selectAll
                            ? null
                            : const Center(
                                child: Icon(
                                  Icons.check,
                                  size: 15,
                                  color: AppColors.black,
                                ),
                              ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
          Expanded(
            child: ListWidget(
                controller: _searchController,
                janitorId: widget.janitorId ?? '',
                onTapItem: () {},
                onChecked: (bool selected, FacilityListModel listObject,
                    List<FacilityListModel> list) {
                  setState(() {
                    _facilityListModel = list;
                    if (selectAll) {
                      selectAll = false;
                    }
                  });
                  if (selected) {
                    if (!selectedIds.contains(listObject.id)) {
                      selectedIds.add(listObject.id.toString());
                    }
                    print("add---->$selectedIds");
                  } else {
                    //_selectedProductIds.removeWhere((element) => element == data.tasks?[index].taskId);
                    selectedIds.removeWhere(
                      (element) => element == listObject.id,
                    );
                    print("remove---->$selectedIds");
                  }
                  bool flag = true;
                  for (var i = 0; i < _facilityListModel.length; i++) {
                    if (!_checkList[i]) {
                      flag = false;
                      break;
                    }
                  }
                  if (flag) selectAll = true;
                  setState(() {});
                },
                isCheckedSelectAll: selectAll,
                onSetData: (List<FacilityListModel> list) {
                  setState(() {
                    _facilityListModel = list;
                    for (int i = 0; i < list.length; i++) {
                      _checkList.add(false);
                    }
                  });
                },
                checkList: _checkList),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: 20.h,
              horizontal: 20.w,
            ),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ReassignJanitorScreen(
                      isFromCluster: true,
                      janitorId: widget.janitorId ?? '',
                      allocationId: allocationId,
                      selectedIds: selectedIds,
                    ),
                  ),
                );
              },
              child: ButtonWidget(
                enabled: selectedIds.isNotEmpty ? true : false,
                text: "Assign",
              ),
            ),
          ),
        ],
      ),
    );
  }
}
