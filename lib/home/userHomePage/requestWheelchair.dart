// ignore_for_file: camel_case_types

import 'package:aoun/Widget/Colors.dart';
import 'package:aoun/Widget/Icons.dart';
import 'package:aoun/Widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';

class requestWheelchar extends StatefulWidget {
  requestWheelchar({Key key}) : super(key: key);

  @override
  State<requestWheelchar> createState() => _requestWheelcharState();
}

class _requestWheelcharState extends State<requestWheelchar> {
  @override
  void initState() {
    super.initState();
    showCurrentLocation();
  }

  var contriy, street, name, locality;
  bool show = false;
  String locationAdrress = '';
  List<String> item = ["يدون مساعد", "مساعد"];
  List<String> chair = ["1", "2", "3"];
  TimeOfDay selectedstarTime = TimeOfDay.now();
  TimeOfDay selectedEndTime = TimeOfDay.now();
  // ignore: non_constant_identifier_names
  String format_Star_Time = "";
  // ignore: non_constant_identifier_names
  String format_End_Time = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 60.h,
          ),
          drowText(context, "طلب كرسي متحرك", 18, color: deepGreen),
          Padding(
            padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 40.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Image(image: AssetImage("assets/image/logo.png"),height: 150.h,width: 150.w),
                drowMenu("نوع الطلب", requestType, item),
                SizedBox(height: 10.h),
                drowMenu("عدد الكراسي", chairNumber, chair),
                SizedBox(height: 10.h),
                showStardTime(),
                SizedBox(height: 10.h),
                showReturnTime(),
                SizedBox(height: 10.h),
                showLocation(),
                SizedBox(height: 10.h),
                viewStringLocationAddress(),
                SizedBox(height: 10.h),
                drowButtoms(context, "رفع الطلب", 12, white, () {},
                    backgrounColor: deepGreen),
              ],
            ),
          ),
        ],
      ),
    )));
  }

//drow location continer------------------------------------------------------------
  Widget showLocation() {
    return drowContiner(
        50,
        double.infinity,
        0,
        0,
        gray,
        Row(
          children: [
            Icon(location, size: 26.sp, color: deepGreen),
            SizedBox(
              width: 4,
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  show = !show;
                  _getLocationAddress(latitude, longtitude);
                });
              },
              child: show == false
                  ? drowText(context, "اظهار الموقع الحالي", 12,
                      color: deepGreen)
                  : drowText(context, "اخفاء الموقع الحالي", 12,
                      color: deepGreen),
            ),
          ],
        ),
        bottomLeft: 10,
        bottomRight: 10,
        topLeft: 10,
        topRight: 10,
        pL: 10,
        border: Border.all(color: deepgray),
        pR: 10);
  }

//show location in string address insied continer ------------------------------------------------------------
  Widget viewStringLocationAddress() {
    return Visibility(
      visible: show,
      child: drowContiner(50, double.infinity, 0, 0, gray,
          drowText(context, "$locationAdrress", 12, color: deepGreen),
          bottomLeft: 10,
          bottomRight: 10,
          topLeft: 10,
          topRight: 10,
          pL: 10,
          border: Border.all(color: deepgray),
          pR: 10),
    );
  }

  //get location address-----------------------------------------------------------
  _getLocationAddress(lat, long) async {
    try {
      List<Placemark> placemark = await placemarkFromCoordinates(lat, long);

    setState(() {
      name = placemark[0].subLocality;
      street = placemark[0].thoroughfare;
      contriy = placemark[0].country;
      locality = placemark[0].locality;
      locationAdrress = "$contriy - $locality - ${placemark[0].administrativeArea}";
 
      print(locationAdrress);

      print(locationAdrress);
    });
  
    } catch (e) {
      print(e);
    }
  }

//show receve time------------------------------------------------------------
  Widget showStardTime() {
    return drowContiner(
        50,
        double.infinity,
        0,
        0,
        gray,
        Row(
          children: [
            Icon(starTime, size: 26.sp, color: deepGreen),
            SizedBox(
              width: 4,
            ),
           GestureDetector(
              onTap: () {
                setState(() {
                  _selectStarTime(context);
                });
              },
              child: format_Star_Time.isNotEmpty
                  ? drowText(context, "$format_Star_Time", 12, color: deepGreen)
                  : drowText(context, "زمن الاستلام", 12, color: deepGreen),
            )
          ],
        ),
        bottomLeft: 10,
        bottomRight: 10,
        topLeft: 10,
        topRight: 10,
        pL: 10,
        border: Border.all(color: deepgray),
        pR: 10);
  }

//show receve time------------------------------------------------------------
  Widget showReturnTime() {
    return drowContiner(
        50,
        double.infinity,
        0,
        0,
        gray,
        Row(
          children: [
            Icon(endTime, size: 26.sp, color: deepGreen),
            SizedBox(
              width: 4,
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  _selectEndTime(context);
                });
              },
              child: format_End_Time.isNotEmpty
                  ? drowText(context, "$format_End_Time", 12, color: deepGreen)
                  : drowText(context, "زمن الارجاع", 12, color: deepGreen),
            )
          ],
        ),
        bottomLeft: 10,
        bottomRight: 10,
        topLeft: 10,
        topRight: 10,
        pL: 10,
        border: Border.all(color: deepgray),
        pR: 10);
  }

  // show clock----------------------------------------------------
  Future<TimeOfDay> _selectStarTime(BuildContext context) async {
    final TimeOfDay timeOfDay = await showTimePicker(
      context: context,
      initialTime: selectedstarTime,
      initialEntryMode: TimePickerEntryMode.dial,
    );
    if (timeOfDay != null) {
      setState(() {
        selectedstarTime = timeOfDay;
        format_Star_Time =
            "${selectedstarTime.format(context)} ";
        return format_Star_Time;
      });
    }
    return null;
  }

// show clock----------------------------------------------------
  Future<TimeOfDay> _selectEndTime(BuildContext context) async {
    final TimeOfDay timeOfDay = await showTimePicker(
      context: context,
      initialTime: selectedEndTime,
      initialEntryMode: TimePickerEntryMode.dial,

    );
    if (timeOfDay != null) {
      setState(() {
        selectedEndTime = timeOfDay;
        format_End_Time =
            "${selectedEndTime.format(context)} ";
        return format_End_Time;
      });
    }
    return null;
  }
}