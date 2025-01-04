import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failure.dart';
import '../repositories/auth_repository.dart';

class AuthLogout {
  final AuthRepository repository;

  AuthLogout(this.repository);

  Future<Either<Failure, void>> call() async {
    return await repository.logout();
  }
}
