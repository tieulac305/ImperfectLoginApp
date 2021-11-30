// thao tác với user
abstract class UserRepository {
  const UserRepository();

  // email
  String get signedEmail;

  // login dùng username và password
  Future<bool> authenticate(String username, String password);

  // register dùng username và password
  Future<bool> register(String username, String password);

  // đăng xuất
  Future<void> logOut();
}