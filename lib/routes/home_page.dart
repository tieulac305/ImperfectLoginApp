import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:perfect_login_app/blocs/authentication_bloc.dart';
import 'package:perfect_login_app/blocs/credentials_bloc/bloc.dart';
import 'package:perfect_login_app/localization/app_localizations.dart';
import 'package:perfect_login_app/repository/user_repository/firebase_repository.dart';

import '../widgets/home_page/login_form.dart';

// mình sẽ dùng tabbarview như trong sách....
// chứ mình không ủng hộ lắm .-.
/// trang chủ duy nhất
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  late final TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        // khi đăng nhập thành công
        if(state is AuthenticationSuccess){
          loginTransition();
        }

        // khi đăng xuất
        if(state is AuthenticationRevoked){
          logoutTransition();
        }

        return TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          controller: tabController,
          children: const [
            _LoginPage(),
            _WelcomePage()
          ],
        );
      }
    );
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  /// trượt tới trang welcome
  void loginTransition(){
    if(tabController.index != 1){
      tabController.animateTo(1);
    }
  }

  /// trượt về trang login
  void logoutTransition(){
    if(tabController.index != 0){
      tabController.animateTo(0);
    }
  }
}

// lớp khá nhỏ nên viết tại đây luôn, trong sách nói v
// nếu widget có thể sử dụng ại thì tách ra và dùng const constructor
// nếu chỉ là 1 phần của riêng nó thì tách ra làm private class và const constructor
// khi dài quá thì nên tách ra
class _LoginPage extends StatelessWidget {
  const _LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final repository = context.select((FirebaseUserRepository r) => r);
    final authBloc = BlocProvider.of<AuthenticationBloc>(context);
    // version mới nhưng k thấy có extension này
    // final authBloc = context.bloc<AuthenticationBloc>();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/background.png'),
                fit: BoxFit.cover
              ),
            ),
          ),
          Center(
            child: BlocProvider(
              child: const LoginForm(),
              create:(context) => CredentialsBloc(
                authenticationBloc: authBloc,
                userRepository: repository
              ),
            ),
          ),
        ],
      ),

    );
  }
}

class _WelcomePage extends StatelessWidget {
  const _WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(context.localize('title')),
        actions: [
          IconButton(
            onPressed: () 
                => BlocProvider.of<AuthenticationBloc>(context).add(const LoggedOut()),
            icon: const Icon(Icons.exit_to_app)
          )
        ],
      ),
      body: Center(
        child: Text(context.localize('welcome_text')),
      ),
    );
  }
}