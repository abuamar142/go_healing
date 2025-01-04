import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failure.dart';
import '../repositories/auth_repository.dart';

class AuthGetToken {
  final AuthRepository repository;

  AuthGetToken(this.repository);

  Future<Either<Failure, String>> call() async {
    return await repository.getToken();
  }
}