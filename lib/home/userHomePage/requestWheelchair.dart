// ignore_for_file: camel_case_types

import 'package:aoun/Widget/Colors.dart';
import 'package:aoun/Widget/Icons.dart';
import 'package:aoun/Widget/widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';

import '../../TransilatClass/getTranselaitData.dart';
import '../../Widget/AwesomDialog.dart';

class requestWheelchar extends StatefulWidget {
  requestWheelchar({Key key}) : super(key: key);

  @override
  State<requestWheelchar> createState() => _requestWheelcharState();
}

class _requestWheelcharState extends State<requestWheelchar> {
  var userId;
  String userPhone = '';
  String username_ = '';
  int dbChairNumber = 0;
  int number;
  CollectionReference chairCollection =
      FirebaseFirestore.instance.collection('chair');
  CollectionReference user = FirebaseFirestore.instance.collection("user");
  @override
  void initState() {
    super.initState();
    userId = FirebaseAuth.instance.currentUser.uid;
    user.where("userID", isEqualTo: userId).get().then((value) {
      value.docs.forEach((element) {
        setState(() {
          userPhone = element.data()['phone'];
          username_ = element.data()['name'];
        });
      });
    });
    number = unique();
    showCurrentLocation();

//--------------------------------------------------
    chairCollection.get().then((value) {
      //setState(() {
      dbChairNumber = value.docs.length;
      // });
    });
  }

  var contriy, street, name, locality;
  bool show = false;
  GlobalKey<FormState> reqestKey = GlobalKey();
  var userRequestType, userChairNumber;
  String locationAdrress = '';
  List<String> item = ["بدون مساعد", "مساعد"];
  List<String> chair = ["1", "2", "3"];
  TimeOfDay selectedstarTime = TimeOfDay.now();
  TimeOfDay selectedEndTime = TimeOfDay.now();
  // ignore: non_constant_identifier_names
  String format_Star_Time = "";
  // ignore: non_constant_identifier_names
  String format_End_Time = "";
  @override
  Widget build(BuildContext context) {
    print(number);

    return Scaffold(
       drawer: drawer(context),
      appBar: AppBar(
          title: drowText(context, "طلب كرسي متحرك", 15),
          centerTitle: true,
          backgroundColor: deepGreen),
        body: Center(
            child: SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 50.h,
          ),
          drowText(context, "قم بملء الحقول ادناها", 18, color: deepGreen),
          Padding(
            padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 20.h),
            child: Form(
              key: reqestKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  drowMenu("نوع الطلب", requestType, item, (value) {
                    setState(() {
                      userRequestType = value;
                    });
                    print(userRequestType);
                  }, (value) {
                    if (value == null) {
                      return translatedData(context, "Fill in the field");
                    } else {
                      return null;
                    }
                  }),
                  //---------------------------------------------------------
                  SizedBox(height: 10.h),
                  drowMenu("عدد الكراسي", chairNumber, chair, (value) {
                    setState(() {
                      userChairNumber = value;
                    });
                    print(userChairNumber);
                  }, (value) {
                    if (value == null) {
                      return translatedData(context, "Fill in the field");
                    } else {
                      return null;
                    }
                  }),
                  //---------------------------------------------------------
                  SizedBox(height: 10.h),
                  showStardTime(),
                  SizedBox(height: 10.h),
                  showReturnTime(),
                  SizedBox(height: 10.h),
                  showLocation(),
                  SizedBox(height: 10.h),
                  viewStringLocationAddress(),
                  SizedBox(height: 10.h),
                  drowButtoms(context, "رفع الطلب", 12, white, () {
                    requestWheelChar(
                        userRequestType,
                        userChairNumber,
                        format_Star_Time,
                        selectedstarTime.hour,
                        selectedstarTime.minute,
                        format_End_Time,
                        selectedEndTime.hour,
                        selectedEndTime.minute,
                        locationAdrress,
                        latitude,
                        longtitude);
                  }, backgrounColor: deepGreen),
                ],
              ),
            ),
          ),
        ],
      ),
    )));
  }

//drow location continer------------------------------------------------------------
  Widget showLocation() {
    return drowContiner(
        43,
        double.infinity,
        0,
        0,
        gray,
        Row(
          children: [
            Icon(location, size: 25.sp, color: deepGreen),
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
        locationAdrress =
            "$contriy - $locality - ${placemark[0].administrativeArea}";

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
        43,
        double.infinity,
        0,
        0,
        gray,
        Row(
          children: [
            Icon(starTime, size: 25.sp, color: deepGreen),
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
        43,
        double.infinity,
        0,
        0,
        gray,
        Row(
          children: [
            Icon(endTime, size: 25.sp, color: deepGreen),
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
        format_Star_Time = "${selectedstarTime.format(context)} ";
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
        format_End_Time = "${selectedEndTime.format(context)} ";
        return format_End_Time;
      });
    }
    return null;
  }

  Future<void> requestWheelChar(
      userRequestType,
      userChairNumber,
      String formatStarTime,
      int hour,
      int minute,
      String formatEndTime,
      int hour2,
      int minute2,
      String locationAdrress,
      latitude,
      longtitude) async {
    print('userChairNumber: ${int.parse(userChairNumber)}');
    print('chair number: $dbChairNumber');
    if (reqestKey.currentState.validate() == false ||
        formatStarTime.isEmpty ||
        formatEndTime.isEmpty) {
      awesomDialog(context, "Empty data", "empty");
    } else if (dbChairNumber < int.parse(userChairNumber)) {
      awesomDialog(context, 'Request a wheelchair', 'try');
    } else {
      awesomDialog(context, 'Request a wheelchair', 'wating');

      await FirebaseFirestore.instance.collection('userRequests').add({
        'userId': userId,
        'userRequestType': userRequestType,
        'name': username_,
        'phone': userPhone,
        'state': false,
        'requestNumber': number,
        'userChairNumber': int.parse(userChairNumber),
        'formatStarTime': formatStarTime,
        'formatEndTime': formatEndTime,
        'Starthour': hour,
        'Starminute': minute,
        'Endthour': hour2,
        'Endminute': minute2,
        'locationAdrress': locationAdrress,
        'latitude': latitude,
        'longtitude': longtitude,
        'createOn':DateTime.now(),
        
        
      }).then((value) {
        Navigator.pop(context);
        awesomDialog(
          context,
          "Process completed",
          "successfully",
        );
      }).catchError((e) {
        Navigator.pop(context);
        awesomDialog(
          context,
          "Connection error",
          "connectionError",
        );
      });
    }
  }
}
