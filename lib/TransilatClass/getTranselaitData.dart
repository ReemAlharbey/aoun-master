import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'setLocale.dart';

String translatedData(BuildContext context, String key) {
  return SetLocalization.of(context).getTranslateValue(key);
}

const String ENGLISH = 'en';
const String ARABIC = 'ar';
const String LANG_CODE = 'LANG_CODE';

// save selected languge
Future<Locale> setLocale(context,String languageCode) async {
  
  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.setString(LANG_CODE, languageCode);
  return locale(languageCode);


}

//get selected lang and seve it in _temp 
Locale locale(String langCode) {
  Locale _temp;
  switch (langCode) {
    case ENGLISH:
      {
        _temp = Locale(langCode, 'US');
      }
      break;
    case ARABIC:
      {
        _temp = Locale(langCode, 'SA');
      }
      break;
    default:
      _temp = Locale(ARABIC, 'SA');
      break;
  }
  return _temp;
}




 Future<Locale> getLocale() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  String languageCode=preferences.getString(LANG_CODE) ?? ARABIC;
  return locale(languageCode);

}