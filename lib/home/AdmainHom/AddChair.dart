import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../TransilatClass/getTranselaitData.dart';
import '../../Widget/AwesomDialog.dart';
import '../../Widget/Colors.dart';
import '../../Widget/Icons.dart';
import '../../Widget/widget.dart';

class addChair extends StatefulWidget {
  addChair({Key key}) : super(key: key);

  @override
  State<addChair> createState() => _addChairState();
}

class _addChairState extends State<addChair> {
  TextEditingController charId = new TextEditingController();
  GlobalKey<FormState> chairKey = GlobalKey();
  CollectionReference chairCollection =
      FirebaseFirestore.instance.collection('chair');

  String gatNumberValue;
  var chair339;
  var total;
  var chair309;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Center(
              child: Padding(
            padding: EdgeInsets.all(10.0.w),
            child: SizedBox(
                width: double.infinity,
                child: drowButtoms(context, "اضافة كرسي جديد", 12, white, () {
                  showButtomsheet();
                }, backgrounColor: deepGreen)),
          )),
          Expanded(
              child: Padding(
                  padding: EdgeInsets.all(10.0.w),
                  child: StreamBuilder(
                      stream: chairCollection.snapshots(),
                      builder: (context, AsyncSnapshot snapshat) {
                        if (snapshat.hasData) {
                          chairCollection.get().then((value) {
                            total = value.docs.length;
                          });
                          chairCollection
                              .where("gateNumber", isEqualTo: "339")
                              .get()
                              .then((value) {
                            chair339 = value.docs.length;
                            setState(() {});
                          });
                          chairCollection
                              .where("gateNumber", isEqualTo: "309")
                              .get()
                              .then((value) {
                            chair309 = value.docs.length;
                          });

                          return snapshat.data.docs.length > 0
                              ? Column(
                                  children: [
                                    Column(
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              child: drowText(
                                                  context, "الكراسي الكلية", 13,
                                                  color: black),
                                            ),
                                            Expanded(
                                              child: Center(
                                                child: drowText(context,
                                                    "في البوابة 339", 13,
                                                    color: black),
                                              ),
                                            ),
                                            Expanded(
                                              child: Center(
                                                child: drowText(context,
                                                    "في البوابة 309", 13,
                                                    color: black),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: drowText(
                                                  context, "$total كراسي", 12,
                                                  color: deepGreen),
                                            ),
                                            Expanded(
                                              child: Center(
                                                child: drowText(context,
                                                    "$chair339 كراسي", 12,
                                                    color: deepGreen),
                                              ),
                                            ),
                                            Expanded(
                                              child: Center(
                                                child: drowText(context,
                                                    "$chair309 كراسي", 12,
                                                    color: deepGreen),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10.h),
                                    Expanded(
                                        flex: 7,
                                        child: ListView.builder(
                                            itemCount:
                                                snapshat.data.docs.length,
                                            itemBuilder: (context, index) {
                                              var data = snapshat
                                                  .data.docs[index]
                                                  .data();
                                              return Container(
                                                height: 70.h,
                                                width: double.infinity,
                                                margin: EdgeInsets.symmetric(
                                                    vertical: 5.w),
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 10.w),
                                                color: deepgray,
                                                child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          drowText(
                                                              context,
                                                              "رقم الكرسي: ${data['chairId']}",
                                                              13.4,
                                                              color: black),
                                                          InkWell(
                                                              onTap: () {
                                                                FirebaseFirestore
                                                                    .instance
                                                                    .collection(
                                                                        'chair')
                                                                    .doc(
                                                                        "${snapshat.data.docs[index].id}")
                                                                    .delete();
                                                              },
                                                              child: Icon(
                                                                  Icons.delete,
                                                                  color: Color.fromARGB(255, 202, 4, 4)))
                                                        ],
                                                      ),
                                                      drowText(
                                                          context,
                                                          "رقم البوابة: ${data['gateNumber']}",
                                                          12,
                                                          color:
                                                              black.withOpacity(
                                                                  0.5)),
                                                    ]),
                                              );
                                            }))
                                  ],
                                )
                              : Center(
                                  child: drowText(
                                      context, "لاتوجد كراسي حاليا", 14.4,
                                      color: black));
                        }
                        return Center(child: CircularProgressIndicator());
                      })))
        ],
      ),
    );
  }

  //-------------------------------------------------------------
  void showButtomsheet() {
    showModalBottomSheet<void>(
      elevation: 10,
      backgroundColor: white,
      context: context,
      isDismissible: false,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(20.r), topLeft: Radius.circular(20.r)),
        //side: BorderSide(color: Colors.white, width: 1),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: Form(
            key: chairKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                    child: Padding(
                  padding: EdgeInsets.only(top: 20.0.h),
                  child: drowText(context, "معلومات الكرسي", 12,
                      color: black, fontWeight: FontWeight.w400),
                )),
                SizedBox(
                  height: 10.h,
                ),
                //chair number-------------------------------------------------------------

                Padding(
                  padding: EdgeInsets.all(8.0.w),
                  child: drowTextField(context, chairNumber, "رقم الكرسي",
                      false, charId, validChair,
                      keyboardType: TextInputType.phone,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly
                      ]),
                ),
                //gate number-------------------------------------------------------------
                Padding(
                  padding: EdgeInsets.all(8.0.w),
                  child: drowMenu( "رقم البوابة",gate, ["309", "339"], (value) {
                    setState(() {
                      gatNumberValue = value;
                    });
                  }, (value) {
                    if (value == null) {
                      return translatedData(context, "Fill in the field");
                    } else {
                      return null;
                    }
                  }),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
//add buttom---------------------------------------------------------
                      drowButtoms(context, "اضافة", 12, white, () async {
                        if (chairKey.currentState.validate()) {
                          awesomDialog(context, 'add chair', 'wating');
                          await FirebaseFirestore.instance
                              .collection('chair')
                              .add({
                            "chairId": charId.text,
                            "gateNumber": gatNumberValue,
                          }).then((value) {
                            Navigator.of(context).pop();

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
                      }, backgrounColor: deepGreen, width: 165.w),
                      drowButtoms(context, "الغاء", 12, white, () {
                        Navigator.of(context).pop();
                      }, backgrounColor: deepGreen, width: 165.w),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }


  String validChair(String val) {
    if (val.isEmpty) {
      return translatedData(context, 'Fill in the field');
    }
    if (val.length != 4) {
      return translatedData(context, 'chairNumber');
    }
  }

//delete chari---------------------------------------------------------------------

}
