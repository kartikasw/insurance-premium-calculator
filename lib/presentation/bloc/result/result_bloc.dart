import 'dart:async';
import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'result_event.dart';

part 'result_state.dart';

class ResultBloc extends Bloc<ResultEvent, ResultState> {
  ResultBloc() : super(ResultStateInitial()) {
    on<ResultEventGenerateResultPdf>(_onResultEventGenerateResultPdf);
  }

  FutureOr _onResultEventGenerateResultPdf(
    ResultEventGenerateResultPdf event,
    Emitter<ResultState> emit,
  ) async {
    emit(ResultStateLoading());
    try {
      emit(ResultStateSuccess(event.data));
    } catch (e) {
      emit(ResultStateError(e.toString()));
    }
  }
}
