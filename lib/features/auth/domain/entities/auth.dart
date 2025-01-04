import 'package:equatable/equatable.dart';

class Auth extends Equatable {
  final String id;
  final String accessToken;
  final String email;
  final String name;

  const Auth({
    required this.id,
    required this.accessToken,
    required this.email,
    required this.name,
  });

  @override
  List<Object?> get props => [
        id,
        accessToken,
        email,
        name,
      ];
}
