import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insurance_challenge/core/domain/model/failure.dart';
import 'package:insurance_challenge/core/domain/model/history.dart';
import 'package:insurance_challenge/core/domain/use_case/get_history_list.dart';

part 'history_event.dart';

part 'history_state.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  HistoryBloc(this._getHistoryList) : super(const HistoryStateInitial()) {
    on<HistoryEventGetHistoryList>(_onHistoryEventGetHistoryList);
  }

  final GetHistoryList _getHistoryList;

  FutureOr _onHistoryEventGetHistoryList(
    HistoryEventGetHistoryList event,
    Emitter<HistoryState> emit,
  ) async {
    if (event.refresh) {
      emit(HistoryStateRefreshing(list: state.list));
    } else {
      emit(HistoryStateLoading(list: state.list));
    }

    (List<History>?, Failure?) result = await _getHistoryList.execute();

    if (result.$2 == null) {
      await Future.delayed(Duration(seconds: 3));
      emit(HistoryStateSuccess(list: result.$1!));
    } else {
      emit(HistoryStateError(result.$2!.message));
    }
  }
}
