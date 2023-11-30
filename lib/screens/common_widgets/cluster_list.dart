import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Woloo_Smart_hygiene/screens/cluster_screen/bloc/cluster_list_bloc.dart';
import 'package:Woloo_Smart_hygiene/screens/cluster_screen/bloc/cluster_list_event.dart';
import 'package:Woloo_Smart_hygiene/screens/cluster_screen/data/model/Cluster_model.dart';
import 'package:Woloo_Smart_hygiene/utils/app_constants.dart';

import '../../utils/app_color.dart';
import '../cluster_screen/bloc/cluster_list_state.dart';
import 'empty_list_widget.dart';
import 'error_widget.dart';

class ClusterListWidget extends StatefulWidget {
  final TextEditingController controller;

  final Function onTapItem;
  const ClusterListWidget({
    Key? key,
    required this.controller,
    required this.onTapItem,
  }) : super(key: key);

  @override
  State<ClusterListWidget> createState() => _ClusterListWidgetState();
}

class _ClusterListWidgetState extends State<ClusterListWidget> {
  int selectedCard = -1;
  ClusterListBloc _clusterListBloc = ClusterListBloc();
  List<ClusterModel> _search = [];

  List<ClusterModel> _data = [];

  @override
  void initState() {
    _clusterListBloc.add(GetAllClusters());
    widget.controller.addListener(() {
      setState(() {
        if (widget.controller.text.isEmpty) {
          _search = _data;
          return;
        }

        _search = _data
            .where((element) =>
                element.clusterName
                    ?.toLowerCase()
                    .contains(widget.controller.text.toLowerCase()) ??
                false)
            .toList();
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
        bloc: _clusterListBloc,
        listener: (context, state) {
          if (state is ClusterListSuccess) {
            EasyLoading.dismiss();

            setState(() {
              _data = state.data;
              _search = _data;
            });
          }
        },
        builder: (context, state) {
          if (state is ClusterListLoading && _search.isEmpty) {
            EasyLoading.show(
                status: MydashboardScreenConstants.LOADING_TOAST.tr());
          }

          if (state is ClusterListError) {
            EasyLoading.dismiss();
            return CustomErrorWidget(error: state.error);
          }

          if (state is ClusterListSuccess && (state.data.isEmpty)) {
            EasyLoading.dismiss();
            return const EmptyListWidget();
          }
          return RefreshIndicator(
            onRefresh: () {
              return Future.delayed(
                Duration(seconds: 1),
                () {
                  _clusterListBloc.add(GetAllClusters());
                },
              );
            },
            color: AppColors.buttonColor,
            child: ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: _search.length,
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemBuilder: (
                  BuildContext context,
                  int index,
                ) {
                  return Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 7.h,
                    ),
                    child: GestureDetector(
                      onTap: () {
                        widget.onTapItem(_search[index]);
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
                          color: selectedCard == index
                              ? AppColors.containerColor
                              : AppColors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: AppColors.containerBorder,
                            width: 1.w,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 5.w,
                                      vertical: 2.h,
                                    ),
                                    child: Text(
                                      _search[index].clusterName ?? '',
                                      style: TextStyle(
                                        color: AppColors.clusterTitleColor,
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
          );
        });
  }
}
