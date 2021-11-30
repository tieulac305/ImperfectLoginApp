import 'package:equatable/equatable.dart';

/// event cho credentialsbloc
abstract class CredentialsEvent extends Equatable{
  final String username;
  final String password;

  /// các event xảy ra khi bấm nút và lấy thông tin từ form
  const CredentialsEvent(this.username, this.password);

  @override
  List<Object?> get props => [username, password];
}

/// khi bấm vào nút login
class LoginButtonPressed extends CredentialsEvent{
  const LoginButtonPressed(String username, String password) : super(username, password);
}

///khi bấm vào nút đăng kí
class RegisterButtonPressed extends CredentialsEvent{
  const RegisterButtonPressed(String username, String password) : super(username, password);
}