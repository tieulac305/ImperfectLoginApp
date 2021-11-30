import 'package:equatable/equatable.dart';
/// state emit bởi AuthenticationBloc
abstract class AuthenticationState extends Equatable{
  /// Lớp base cho các state emit bởi AuthenticationBloc
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

// vừa mở app, cần login hoặc regis
class AuthenticationInit extends AuthenticationState{
  const AuthenticationInit();
}

// login ok
class AuthenticationSuccess extends AuthenticationState{
  const AuthenticationSuccess();
}

// log out
class AuthenticationRevoked extends AuthenticationState{
  const AuthenticationRevoked();
}

// đang chờ 
class AuthenticationLoading extends AuthenticationState{
  const AuthenticationLoading();
}