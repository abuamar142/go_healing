import 'package:fpdart/fpdart.dart';
import '../repositories/auth_repository.dart';

import '../../../../core/error/failure.dart';

class AuthLogin {
  final AuthRepository authRepository;

  const AuthLogin({required this.authRepository});

  Future<Either<Failure, void>> call(String email, String password) async {
    return await authRepository.login(email, password);
  }
}
