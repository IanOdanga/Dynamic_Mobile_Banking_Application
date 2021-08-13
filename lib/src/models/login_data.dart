import 'package:quiver/core.dart';

class LoginData {
  final String password;

  LoginData({
    required this.password,
  });

  @override
  String toString() {
    return '$runtimeType( $password)';
  }

  @override
  bool operator ==(Object other) {
    if (other is LoginData) {
      return password == other.password;
    }
    return false;
  }
}
