part of 'result_bloc.dart';

class ResultEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ResultEventGenerateResultPdf extends ResultEvent {
  ResultEventGenerateResultPdf(this.data, this.customerName);

  final Uint8List data;
  final String customerName;
}
