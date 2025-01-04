import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:go_healing/core/error/exceptions.dart';
import 'package:go_healing/features/user/data/datasources/user_remote_datasource.dart';
import 'package:go_healing/features/user/data/models/user_model.dart';
import 'package:http/http.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateNiceMocks([
  MockSpec<UserRemoteDataSource>(),
  MockSpec<Client>(),
])
import 'user_remote_datasources_test.mocks.dart';

void main() async {
  MockClient mockClient = MockClient();

  UserRemoteDataSource mockUserRemoteDataSource = MockUserRemoteDataSource();
  UserRemoteDataSource mockUserRemoteDataSourceImpl = UserRemoteDataSourceImpl(
    client: mockClient,
  );

  const int id = 1;
  const int page = 1;

  Uri getUserByIdUrl = Uri.parse('https://reqres.in/api/users/$id');
  Uri getAllUsersUrl = Uri.parse('https://reqres.in/api/users?page=$page');

  const UserModel mockUser = UserModel(
    id: id,
    email: 'johndoe@gmail.com',
    firstName: 'john',
    lastName: 'doe',
    avatar: 'https://reqres.in/img/faces/1-image.jpg',
  );

  group('User Remote Datasource', () {
    group('getUserById()', () {
      test('Success', () async {
        when(
          mockUserRemoteDataSource.getUserById(id),
        ).thenAnswer((_) async => mockUser);

        try {
          final user = await mockUserRemoteDataSource.getUserById(id);

          expect(user, mockUser);
        } catch (e) {
          fail("Should not throw an exception");
        }
      });

      test('Failure', () async {
        when(
          mockUserRemoteDataSource.getUserById(id),
        ).thenThrow(Exception());

        try {
          await mockUserRemoteDataSource.getUserById(id);

          fail("Should throw an exception");
        } catch (e) {
          expect(e, isException);
        }
      });
    });

    group('getAllUsers()', () {
      test('Success', () async {
        when(
          mockUserRemoteDataSource.getAllUsers(page),
        ).thenAnswer((_) async => [mockUser]);

        try {
          final users = await mockUserRemoteDataSource.getAllUsers(page);

          expect(users, [mockUser]);
        } catch (e) {
          fail("Should not throw an exception");
        }
      });

      test('Failure', () async {
        when(
          mockUserRemoteDataSource.getAllUsers(page),
        ).thenThrow(Exception());

        try {
          await mockUserRemoteDataSource.getAllUsers(page);

          fail("Should throw an exception");
        } catch (e) {
          expect(e, isException);
        }
      });
    });
  });

  group('User Remote Datasource Implementation', () {
    group('getUserById()', () {
      test('Success - 200', () async {
        when(mockClient.get(getUserByIdUrl)).thenAnswer(
          (_) async => Response(jsonEncode({'data': mockUser.toJson()}), 200),
        );

        try {
          final user = await mockUserRemoteDataSourceImpl.getUserById(id);

          expect(user, mockUser);
        } on EmptyException {
          fail("Should not throw an exception");
        } on GeneralException {
          fail("Should not throw an exception");
        } catch (e) {
          fail("Should not throw an exception");
        }
      });

      test('Failure - 404', () async {
        when(mockClient.get(getUserByIdUrl)).thenAnswer(
          (_) async => Response('User not found', 404),
        );

        try {
          await mockUserRemoteDataSourceImpl.getUserById(id);

          fail("Should throw an exception");
        } on EmptyException catch (e) {
          expect(e, isException);
        } on GeneralException {
          fail("Should throw an EmptyException");
        } catch (e) {
          fail("Should throw an EmptyException");
        }
      });

      test('Failure - 500', () async {
        when(mockClient.get(getUserByIdUrl)).thenAnswer(
          (_) async => Response('Internal Server Error', 500),
        );

        try {
          await mockUserRemoteDataSourceImpl.getUserById(id);

          fail("Should throw an exception");
        } on EmptyException {
          fail("Should throw an GeneralException");
        } on GeneralException catch (e) {
          expect(e, isException);
        } catch (e) {
          fail("Should throw an GeneralException");
        }
      });
    });

    group('getAllUsers()', () {
      test('Success - 200', () async {
        when(mockClient.get(getAllUsersUrl)).thenAnswer(
          (_) async => Response(
              jsonEncode({
                'data': [mockUser.toJson()]
              }),
              200),
        );

        try {
          final users = await mockUserRemoteDataSourceImpl.getAllUsers(page);

          expect(users, [mockUser]);
        } catch (e) {
          fail("Should not throw an exception");
        }
      });

      test('Failure - Empty', () async {
        when(mockClient.get(getAllUsersUrl)).thenAnswer(
          (_) async => Response(jsonEncode({'data': []}), 200),
        );

        try {
          await mockUserRemoteDataSourceImpl.getAllUsers(page);

          fail("Should throw an exception");
        } on EmptyException catch (e) {
          expect(e, isException);
        } on GeneralException {
          fail("Should throw an EmptyException");
        } catch (e) {
          fail("Should throw an EmptyException");
        }
      });

      test('Failure - 500', () async {
        when(mockClient.get(getAllUsersUrl)).thenAnswer(
          (_) async => Response('Internal Server Error', 500),
        );

        try {
          await mockUserRemoteDataSourceImpl.getAllUsers(page);

          fail("Should throw an exception");
        } on EmptyException {
          fail("Should throw an GeneralException");
        } on GeneralException catch (e) {
          expect(e, isException);
        } catch (e) {
          fail("Should throw an GeneralException");
        }
      });
    });
  });
}
