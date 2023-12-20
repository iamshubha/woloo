import 'package:Woloo_Smart_hygiene/core/local/global_storage.dart';
import 'package:Woloo_Smart_hygiene/screens/issue_list_screen/bloc/issue_list_bloc.dart';
import 'package:Woloo_Smart_hygiene/screens/issue_list_screen/bloc/issue_list_event.dart';
import 'package:Woloo_Smart_hygiene/screens/issue_list_screen/bloc/issue_list_state.dart';
import 'package:Woloo_Smart_hygiene/screens/issue_list_screen/data/model/Issue_list_model.dart';
import 'package:Woloo_Smart_hygiene/utils/app_constants.dart';
import 'package:Woloo_Smart_hygiene/utils/app_images.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';

import '../../utils/app_color.dart';
import 'empty_list_widget.dart';
import 'error_widget.dart';

class IssueListWidget extends StatefulWidget {
  final Function onTapItem;

  const IssueListWidget({
    super.key,
    required this.onTapItem,
  });

  @override
  State<IssueListWidget> createState() => _IssueListWidgetState();
}

class _IssueListWidgetState extends State<IssueListWidget> {
  bool pending = false;
  int selectedCard = -1;
  List<IssueListModel> _data = [];
  late int supervisorId;

  GlobalStorage globalStorage = GetIt.instance();
  IssueListBloc _issueListBloc = IssueListBloc();

  @override
  void initState() {
    supervisorId = globalStorage.getId();
    _issueListBloc.add(GetAllIssues(supervisorId: supervisorId));
    pending = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      bloc: _issueListBloc,
      listener: (context, state) {
        if (state is IssueListSuccess) {
          EasyLoading.dismiss();

          setState(() {
            _data = state.data;
          });
        }
      },
      builder: (context, state) {
        if (state is IssueListLoading && _data.isEmpty) {
          EasyLoading.show(status: MydashboardScreenConstants.LOADING_TOAST.tr());
        }

        if (state is IssueListError) {
          return CustomErrorWidget(error: state.error);
        }

        if (state is IssueListSuccess && (state.data.isEmpty)) {
          EasyLoading.dismiss();
          return const EmptyListWidget();
        }
        return RefreshIndicator(
          onRefresh: () {
            return Future.delayed(
              Duration(seconds: 1),
              () {
                _issueListBloc.add(GetAllIssues(supervisorId: supervisorId));
              },
            );
          },
          color: AppColors.buttonColor,
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: _data.length,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemBuilder: (
              BuildContext context,
              int index,
            ) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 7.h),
                child: GestureDetector(
                  onTap: () {
                    widget.onTapItem();
                    setState(() {
                      selectedCard = index;
                    });
                  },
                  child: Container(
                    height: 140.h,
                    padding: EdgeInsets.symmetric(
                      vertical: 5.h,
                      horizontal: 10.w,
                    ),
                    margin: EdgeInsets.symmetric(
                      horizontal: 20.w,
                    ),
                    decoration: BoxDecoration(
                      color: selectedCard == index ? AppColors.containerColor : AppColors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: AppColors.containerBorder,
                        width: 1.w,
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 5.w),
                                child: Container(
                                  height: 62.h,
                                  width: 62.w,
                                  decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColors.darkGreyColor),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 10.h),
                                    child: Image.asset(
                                      AppImages.bed_img,
                                      height: 39.h,
                                      width: 39.w,
                                    ),
                                  ),
                                ),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 5.w,
                                      vertical: 2.h,
                                    ),
                                    child: Text(
                                      _data[index].clusterName ?? '',
                                      style: TextStyle(
                                        color: AppColors.janitorNameColor,
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 5.w,
                                      vertical: 2.h,
                                    ),
                                    child: Text(
                                      "${MyIssuesListScreenConstants.FACILITY_NAME.tr()} - ${_data[index].facilityName}",
                                      style: TextStyle(
                                        color: AppColors.clusterTitleColor,
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 5.w,
                                      vertical: 2.h,
                                    ),
                                    child: Text(
                                      "${MyIssuesListScreenConstants.JANITOR_NAME.tr()}- ${_data[index].janitorName}",
                                      style: TextStyle(
                                        color: AppColors.clusterTitleColor,
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 5.w,
                                      vertical: 2.h,
                                    ),
                                    child: Text(
                                      (_data[index].status ?? '').tr(),
                                      style: TextStyle(
                                        color: pending ? AppColors.redText : AppColors.greenText,
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
