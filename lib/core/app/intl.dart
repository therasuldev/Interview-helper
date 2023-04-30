import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const languages = ['ru', 'en'];

class Intl {
  late Locale locale;

  @visibleForTesting
  Map<String, String>? localizedValues;

  List<String>? supportedLocales;

  IntlDelegate get delegate => const IntlDelegate();

  Intl? of(BuildContext context) => Localizations.of<Intl>(context, Intl);

  String fmt(String key, [List<dynamic>? args]) {
    if (args == null || args.isEmpty) {
      return localizedValues?[key] ?? key;
    }

    int idx;
    String formatted = localizedValues![key]!.replaceAllMapped(
        RegExp(r'\%[0-9]{1,3}', multiLine: true), (Match match) {
      idx = int.parse(match[0]!.substring(1)) - 1;

      return (args.asMap()[idx] ?? match[0]).toString();
    });

    return formatted;
  }

  Future<Map<String, dynamic>> load() async {
    final jsonString =
        await rootBundle.loadString('assets/i18n/${locale.languageCode}.json');
    Map<String, dynamic> jsonMap = json.decode(jsonString);

    localizedValues = jsonMap.map(
      (key, value) => MapEntry(key, value.toString()),
    );
    return localizedValues!;
  }
}

@immutable
@visibleForTesting
class IntlDelegate extends LocalizationsDelegate<Intl> {
  const IntlDelegate();

  @override
  bool isSupported(Locale locale) => languages.contains(locale.languageCode);

  @override
  Future<Intl> load(Locale locale) async {
    final Intl intl = Intl();
    intl.locale = locale;
    await intl.load();
    return intl;
  }

  @override
  bool shouldReload(IntlDelegate old) => false;
}





// class GameRepository extends IRiddlesRepository {
//   final CacheRepository _cahceRepo;
//   final String _path;
//   GameRepository({
//     required CacheRepository cahceRepo,
//     required String path,
//   })  : _cahceRepo = cahceRepo,
//         _path = path;

//   @override
//   Future<List<Map<String, dynamic>>> getRiddles(String category) async {
//     return await _cahceRepo.getGameRiddlesFromCache(category);
//   }

//   @override
//   Future<List<Map<String, dynamic>>> loadRiddles(String category) async {
//     List<Map<String, dynamic>> riddles = [];

//     var jsonStr = await rootBundle.loadString('$_path/$category.json');
//     Map<String, dynamic> jsonMap = await json.decode(jsonStr);

//     for (var i = 1; i <= jsonMap.length; i++) {
//       riddles.add(jsonMap['$i']);
//     }

//     _cahceRepo.putGameRiddlesToCache(category, riddles);

//     return await getRiddles(category);
//   }
// }