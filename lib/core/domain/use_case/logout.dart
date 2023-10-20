import 'package:insurance_challenge/core/domain/model/failure.dart';
import 'package:insurance_challenge/core/domain/repository/repository.dart';

class Logout {
  final Repository repository;

  Logout(this.repository);

  Future<(String?, Failure?)> execute() {
    return repository.logout();
  }
}
