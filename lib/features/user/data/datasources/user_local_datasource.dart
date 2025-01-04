import 'package:hive/hive.dart';

import '../models/user_model.dart';

abstract class UserLocalDatasource {
  void insertUsers(List<UserModel> users);
  void insertUser(UserModel user);
  Future<List<UserModel>> getUsers();
  Future<UserModel> getUserById();
}

class UserLocalDatasourceImpl extends UserLocalDatasource {
  final HiveInterface hive;

  UserLocalDatasourceImpl({required this.hive});

  @override
  void insertUsers(List<UserModel> users) {
    var userBox = hive.box('users');

    userBox.put('users', users);
  }

  @override
  void insertUser(UserModel user) {
    var userBox = hive.box('users');

    userBox.put('user', user);
  }

  @override
  Future<List<UserModel>> getUsers() {
    var userBox = hive.box('users');

    return Future.value(userBox.get('users'));
  }

  @override
  Future<UserModel> getUserById() {
    var userBox = hive.box('users');

    return Future.value(userBox.get('user'));
  }
}
