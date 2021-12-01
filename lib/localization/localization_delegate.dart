import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'app_localizations.dart';

class AppLocalizationDelegate extends LocalizationsDelegate<AppLocalization> {
  const AppLocalizationDelegate();

  @override
  bool isSupported(Locale locale) =>
    ["en", "vi"].contains(locale.languageCode);

  // tạo ra và thực hiện luôn, bình thường không nên dùng SynchronousFuture
  @override
  Future<AppLocalization> load(Locale locale) =>
    SynchronousFuture<AppLocalization>(
      AppLocalization(locale)
    );

  // hầu hết là không cần reload nên cứ để false
  @override
  bool shouldReload(covariant LocalizationsDelegate<AppLocalization> old) => false;
}