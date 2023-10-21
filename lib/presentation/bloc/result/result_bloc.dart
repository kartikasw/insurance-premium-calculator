import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';

part 'result_event.dart';

part 'result_state.dart';

class ResultBloc extends Bloc<ResultEvent, ResultState> {
  ResultBloc() : super(const ResultStateInitial()) {
    on<ResultEventGenerateResultPdf>(_onResultEventGenerateResultPdf);
  }

  FutureOr _onResultEventGenerateResultPdf(
      ResultEventGenerateResultPdf event,
    Emitter<ResultState> emit,
  ) async {
    emit(ResultStateLoading(history: state.history));
    try {
      String path = "${(await getApplicationDocumentsDirectory()).path}/${event.customerName}";
      await File(path).writeAsBytes(event.data);
      await Future.delayed(Duration(seconds: 2));
      emit(ResultStateSuccess(history: path));
    } catch (e) {
      emit(ResultStateError(e.toString()));
    }
  }
}
