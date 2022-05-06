import 'package:aoun/TransilatClass/language.dart';
import 'package:aoun/UserAccount/LoggingPage.dart';
import 'package:aoun/Welcom%20page/backend.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:location/location.dart';

import 'package:aoun/Widget/Colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../UserAccount/SingUpPage.dart';
import 'Icons.dart';

var latitude, longtitude;
var error;
Widget drowText(
  context,
  String text,
  double fontSize, {
  family = "Cairo",
  Color color = Colors.white,
  align,
  double space = 0,
  FontWeight fontWeight = FontWeight.normal,
}) {
  return Text(
    text,
    style: TextStyle(
      color: color,
      fontFamily: family,
      fontSize: fontSize.sp,
      letterSpacing: space.sp,
      fontWeight: fontWeight,
    ),
  );
}

//===============================drow continer===============================
Widget drowContiner(double height, double width, double marginL, double marginR,
    Color color, Widget child,
    {double blur = 0.0,
    Offset offset = Offset.zero,
    double spShadow = 0.0,
    double pL = 0.0,
    double pR = 0.0,
    double pT = 0.0,
    double pB = 0.0,
    double marginT = 0.0,
    double marginB = 0.0,
    double bottomLeft = 0.0,
    double topRight = 0.0,
    double topLeft = 0.0,
    BoxBorder border,
    double bottomRight = 0.0}) {
  return Container(
    padding: EdgeInsets.only(left: pL.w, right: pR.w, top: pT.h, bottom: pB.h),
    width: width.w,
    height: height.h,
    margin: EdgeInsets.only(
        left: marginL.w, right: marginR.w, top: marginT.h, bottom: marginB.h),
    decoration: BoxDecoration(
        border: border,
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(bottomLeft),
            topRight: Radius.circular(topRight),
            topLeft: Radius.circular(topLeft),
            bottomRight: Radius.circular(bottomRight)),
        color: color,
        boxShadow: [
          BoxShadow(blurRadius: blur, offset: offset, spreadRadius: spShadow)
        ]),
    child: child,
  );
}

//===============================drow continer with image===============================
Widget drowContinerImage(double height, double width, String image,
    double marginL, double marginR, Color color, Widget child,
    {double blur = 0.0,
    Offset offset = Offset.zero,
    double spShadow = 0.0,
    double pL = 0.0,
    double pR = 0.0,
    double pT = 0.0,
    double pB = 0.0,
    double marginT = 0.0,
    double marginB = 0.0,
    double bottomLeft = 0.0,
    double topRight = 0.0,
    double topLeft = 0.0,
    fit,
    fillterColor,
    double bottomRight = 0.0}) {
  return Container(
    padding: EdgeInsets.only(left: pL.w, right: pR.w, top: pT.h, bottom: pB.h),
    width: width.w,
    height: height.h,
    margin: EdgeInsets.only(
        left: marginL.w, right: marginR.w, top: marginT.h, bottom: marginB.h),
    decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage(image),
            fit: fit,
            colorFilter: ColorFilter.mode(fillterColor, BlendMode.darken)),
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(bottomLeft),
            topRight: Radius.circular(topRight),
            topLeft: Radius.circular(topLeft),
            bottomRight: Radius.circular(bottomRight)),
        color: color,
        boxShadow: [
          BoxShadow(blurRadius: blur, offset: offset, spreadRadius: spShadow)
        ]),
    child: child,
  );
}

//=================================Drow Buttoms=============================
Widget drowButtoms(
    context, String key, double fontSize, Color textColor, onPressed,
    {Color backgrounColor = Colors.transparent,
    double horizontal = 0.0,
    double vertical = 0.0,
    double width,
    double evaluation = 0.0}) {
  return SizedBox(
    height: 45.h,
    width: width,
    child: TextButton(
      onPressed: onPressed,
      child: drowText(context, key, fontSize, color: textColor),
      style: ButtonStyle(
        elevation: MaterialStateProperty.all(evaluation),
        backgroundColor: MaterialStateProperty.all(backgrounColor),
        foregroundColor: MaterialStateProperty.all(textColor),
        padding: MaterialStateProperty.all(EdgeInsets.symmetric(
            horizontal: horizontal.w, vertical: vertical.h)),
      ),
    ),
  );
}

//===============================Go To page(push)===============================
goTopagepush(context, pageName) {
  return Navigator.push(context, MaterialPageRoute(builder: (_) => pageName));
}

//===============================Go To page(pushReplacement)===============================
goTopageReplacement(context, pageName) {
  return Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (_) => pageName));
}

//get heghit and width===============================================================
Size getSize(context) {
  return MediaQuery.of(context).size;
}

