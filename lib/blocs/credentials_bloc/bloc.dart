import 'dart:async';
import 'dart:html';

import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:perfect_login_app/blocs/authentication_bloc/bloc.dart';
import 'package:perfect_login_app/blocs/authentication_bloc/events.dart';
import 'package:perfect_login_app/repository/user_repository.dart';
import 'events.dart';
import 'states.dart';

class CredentialsBloc extends Bloc<CredentialsEvent, CredentialsState>{
  final UserRepository userRepository;
  final AuthenticationBloc authenticationBloc;

  CredentialsBloc({
    required this.authenticationBloc,
    required this.userRepository
  }) : super(const CredentialsInitial()){
    on<LoginButtonPressed>(_onLoginPressed);
    on<RegisterButtonPressed>(_onRegisterPressed);
  }

  // nó tự sinh nên trông hơi dài
  void _onLoginPressed(LoginButtonPressed event, Emitter<CredentialsState> emit) async {
    // cho thấy bắt đầu chờ
    emit(const CredentialsLoginLoading());
    try{
      // chờ đăng nhập
      await userRepository.authenticate(event.username, event.password);
      // thêm event đăng nhập vào rồi
      authenticationBloc.add(const LoggedIn());

      emit(const CredentialsInitial());
    } on PlatformException { // firebase sẽ trả ra exception này
      emit(const CredentialsLoginFailure());
    }
  }

  void _onRegisterPressed(RegisterButtonPressed event, Emitter<CredentialsState> emit) async {
    emit(const CredentialsRegisterLoading());
    try{
      // chờ đăng kí
      await userRepository.register(event.username, event.password);
      // xong thì đăng nhập vào luôn
      authenticationBloc.add(const LoggedIn());

      emit(const CredentialsInitial());
    } on PlatformException{
      emit(const CredentialsRegisterFailure());
    }
  }
}