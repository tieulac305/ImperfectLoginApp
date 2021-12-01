import 'package:flutter/material.dart';

// để có thể gọi context.localize(), thay vì gọi AppLocalization.of(context)?.localize
// không hiểu sao nhưng extension đưa lên trước
extension LocalizationExt on BuildContext{
  String localize(String value){
    final code = AppLocalization.of(this)?.locale.languageCode ?? 'en';
    final database = AppLocalization._db;

    // nếu mà support
    if(database.containsKey(code)){
      return database[code]?[value] ?? ""; // đã support rồi mà sao không tin nhau
    }
    // mặc định dùng tiếng anh
    else{
      return database['en']?[value] ?? "";
    }
  }
}

/// nhiệm vụ dịch chuỗi theo locale
/// thật ra cái này dịch chuỗi nên nó là internationalize
class AppLocalization{
  final Locale locale;
  const AppLocalization(this.locale);

  // cho phép gọi AppLocalization.of(context)?.locale
  static AppLocalization? of(BuildContext ctx) =>
    Localizations.of<AppLocalization>(ctx, AppLocalization);

  static final Map<String, Map<String, String>> _db = {
    'en': {
      'error': "OOOPPPPSSS!",
      'title': "Perfect Login App",
      'login': "Login",
      'login_fail': "Failed to login.",
      'username': "Username",
      'empty_validate_fail': "Don't let me empty :'(",
      'password': "Password",
      'password_validate_fail': "At least 5 chars, please!",
      'register': "Register",
      'register_fail': "Failed to register.",
      'welcome_text': "Hey you little cute",
      'weak_password': "I can guess your password. Use another, amateur.",
      'email_already_in_use': "Really your email? Someone used it.",
      'user_not_found': "You need to register first~",
      'wrong_password': "WA. Type your password again.",
    },
    'vi': {
      'error': "Ôi khônggg!",
      'title': "Đăng nhập siêu cấp",
      'login': "Đăng nhập",
      'login_fail': "Đăng nhập thất bại.",
      'username': "Tên đăng nhập",
      'empty_validate_fail': "Không được bỏ trốnggg",
      'password': "Mật khẩu",
      'password_validate_fail': "Cần nhiều hơn 5 kí tự!",
      'register': "Đăng kí",
      'register_fail': "Đăng kí thất bại.",
      'welcome_text': "Xin chào bạn cute",
      'weak_password': "Mật khẩu yếu quá, cố lên!",
      'email_already_in_use': "Email đã có tài khoản.",
      'user_not_found': "Email chưa đăng kí.",
      'wrong_password': "Sai mật khẩu. Thử lại xem :3",
    },
  };
}