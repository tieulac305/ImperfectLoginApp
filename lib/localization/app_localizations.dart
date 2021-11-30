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
      'title': "Perfect Login App",
      'login': "Login",
      'username': "Username",
      'password': "Password",
      'register': "Register",
      'welcome_text': "Hey you little cute",
    },
    'vi': {
      'title': "Đăng nhập siêu cấp",
      'login': "Đăng nhập",
      'username': "Tên đăng nhập",
      'password': "Mật khẩu",
      'register': "Đăng kí",
      'welcome_text': "Xin chào bạn cute",
    },
  };
}