import 'package:insurance_challenge/core/domain/model/failure.dart';
import 'package:insurance_challenge/core/domain/model/history.dart';
import 'package:insurance_challenge/core/domain/repository/repository.dart';

class RepositoryImpl implements Repository {
  @override
  Future<(List<History>?, Failure?)> getHistoryList() async {
    return (null, null);
  }

  @override
  Future<(String?, Failure?)> login({
    required String username,
    required String password,
  }) async {
    return (null, null);
  }
}
