part of 'result_bloc.dart';

class ResultState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ResultStateInitial extends ResultState {
}

class ResultStateLoading extends ResultState {
}

class ResultStateSuccess extends ResultState {
  ResultStateSuccess(this.pdfData);

  final Uint8List pdfData;
}

class ResultStateError extends ResultState {
  final String errMessage;

  ResultStateError(this.errMessage);

  @override
  List<Object?> get props => [errMessage];
}
