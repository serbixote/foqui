import 'dart:convert';

import 'package:easy_localization/easy_localization.dart' as ez;
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

const foquiLocales = <Locale>[
  Locale('en'),
  Locale('es'),
  Locale('de'),
  Locale('pt'),
  Locale('fr'),
];

const monthKeys = <String>[
  'month_jan',
  'month_feb',
  'month_mar',
  'month_apr',
  'month_may',
  'month_jun',
  'month_jul',
  'month_aug',
  'month_sep',
  'month_oct',
  'month_nov',
  'month_dec',
];

const weekdayKeys = <String>[
  'weekday_mon',
  'weekday_tue',
  'weekday_wed',
  'weekday_thu',
  'weekday_fri',
  'weekday_sat',
  'weekday_sun',
];

Map<String, String>? _english;

/// Catalogs already read from disk. Serving them from memory lets the first
/// frame resolve strings without another asset round trip.
final translationCache = <String, Map<String, dynamic>>{};

/// Loads every catalog. The English one also covers tests that never mount
/// [ez.EasyLocalization].
Future<void> loadEnglishCatalog() async {
  for (final locale in foquiLocales) {
    final code = locale.languageCode;
    if (translationCache.containsKey(code)) continue;
    final raw = await rootBundle.loadString('assets/translations/$code.json');
    translationCache[code] = jsonDecode(raw) as Map<String, dynamic>;
  }
  _english = {
    for (final entry in translationCache['en']!.entries)
      entry.key: entry.value as String,
  };
}

class FoquiAssetLoader extends ez.AssetLoader {
  const FoquiAssetLoader();

  @override
  Future<Map<String, dynamic>?> load(String path, Locale locale) async {
    final cached = translationCache[locale.languageCode];
    if (cached != null) return cached;
    final raw = await rootBundle.loadString(
      '$path/${locale.languageCode}.json',
    );
    final decoded = jsonDecode(raw) as Map<String, dynamic>;
    translationCache[locale.languageCode] = decoded;
    return decoded;
  }
}

/// Looks up [key] with easy_localization, then the English catalog.
String tr(String key, {List<String>? args, Map<String, String>? namedArgs}) {
  if (ez.trExists(key)) {
    return ez.tr(key, args: args, namedArgs: namedArgs);
  }
  return _fill(_english?[key] ?? key, args, namedArgs);
}

String monthShort(int month) => tr(monthKeys[month - 1]);

String weekdayShort(int weekday) => tr(weekdayKeys[weekday - 1]);

String counted(int count, {required String one, required String many}) {
  if (count == 1) return tr(one);
  return tr(many, args: ['$count']);
}

String _fill(
  String template,
  List<String>? args,
  Map<String, String>? namedArgs,
) {
  var result = template;
  if (namedArgs != null) {
    for (final entry in namedArgs.entries) {
      result = result.replaceAll('{${entry.key}}', entry.value);
    }
  }
  if (args != null) {
    for (final arg in args) {
      result = result.replaceFirst('{}', arg);
    }
  }
  return result;
}
