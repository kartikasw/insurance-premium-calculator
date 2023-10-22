import 'package:insurance_challenge/core/data/source/remote/response/premium_response.dart';

abstract class RemoteDataSource {
  Future<String> login({required String email, required String password});

  Future<String> addPremiumCalculation(Map<String, dynamic> data);

  Future<List<PremiumResponse>> getHistoryList();

  Future<String> logout();
}
