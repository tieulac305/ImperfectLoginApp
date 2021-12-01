import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:perfect_login_app/blocs/authentication_bloc/bloc.dart';
import 'package:perfect_login_app/localization/app_localizations.dart';
import 'package:perfect_login_app/localization/localization_delegate.dart';
import 'package:perfect_login_app/repository/user_repository/firebase_repository.dart';
import 'package:perfect_login_app/routes.dart';
import 'package:provider/provider.dart';

// cache UserRepository bằng provider? phòng khi muốn đổi authentication
void main(){
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    // khi cần chờ nhiều thứ, thì nên thêm 1 file tách đống cần chờ ra
    // gọi là startupFuture rồi cho tất vào future
    FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          // cái này có thể chia làm màn hình error
          // mà nó cần mọe cả material app luôn, có ổn k nhỉ...
          return MaterialApp(
            home: Scaffold(
              body: Center(
                child: Text(context.localize('error')),
              ),
            ),
          );
        }

        if (snapshot.connectionState == ConnectionState.done) {
          return Provider<FirebaseUserRepository>(
            create: (_) => const FirebaseUserRepository(),
            child: const LoginApp(),
          );
        }

        return const MaterialApp(
          home: Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        );
      }
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
      child: const MaterialApp(
        initialRoute: RouteGenerator.homePage,
        onGenerateRoute: RouteGenerator.generateRoute,  
        localizationsDelegates: [
          AppLocalizationDelegate(),
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          Locale.fromSubtags(languageCode:"en"),
          Locale.fromSubtags(languageCode:"vi"),
        ],
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}