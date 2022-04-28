import 'package:aoun/Widget/AwesomDialog.dart';
import 'package:aoun/Widget/Colors.dart';
import 'package:aoun/Widget/Controller.dart';
import 'package:aoun/Widget/Icons.dart';
import 'package:aoun/Widget/widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
  var gate339Location = "https://www.google.com/maps?q=24.47088623046875,39.6141471862793&z=17&hl=en";
  var gate309Location = "https://www.google.com/maps?q=24.4661808013916,39.608253479003906&z=17&hl=en";
  var chair339 = 0;

  var chair309 = 0;
  @override
  void initState() {
    super.initState();

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
  }

  @override
  Widget build(BuildContext context) {
    print(chair309);
    print(chair339);
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 10.h,
        ),
        drowText(context, "التبرع بكرسي متحرك", 18, color: deepGreen),
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
                  if (chair309 > chair339) {
                    goToLocaton(gate309Location, "Thank309");
                  } else {
                    goToLocaton(gate339Location, "Thank339");
                  }
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
         // awesomDialog(context, 'Create an account', 'wating');
          launch(gatelocation.toString());
          Navigator.pop(context);
        } else {
          //awesomDialog(context, 'Create an account', e.toString());
        }
      } catch (e) {
        //awesomDialog(context, 'Create an account', e.toString());
      }
    });
  }
}
