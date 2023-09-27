import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:janitor/screens/cluster_screen/bloc/cluster_list_event.dart';
import 'package:janitor/screens/cluster_screen/bloc/cluster_list_state.dart';
import 'package:janitor/screens/cluster_screen/data/network/cluster_list_service.dart';
import 'package:janitor/screens/issue_list_screen/bloc/issue_list_event.dart';
import 'package:janitor/screens/issue_list_screen/bloc/issue_list_state.dart';
import 'package:janitor/screens/issue_list_screen/data/network/issue_list_service.dart';

class ClusterListBloc extends Bloc<ClusterListEvent, ClusterListState> {
  final ClusterListService clusterListService =
      ClusterListService(dio: GetIt.instance());

  ClusterListBloc() : super(ClusterListInitial()) {
    on<ClusterListEvent>((event, emit) {});
    on<GetAllClusters>(_mapGetAllClusterToState);
  }

  FutureOr<void> _mapGetAllClusterToState(
      GetAllClusters event, Emitter<ClusterListState> emit) async {
    try {
      emit(ClusterListLoading());
      var data = await clusterListService.getAllCluster();

      emit(ClusterListSuccess(data: data));
    } catch (e) {
      emit(ClusterListError(error: e.toString()));
    }
  }
}
