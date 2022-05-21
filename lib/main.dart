import 'package:aoun/UserAccount/LoggingPage.dart';
import 'package:aoun/UserAccount/SingUpPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'TransilatClass/getTranselaitData.dart';
import 'TransilatClass/setLocale.dart';
import 'Welcom page/frontend.dart';
import 'package:firebase_core/firebase_core.dart';

import 'home/AdmainHom/AdminHomeNagiation.dart';
import 'home/Worker/workerHomNav.dart';
import 'home/userHomePage/userHomePage.dart';

// void main() => runApp(
//       DevicePreview(
//         enabled: true,
//         builder: (context) => MyApp(), // Wrap your app
//       ),
//     );
void main()async {
  runApp(MyApp());
    WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
}
class MyApp extends StatefulWidget {
  static void setLocale(BuildContext context, Locale locale) {
    _MyAppState state = context.findAncestorStateOfType<_MyAppState>();
    state.setLocal(locale);
  }

  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool selectLang = true;
  Locale _local;
  //تحديد لغة التطبيق وفق للغه المختارة------------------------
  void setLocal(Locale local) {
    setState(() {
      _local = local;
      if (_local.toString().compareTo("ar_SA") == 0) {
        selectLang = true;
      } else if (_local.toString().compareTo("en_US") == 0) {
        selectLang = false;
      } else if (_local == null) {
        selectLang = false;
      }
      print(selectLang);
    });
  }

//_local seved in it seleted language
  @override
  void didChangeDependencies() {
    getLocale().then((locale) {
      setState(() {
        this._local = locale;
      });
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      //screen size
      designSize: const Size(360, 640),
      builder: () => MaterialApp(
        title: "Aoun",
//اختيار نوع الخط وفقا للغه المختارة-------------------------
        theme: ThemeData(
          fontFamily: selectLang ? "Cairo" : "OpenSans",
          primarySwatch: Colors.green,
        ),

//locale  هو كود اللغه المختارة اما ar-SA or en-US
        locale: _local,
        supportedLocales: [
          Locale('en', 'US'),
          Locale('ar', 'SA'),
        ],

//تغير اتجاهات العناصر في الشاشه حسب اللغة--------------
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          SetLocalization.localizationsDelegate
        ],
// التاكد من ان اللغه المختارة مدعومة في الجهاز
        localeResolutionCallback: (deviceLocal, supportedLocales) {
          for (var local in supportedLocales) {
            if (local.languageCode == deviceLocal.languageCode &&
                local.countryCode == deviceLocal.countryCode) {
              return deviceLocal;
            }
          }
          return supportedLocales.first;
        },
        debugShowCheckedModeBanner: false,
        //اظهار الشاشه الولي وفقا لحاله المستخدم, هل قام بالتسجيل مسلقا ام اول مره يظهر التطبيق
        home:
         _local == null ?
          WelcomePage()
          :
WelcomePage(),
      ),
    );
  }
}