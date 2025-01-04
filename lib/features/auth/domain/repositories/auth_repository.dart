import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failure.dart';

abstract class AuthRepository {
  Future<Either<Failure, void>> login(
    String email,
    String password,
  );
  Future<Either<Failure, void>> register(
    String email,
    String password,
    String name,
  );
  Future<Either<Failure, void>> logout();
  Future<Either<Failure, String>> getToken();
}
