import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:perfect_login_app/blocs/authentication_bloc/bloc.dart';
import 'package:perfect_login_app/localization/app_localizations.dart';
import 'package:perfect_login_app/localization/localization_delegate.dart';
import 'package:perfect_login_app/repository/user_repository.dart';
import 'package:perfect_login_app/repository/user_repository/firebase_repository.dart';
import 'package:perfect_login_app/routes.dart';
import 'package:provider/provider.dart';

// cache UserRepository bằng provider? phòng khi muốn đổi authentication
void main() {
  runApp(
    Provider<UserRepository>(
      create: (_) => const FirebaseUserRepository(),
      child: const LoginApp(),
    )
  );
}

class LoginApp extends StatelessWidget {
  const LoginApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final repository = context.select((FirebaseUserRepository r) => r);

    return BlocProvider<AuthenticationBloc>(
      create: (_) => AuthenticationBloc(repository),
      child: MaterialApp(
        initialRoute: RouteGenerator.homePage,
        onGenerateRoute: RouteGenerator.generateRoute,  
        localizationsDelegates: const [
          AppLocalizationDelegate(),
        ],
        supportedLocales: const [
          Locale.fromSubtags(languageCode:"en"),
          Locale.fromSubtags(languageCode:"vi"),
        ],
        onGenerateTitle: (context) => context.localize("title"),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}