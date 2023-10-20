import 'package:insurance_challenge/core/domain/model/failure.dart';
import 'package:insurance_challenge/core/domain/repository/repository.dart';

class Login {
  final Repository repository;

  Login(this.repository);

  Future<(String?, Failure?)> execute({
    required String username,
    required String password,
  }) {
    return repository.login(username: username, password: password);
  }
}
