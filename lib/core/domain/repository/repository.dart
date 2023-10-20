import 'package:insurance_challenge/core/domain/model/failure.dart';
import 'package:insurance_challenge/core/domain/model/history.dart';

abstract class Repository {
  Future<(String?, Failure?)> login({
    required String username,
    required String password,
  });

  Future<(List<History>?, Failure?)> getHistoryList();
}
