import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Woloo_Smart_hygiene/core/network/api_constant.dart';
import 'package:Woloo_Smart_hygiene/screens/choose_facility_screen/data/model/Facility_list_model.dart';
import 'package:Woloo_Smart_hygiene/screens/choose_facility_screen/data/model/selected_tasks.dart';
import 'package:Woloo_Smart_hygiene/screens/common_widgets/button_widget.dart';
import 'package:Woloo_Smart_hygiene/screens/common_widgets/custom_dialogue_widget.dart';
import 'package:Woloo_Smart_hygiene/screens/common_widgets/list_widget.dart';
import 'package:Woloo_Smart_hygiene/screens/reassign_janitor_screen/view/reassign_janitor_screen.dart';
import 'package:Woloo_Smart_hygiene/screens/task_details_screen/view/task_details.dart';
import 'package:Woloo_Smart_hygiene/utils/app_color.dart';
import 'package:Woloo_Smart_hygiene/utils/app_constants.dart';

import 'assign_succefully.dart';

class ChooseFacilityList extends StatefulWidget {
  final String? janitorId;
  final String? clusterId;
  final String? janitorName;

  const ChooseFacilityList({
    Key? key,
    required this.janitorId,
    this.clusterId,
    this.janitorName
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
  String  janitorName = "";
  List<String> selectedIds = [];
  String allocationId = "";

  List<FacilityListModel> _facilityListModel = [];
  List<bool> _checkList = [];

  SelectTaskModel selectTaskModel = SelectTaskModel();
  var key = GlobalKey(); // using this to refresh the list widget

  @override
  void initState() {
    super.initState();

    print("facility_clusterId---->>>>${widget.clusterId}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.appbarBgColor,
        title: Text(
          MyFacilityScreenConstants.TITLE_TEXT.tr(),
          style: TextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.w400,
            color: AppColors.yellowSplashColor,
          ),
        ),
        leading: IconButton(
          color: AppColors.black30,
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
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
                hintText: MyFacilityListConstants.SEARCH.tr(),
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
                  MydashboardScreenConstants.FACILITY.tr(),
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
                      print("_facilityListModel---->${_facilityListModel.length}");
                      if (selectAll) {
                        for (var i = 0; i < _facilityListModel.length; i++) {

                          if (!selectedIds.contains(_facilityListModel[i].id.toString())) {
                            selectedIds.add(_facilityListModel[i].id.toString());

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
                      Text(MyFacilityListConstants.SELECT_ALL.tr()),
                      Container(
                        width: 15.w,
                        height: 15.h,
                        decoration: BoxDecoration(
                          color: selectAll ? AppColors.buttonColor : AppColors.white,
                          borderRadius: BorderRadius.circular(3.r),
                          border: Border.all(color: selectAll ? Colors.transparent : AppColors.checkboxGreyBorder),
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
                key: key,
                controller: _searchController,
                janitorId: widget.janitorId ?? '',
                clusterId: widget.clusterId ?? '',
                onTapItem: () {},
                onChecked: (bool selected, FacilityListModel listObject, List<FacilityListModel> list) {
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
                janitorName =    _facilityListModel[i].janitorName!;
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
              onTap: () async {
                          print("dsfsd${janitorName}");
                          print("sdf $_checkList");
                          print("sdfdsf $selectedIds");
                if (selectedIds.isNotEmpty) {
                  await Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>
                      // AssignSuccefully(
                      //   janitorName: janitorName,
                      //   assignTask: selectedIds,
                      // )
                          ReassignJanitorScreen(
                        isFromCluster: true,
                        clusterId: widget.clusterId,
                        janitorId: widget.janitorId ?? '',
                        allocationId: allocationId,
                        selectedIds: selectedIds,
                      ),
                    ),
                  );
                  setState(() => key = GlobalKey());
                }
              },
              child: ButtonWidget(
                enabled: selectedIds.isNotEmpty ? true : false,
                text: MyFacilityListConstants.ASSIGN.tr(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
