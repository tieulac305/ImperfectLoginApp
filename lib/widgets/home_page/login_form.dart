import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:perfect_login_app/blocs/credentials_bloc.dart';
import 'package:perfect_login_app/blocs/credentials_bloc/bloc.dart';
import 'package:perfect_login_app/localization/app_localizations.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // đúng vậy, responsive
    return LayoutBuilder(
      builder: (context, data){
        double baseWidth = 250;
        // nếu màn hình lớn hơn, kiểu tablet
        if(data.maxWidth >= baseWidth){
          baseWidth = data.maxWidth / 1.4;
        }

        return BlocConsumer<CredentialsBloc, CredentialsState>(
          listener: (context, state){
            if(state is CredentialsLoginFailure){
              Flushbar(
                backgroundColor: Colors.red,
                message: context.localize('login_fail'),
                duration: const Duration(seconds: 5),
              ).show(context);
            }
            if(state is CredentialsRegisterFailure){
              Flushbar(
                backgroundColor: Colors.red,
                message: context.localize('register_fail'),
                duration: const Duration(seconds: 5),
              ).show(context);
            }
          },
          builder: (context, state){
            if(state is CredentialsLoginLoading || state is CredentialsRegisterLoading){
              return const Center (child: CircularProgressIndicator());
            }

            // form và các nút luôn, đến đây mình thực sự k thích cách tải của sách
            // nên quyết định dùng cách tải toàn bộ như này
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Padding(padding: EdgeInsets.all(40)),
                Image.asset('assets/images/splash.png',
                  width: baseWidth,
                ),
                const Padding(padding: EdgeInsets.all(20)),
                Form(
                  key: _formKey,
                  child: Wrap(
                    children: [
                      SizedBox(
                        width: baseWidth - 30,
                        child: TextFormField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            icon: const Icon(Icons.mail,
                              color: Color(0xFFFFBBBB),
                            ),
                            hintText: context.localize('username'),
                          ),
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return context.localize('empty_validate_fail');
                            }
                            return null;
                          },
                        )
                      ),
                      SizedBox(
                        width: baseWidth - 30,
                        child: TextFormField(
                          controller: _passwordController,
                          decoration: InputDecoration(
                            icon: const Icon(Icons.vpn_key,
                              color: Color(0xFFFFBBBB),
                            ),
                            hintText: context.localize('password'),
                          ),
                          validator: (String? value) {
                            if (value == null || value.length < 5) {
                              return context.localize('password_validate_fail');
                            }
                            return null;
                          },
                        )
                      ),
                    ],
                  ),
                ),
                const Padding(padding: EdgeInsets.all(10)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      child: Text(context.localize("register")),
                      onPressed: (){
                        final state = _formKey.currentState;
                        if(state?.validate() ?? false){
                          _registerButtonPressed(context);
                        }
                      },
                    ),
                    ElevatedButton(
                      child: Text(context.localize("login")),
                      onPressed: (){
                        final state = _formKey.currentState;
                        if(state?.validate() ?? false){
                          _loginButtonPressed(context);
                        }
                      },
                    ),
                  ],
                )
              ],
            );
          },
        );
      },
    );
  }

  void _loginButtonPressed(BuildContext context) {
    BlocProvider.of<CredentialsBloc>(context).add(
      LoginButtonPressed(_emailController.text, _passwordController.text)
    );
  }
  void _registerButtonPressed(BuildContext context) {
    BlocProvider.of<CredentialsBloc>(context).add(
      RegisterButtonPressed(_emailController.text, _passwordController.text)
    );
  }
}