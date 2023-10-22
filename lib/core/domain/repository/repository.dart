import 'package:insurance_challenge/core/domain/model/failure.dart';
import 'package:insurance_challenge/core/domain/model/history.dart';

abstract class Repository {
  Future<(String?, Failure?)> login({
    required String email,
    required String password,
  });

  Future<(String?, Failure?)> addPremiumCalculation(History data);

  Future<(List<History>?, Failure?)> getHistoryList();

  Future<(String?, Failure?)> logout();
}
