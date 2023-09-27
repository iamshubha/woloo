import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:janitor/screens/issue_list_screen/bloc/issue_list_event.dart';
import 'package:janitor/screens/issue_list_screen/bloc/issue_list_state.dart';
import 'package:janitor/screens/issue_list_screen/data/network/issue_list_service.dart';


class IssueListBloc extends Bloc<IssueListEvent, IssueListState> {
  final IssueListService issueListService = IssueListService(dio: GetIt.instance());

  IssueListBloc() : super(IssueListInitial()) {
    on<IssueListEvent>((event, emit) {});
    on<GetAllIssues>(_mapGetAllIssuesToState);
  }

  FutureOr<void> _mapGetAllIssuesToState(GetAllIssues event, Emitter<IssueListState> emit) async {
    try {
      emit(IssueListLoading());
      var data = await issueListService.getAllTasks(supervisorId: event.supervisorId);

      emit(IssueListSuccess(data: data));
    } catch (e) {
      emit(IssueListError(error: e.toString()));
    }
  }

}