//=============================Drow TextFields=================================
Widget drowTextField(
    context,
    icons,
    String key,
    //double fontSize,
    bool hintPass,
    TextEditingController mycontroller,
    myvali,
    {Widget suffixIcon,
    int max = 1,
    int min = 1,
    inputFormatters,
    keyboardType,
    void Function() onTap}) {
  return TextFormField(
    autofocus: false,
    obscureText: hintPass,
    validator: myvali,
    minLines: min,
    maxLines: max,
    onTap: onTap,
    controller: mycontroller,
    inputFormatters: inputFormatters,
    keyboardType: keyboardType,
    autovalidateMode: AutovalidateMode.onUserInteraction,
    style: TextStyle(color: deepGreen, fontSize: 12.sp),
    decoration: InputDecoration(
        isDense: true,
        filled: true,
        suffixIcon: suffixIcon,
        hintStyle: TextStyle(color: deepGreen, fontSize: 12.sp),
        fillColor: gray,
        labelStyle: TextStyle(color: deepGreen, fontSize: 12.sp),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.r)),
        prefixIcon: Icon(icons, color: deepGreen, size: 25.sp),
        hintText: key,
        contentPadding: EdgeInsets.all(10.h)),
  );
}

//===========================DropMenu Buttom==============================
Widget langButtom(context, {IconData icon}) {
  return DropdownButton(
      elevation: 20,
      underline: SizedBox(),
      dropdownColor: gray,
      iconSize: 20.sp,
      icon: Icon(icon, color: white),
      items: Language.languageList()
          .map<DropdownMenuItem<Language>>((lang) => DropdownMenuItem(
                value: lang,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[Text(lang.name)],
                ),
              ))
          .toList(),
      onChanged: (Language lang) {
        newLang(lang, context);
      });
}

// combo box============================================================abstract
Widget drowMenu(
    String insiValue, IconData icon, List<String> item, onchanged, validator,
    {double width = double.infinity}) {
  return Container(
    color: gray,
    width: width,
    child: DropdownButtonFormField<String>(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: validator,
        hint: Text(
          "$insiValue",
          style: TextStyle(
            color: deepGreen,
            fontSize: 12.sp,
          ),
        ),
        dropdownColor: white,
        items: item
            .map((type) => DropdownMenuItem(
                  //  alignment: Alignment.center,
                  value: type,
                  child: Text(
                    type,
                    style: TextStyle(
                      color: deepGreen,
                      fontSize: 13.sp,
                    ),
                  ),
                ))
            .toList(),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(8.0),
          prefixIcon: Icon(icon, color: deepGreen, size: 25),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        onChanged: onchanged),
  );
}

//get Location method------------------------------------------------------------------------------------
showCurrentLocation() async {
  dynamic currentLocation = LocationData;

  Location location = new Location();

  try {
    currentLocation = await location.getLocation();

    latitude = currentLocation.latitude;
    longtitude = currentLocation.longitude;
    print("latitude is------------------------$latitude");
    print("longtitude is------------------------$longtitude");
  } on PlatformException catch (e) {
    if (e.code == 'PERMISSION_DENIED') {
      error = 'Permission denied';
    }
    currentLocation = null;
  }
}

//container decoration-------------------------------------------
decoration(
  double bottomLeft,
  double bottomRight,
  double topLeft,
  double topRight, {
  Color color = Colors.white,
  double blurRadius = 0.0,
  double spreadRadius = 0.0,
  BoxBorder border,
}) {
  return BoxDecoration(
    color: color,
    border: border,
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(topLeft.r),
      topRight: Radius.circular(topRight.r),
      bottomLeft: Radius.circular(bottomLeft.r),
      bottomRight: Radius.circular(bottomRight.r),
    ),
    boxShadow: [
      BoxShadow(
        blurRadius: blurRadius,
        spreadRadius: spreadRadius,
      )
    ],
  );
}

int unique() {
  return DateTime.now().millisecondsSinceEpoch.remainder(1000000);
}

//get data from database--------------------------------------
Widget getData(context, text, icon) {
  return Expanded(
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.0.w),
      child: Row(children: [
        Icon(
          icon,
          color: deepGreen,
        ),
        SizedBox(width: 10.w),
        drowText(context, text, 12.3, fontWeight: FontWeight.bold, color: black)
      ]),
    ),
  );
}

drawer(context) {
  return Drawer(
    backgroundColor: deepGreen,
    child: Column(children: [
      SizedBox(height: 30.h),
      Center(
        child: drowText(context, "الاعدادات", 17, color: white),
      ),
      SizedBox(height: 15.h),
      ListTile(
        leading: Icon(Icons.logout_rounded, color: white),
        title: drowText(context, "تسجيل الخروج", 17, color: white),
        onTap: () async {
          await FirebaseAuth.instance.signOut();
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => LoggingPage() ));
        },
      ),
    ]),
  );
}
