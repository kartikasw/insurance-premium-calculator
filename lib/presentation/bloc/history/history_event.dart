part of 'history_bloc.dart';

class HistoryEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class HistoryEventGetHistoryList extends HistoryEvent {
  HistoryEventGetHistoryList({this.refresh = false});

  final bool refresh;
}
