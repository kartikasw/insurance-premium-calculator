part of 'result_bloc.dart';

class ResultState extends Equatable {
  const ResultState({this.history = ''});

  final String history;

  @override
  List<Object?> get props => [history];
}

class ResultStateInitial extends ResultState {
  const ResultStateInitial({super.history});
}

class ResultStateLoading extends ResultState {
  const ResultStateLoading({super.history});
}

class ResultStateSuccess extends ResultState {
  const ResultStateSuccess({super.history});
}

class ResultStateError extends ResultState {
  final String errMessage;

  const ResultStateError(this.errMessage, {super.history});

  @override
  List<Object?> get props => [errMessage, super.history];
}
