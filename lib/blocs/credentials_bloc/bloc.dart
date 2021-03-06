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
      bool auth = await userRepository.authenticate(event.username, event.password);

      if(auth){
        // thêm event đăng nhập vào rồi
        authenticationBloc.add(const LoggedIn());
        emit(const CredentialsInitial());
      }
      else{
        emit(const CredentialsLoginFailure());
      }
    } on PlatformException { // firebase sẽ trả ra exception này // lừa đảo
      emit(const CredentialsLoginFailure());
    }
  }

  void _onRegisterPressed(RegisterButtonPressed event, Emitter<CredentialsState> emit) async {
    emit(const CredentialsRegisterLoading());
    try{
      // chờ đăng kí
      bool success = await userRepository.register(event.username, event.password);

      if(success){
        // xong thì đăng nhập vào luôn
        authenticationBloc.add(const LoggedIn());
        // còn khs lại emit cái này luôn, rồi ai nghe .-.
        emit(const CredentialsInitial());
      }
      else{
        emit(const CredentialsRegisterFailure());
      }
    } on PlatformException{
      emit(const CredentialsRegisterFailure());
    }
  }
}