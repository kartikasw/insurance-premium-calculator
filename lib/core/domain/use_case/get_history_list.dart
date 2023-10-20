import 'package:insurance_challenge/core/domain/model/failure.dart';
import 'package:insurance_challenge/core/domain/model/history.dart';
import 'package:insurance_challenge/core/domain/repository/repository.dart';

class GetHistoryList {
  final Repository repository;

  GetHistoryList(this.repository);

  Future<(List<History>?, Failure?)> execute() {
    return repository.getHistoryList();
  }
}