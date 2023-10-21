part of 'history_bloc.dart';

class HistoryState extends Equatable {
  final List<History> list;

  const HistoryState({this.list = const []});

  @override
  List<Object?> get props => [list];
}

class HistoryStateInitial extends HistoryState {
  const HistoryStateInitial({super.list});
}

class HistoryStateLoading extends HistoryState {
  const HistoryStateLoading({super.list});
}

class HistoryStateRefreshing extends HistoryState {
  const HistoryStateRefreshing({super.list});
}

class HistoryStateSuccess extends HistoryState {
  const HistoryStateSuccess({super.list});
}

class HistoryStateError extends HistoryState {
  final String errMessage;

  const HistoryStateError(this.errMessage, {super.list});

  @override
  List<Object?> get props => [errMessage];
}
