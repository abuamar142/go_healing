import 'dart:convert';

import 'package:go_healing/core/error/exceptions.dart';
import 'package:http/http.dart';

import '../models/user_model.dart';

abstract class UserRemoteDataSource {
  Future<List<UserModel>> getAllUsers(int page);
  Future<UserModel> getUserById(int id);
}

class UserRemoteDataSourceImpl extends UserRemoteDataSource {
  final Client client;

  UserRemoteDataSourceImpl({required this.client});

  @override
  Future<List<UserModel>> getAllUsers(int page) async {
    Uri url = Uri.parse('https://reqres.in/api/users?page=$page');

    return await client.get(url).then(
      (response) {
        if (response.statusCode == 200) {
          List<dynamic> data = jsonDecode(response.body)['data'];

          if (data.isEmpty) {
            throw const EmptyException(message: 'No users found');
          }

          List<UserModel> users =
              data.map((e) => UserModel.fromJson(e)).toList();

          return users;
        } else {
          throw const GeneralException(message: 'Failed to load users');
        }
      },
    );
  }

  @override
  Future<UserModel> getUserById(int id) async {
    Uri url = Uri.parse('https://reqres.in/api/users/$id');

    return await client.get(url).then(
      (response) {
        if (response.statusCode == 200) {
          Map<String, dynamic> data = jsonDecode(response.body)['data'];

          UserModel user = UserModel.fromJson(data);

          return user;
        } else if (response.statusCode == 404) {
          throw const EmptyException(message: 'User not found');
        } else {
          throw const GeneralException(message: 'Failed to load user');
        }
      },
    );
  }
}
