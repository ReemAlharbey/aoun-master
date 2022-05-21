import 'package:aoun/Widget/AwesomDialog.dart';
import 'package:aoun/Widget/Colors.dart';
import 'package:aoun/Widget/Controller.dart';
import 'package:aoun/Widget/Icons.dart';
import 'package:aoun/Widget/widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../TransilatClass/getTranselaitData.dart';

// ignore: camel_case_types
class donateWheelchar extends StatefulWidget {
  donateWheelchar({Key key}) : super(key: key);

  @override
  State<donateWheelchar> createState() => _donateWheelcharState();
}

// ignore: camel_case_types
class _donateWheelcharState extends State<donateWheelchar> {
  TextEditingController chairnNumberController = TextEditingController();
  GlobalKey<FormState> key = new GlobalKey();
  CollectionReference chairCollection =
      FirebaseFirestore.instance.collection('chair');
  var gate339Location =
      "https://www.google.com/maps?q=24.47088623046875,39.6141471862793&z=17&hl=en";
  var gate309Location =
      "https://www.google.com/maps?q=24.4661808013916,39.608253479003906&z=17&hl=en";
  var chair339 = 0;
  String identity = '';
  String username_ = '';
  String userId;
  CollectionReference user = FirebaseFirestore.instance.collection("user");

  var chair309 = 0;
  @override
  void initState() {
    super.initState();
    userId = FirebaseAuth.instance.currentUser.uid;
    chairCollection.get().then((value) {
      //gateNumber
      if (value.docs.isNotEmpty) {
        value.docs.forEach((element) {
          if (element["gateNumber"] == "339") {
            setState(() {
              chair339++;
            });
          } else {
            setState(() {
              chair309++;
            });
          }
        });
      }
    });

    user.where("userID", isEqualTo: userId).get().then((value) {
      value.docs.forEach((element) {
        setState(() {
          identity = element.data()['identity'];
          username_ = element.data()['name'];
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    print('name: $username_');
    print('identity: $identity');
   //print(chair309);
  // print(chair339);
    return Scaffold(
       drawer: drawer(context),
      appBar: AppBar(
          title: drowText(context, "التبرع بكرسي متحرك", 15),
          centerTitle: true,
          backgroundColor: deepGreen),
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 10.h,
        ),
        drowText(context, "املء الحقل ادناه", 18, color: deepGreen),
        Padding(
          padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Form(
                key: key,
                child: drowTextField(context, chairNumber, "عدد الكراسي", false,
                    chairnNumberController, notEmpty,
                    keyboardType: TextInputType.phone,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly]),
              ),
              SizedBox(height: 10.h),
              drowButtoms(context, "رفع الطلب", 12, white, () {
                if (key.currentState.validate()) {
                 
                  awesomDialog(context, 'Create an account', 'wating');
                  FirebaseFirestore.instance
                      .collection("donateWheelchairRequest")
                      .add({
                    'name': username_,
                    'chairNumber': chairnNumberController.text,
                    'identity': identity,
                  }).then((value){
                    Navigator.pop(context);
                     if (chair339 > chair309) {
                    goToLocaton(gate309Location, "Thank309");
                  } else {
                    goToLocaton(gate339Location, "Thank339");
                  }
                  });
                }
              }, backgrounColor: deepGreen),
              SizedBox(
                height: 40.h,
              ),
            ],
          ),
        ),
      ],
    ));
  }

  String notEmpty(String val) {
    if (val.isEmpty) {
      return translatedData(context, 'Fill in the field');
    }
  }

  void goToLocaton(String gatelocation, String key) {
    awesomDialog(context, "Donate a wheelchair", key, showButtom: true,
        noFunction: () {
      Navigator.pop(context);
    }, yesFunction: () async {
      try {
        if (await canLaunch(gatelocation)) {
          launch(gatelocation.toString());
          Navigator.pop(context);
        } else {
          print("----------------can not launch location------------------");
        }
      } catch (e) {
        print("----------------${e.toString()}------------------");
      }
    });
  }
}
