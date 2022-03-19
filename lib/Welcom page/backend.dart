import 'package:aoun/TransilatClass/getTranselaitData.dart';
import 'package:aoun/TransilatClass/language.dart';
import 'package:aoun/UserAccount/SingUpPage.dart';
import 'package:aoun/Widget/widget.dart';

import 'package:flutter/material.dart';

import '../main.dart';

void newLang(Language lang, BuildContext context) async {
  Locale _temp = await setLocale(context, lang.languageCode);
  goTopagepush(context, SingUpPage());
  MyApp.setLocale(context, _temp);
}
