import 'package:insurance_challenge/core/domain/model/failure.dart';
import 'package:insurance_challenge/core/domain/repository/repository.dart';

class AddPremiumCalculation {
  final Repository repository;

  AddPremiumCalculation(this.repository);

  Future<(String?, Failure?)> execute(Map<String, dynamic> data) {
    return repository.addPremiumCalculation(data);
  }
}