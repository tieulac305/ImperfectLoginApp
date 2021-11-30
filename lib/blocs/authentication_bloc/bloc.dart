import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:perfect_login_app/repository/user_repository.dart';

import 'events.dart';
import 'states.dart';

/// business logic cho việc authentication
class AuthenticationBloc 
  extends Bloc<AuthenticationEvent, AuthenticationState> {
  // business lấy repo ra dùng
  final UserRepository userRepository;

  AuthenticationBloc(this.userRepository) : super(const AuthenticationInit()){
    on<LoggedIn>(_onLoggedIn);
    on<LoggedOut>(_onLoggedOut);
  }

  void _onLoggedIn(event, emit) => emit(const AuthenticationSuccess());
  void _onLoggedOut(event, emit) async{
    emit(const AuthenticationSuccess());
    await userRepository.logOut();
    emit(const AuthenticationRevoked());
  }

  // no more mapEventToState
  // Stream<AuthenticationState> mapEventToState(AuthenticationEvent e) async*{
  //   if(e is LoggedIn){
  //     yield const AuthenticationSuccess();
  //   }
  //   if(e is LoggedOut){
  //     yield const AuthenticationLoading();
  //     await userRepository.logOut();
  //     yield const AuthenticationRevoked();
  //   }
  // }
}