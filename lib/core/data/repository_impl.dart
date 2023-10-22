import 'package:flutter/material.dart';
import 'package:insurance_challenge/core/data/source/remote/remote_data_source.dart';
import 'package:insurance_challenge/core/data/source/remote/response/premium_response.dart';
import 'package:insurance_challenge/core/domain/model/failure.dart';
import 'package:insurance_challenge/core/domain/model/history.dart';
import 'package:insurance_challenge/core/domain/repository/repository.dart';

class RepositoryImpl implements Repository {

  RepositoryImpl(this._remote);

  final RemoteDataSource _remote;

  @override
  Future<(String?, Failure?)> login({
    required String email,
    required String password,
  }) async {
    try {
      String result = await _remote.login(email: email, password: password);
      return (result, null);
    } catch (e) {
      return (null, Failure(message: e.toString()));
    }
  }

  @override
  Future<(String?, Failure?)> addPremiumCalculation(History data) async {
    try {
      String result = await _remote.addPremiumCalculation(data.toMapMessage());
      return (result, null);
    } catch (e) {
      return (null, Failure(message: e.toString()));
    }
  }

  @override
  Future<(List<History>?, Failure?)> getHistoryList() async {
    try {
      List<PremiumResponse> result = await _remote.getHistoryList();
      debugPrint('getHistoryList: $result');
      return (result.map((e) => History.fromResponse(e)).toList(), null);
    } catch (e) {
      return (null, Failure(message: e.toString()));
    }
  }

  @override
  Future<(String?, Failure?)> logout() async {
    try {
      String result = await _remote.logout();
      return (result, null);
    } catch (e) {
      return (null, Failure(message: e.toString()));
    }
  }
}
