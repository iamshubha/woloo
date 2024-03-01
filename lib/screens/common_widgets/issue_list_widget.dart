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
  final IssueListBloc issueListBloc;
  final Function onTapItem;

  const IssueListWidget({
    super.key,
    required this.issueListBloc,
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
  late IssueListBloc _issueListBloc;

  @override
  void initState() {
    supervisorId = globalStorage.getId();
    _issueListBloc = widget.issueListBloc;
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
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 5.w),
                          child: Container(
                            height: 50.h,
                            width: 50.w,
                            decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColors.darkGreyColor),
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 10.h),
                              child: Image.asset(
                                AppImages.bed_img,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 5.w,
                              vertical: 5.h,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _data[index].clusterName ?? '',
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  softWrap: true,
                                  style: TextStyle(
                                    color: AppColors.janitorNameColor,
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                SizedBox(height: 10.h),
                                Text(
                                  "${MyIssuesListScreenConstants.FACILITY_NAME.tr()} - ${_data[index].facilityName}",
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: TextStyle(
                                    color: AppColors.clusterTitleColor,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                SizedBox(height: 5.h),
                                Text(
                                  "${MyIssuesListScreenConstants.JANITOR_NAME.tr()} - ${_data[index].janitorName}",
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: TextStyle(
                                    color: AppColors.clusterTitleColor,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                SizedBox(height: 5.h),
                                Text(
                                  "${MyIssuesListScreenConstants.DESCRIPTION.tr()}- ${_data[index].description ?? "-"}",
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: TextStyle(
                                    color: AppColors.clusterTitleColor,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                SizedBox(height: 10.h),
                                Text(
                                  (_data[index].status ?? '').tr(),
                                  style: TextStyle(
                                    color: pending ? AppColors.redText : AppColors.greenText,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
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
