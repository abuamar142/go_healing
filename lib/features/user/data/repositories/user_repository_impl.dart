import 'package:fpdart/fpdart.dart';
import 'package:go_healing/features/user/domain/entities/user.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

import '../../../../core/error/failure.dart';
import '../../domain/repositories/user_repository.dart';
import '../datasources/user_local_datasource.dart';
import '../datasources/user_remote_datasource.dart';
import '../models/user_model.dart';

class UserRepositoryImpl extends UserRepository {
  final InternetConnection internetConnection;
  final UserLocalDatasource userLocalDatasource;
  final UserRemoteDataSource userRemoteDataSource;

  UserRepositoryImpl({
    required this.internetConnection,
    required this.userLocalDatasource,
    required this.userRemoteDataSource,
  });

  @override
  Future<Either<Failure, List<User>>> getAllUsers(int page) async {
    try {
      final hasInternet = await internetConnection.hasInternetAccess;

      if (hasInternet) {
        List<UserModel> response = await userRemoteDataSource.getAllUsers(page);

        userLocalDatasource.insertUsers(response);

        return right(response);
      } else {
        List<UserModel> response = await userLocalDatasource.getUsers();

        return right(response);
      }
    } catch (e) {
      return left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> getUserById(int id) async {
    try {
      final hasInternet = await internetConnection.hasInternetAccess;

      if (hasInternet) {
        UserModel response = await userRemoteDataSource.getUserById(id);

        userLocalDatasource.insertUser(response);

        return right(response);
      } else {
        UserModel response = await userLocalDatasource.getUserById();

        return right(response);
      }
    } catch (e) {
      return left(Failure(message: e.toString()));
    }
  }
}
