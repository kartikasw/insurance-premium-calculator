import 'package:insurance_challenge/core/domain/model/failure.dart';
import 'package:insurance_challenge/core/domain/repository/repository.dart';

class Login {
  final Repository repository;

  Login(this.repository);

  Future<(String?, Failure?)> execute({
    required String email,
    required String password,
  }) {
    return repository.login(email: email, password: password);
  }
}
