import 'package:equatable/equatable.dart';

// class cho các event của authentication bloc
abstract class AuthenticationEvent extends Equatable{
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

// khi log in thành công
class LoggedIn extends AuthenticationEvent{
  const LoggedIn();
}

// khi muốn log out
class LoggedOut extends AuthenticationEvent{
  const LoggedOut();
}