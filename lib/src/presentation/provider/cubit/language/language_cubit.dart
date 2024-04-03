import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:interview_helper/src/data/datasources/local/application_lang.dart';

class LanguageCubit extends Cubit<Locale> {
  LanguageCubit() : super(const Locale('en', ''));

  final prefs = ApplicationLangImpl();

  void setLanguage(String languageCode, BuildContext context) async {
    final locale = Locale(languageCode, '');
    context.setLocale(Locale(languageCode, ''));
    emit(locale);

    await prefs.setAppLang(languageCode);
  }

  Future<void> loadLanguage() async {
    final languageCode = await prefs.getAppLang();
    emit(Locale(languageCode, ''));
  }
}
