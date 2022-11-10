import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppLocale {
  final Locale locale;
  AppLocale(this.locale);

  late Map<String, String> _loadedLangValue;

  static AppLocale of(BuildContext context) {
    return Localizations.of<AppLocale>(context, AppLocale)!;
  }

  Future loadLanguage() async {
    String _fileLang =
        await rootBundle.loadString('assets/lang/${locale.languageCode}.json');
    Map<String, dynamic> _loadValue = jsonDecode(_fileLang);

    //Because Map _loadValue is Map<String,dynamic> and we need Map<String,String>
    _loadedLangValue =
        _loadValue.map((key, value) => MapEntry(key, value.toString()));
  }

  String getTranslate(String key) {
    return '${_loadedLangValue[key]}';
  }

  static const LocalizationsDelegate<AppLocale> delegate = _AppLocalDelegate();
}

class _AppLocalDelegate extends LocalizationsDelegate<AppLocale> {
  const _AppLocalDelegate();

  @override
  bool isSupported(Locale locale) {
    return ["en", "ar"].contains(locale.languageCode);
  }

  @override
  Future<AppLocale> load(Locale locale) async {
    AppLocale appLocale = AppLocale(locale);
    await appLocale.loadLanguage();
    return appLocale;
  }

  @override
  bool shouldReload(_AppLocalDelegate old) => false;
}
