import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../Widget/AwesomDialog.dart';
import '../../Widget/Colors.dart';
import '../../Widget/Icons.dart';
import '../../Widget/widget.dart';

class ManageWheelChair extends StatefulWidget {
  ManageWheelChair({Key key}) : super(key: key);

  @override
  State<ManageWheelChair> createState() => _ManageWheelChairState();
}

class _ManageWheelChairState extends State<ManageWheelChair> {
  int select = 1;

  CollectionReference userCollection =
      FirebaseFirestore.instance.collection("user");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: drowText(context, "إدارة الكراسي المتحركة", 15),
          centerTitle: true,
          backgroundColor: deepGreen),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        //color: green,
        child: StreamBuilder(
            stream: userCollection.snapshots(),
            builder: (BuildContext context, AsyncSnapshot snapshat) {
              if (snapshat.hasError) {
                awesomDialog(context, "ادارة الكراسي",
                    "خطا في استرجاع البيانات من قاعدة البيانات");
              }
              if (snapshat.hasData) {
                return getUsers(context, snapshat);
              }

              return const Center(
                child: CircularProgressIndicator(),
              );
            }),
      ),
    );
  }

  //show products-------------------------------
  Widget getUsers(BuildContext context, AsyncSnapshot snapshat) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0.w, vertical: 14.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0.w, vertical: 10.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 120,
                    child: drowButtoms(
                        context, 'طلبات التبرع', select == 1 ? 14 : 12, white,
                        () {
                      setState(() {
                        select = 1;
                      });
                    }, backgrounColor: deepGreen),
                  ),
                  SizedBox(
                    width: 120,
                    child: drowButtoms(
                        context, 'طلبات الكراسي', select == 2 ? 14 : 12, white,
                        () {
                      setState(() {
                        select = 2;
                      });
                    }, backgrounColor: deepGreen),
                  ),
                  SizedBox(
                    width: 120,
                    child: drowButtoms(
                        context, 'اضافة كرسي', select == 3 ? 14 : 12, white,
                        () {
                      setState(() {
                        select = 3;
                      });
                    }, backgrounColor: deepGreen),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0.w, vertical: 10.h),
              child: drowText(
                  context,
                  select == 1
                      ? "طلبات التبرع"
                      : select == 2
                          ? "طلبات الكرسي"
                          : "اضافة كرسي",
                  15,
                  color: black,
                  fontWeight: FontWeight.bold),
            ),
            //SizedBox(height: 10.h),
//dontal request---------------------------------------------------------------------
            select == 1
                ? Expanded(
                    flex: 4,
                    child: ListView.builder(
                        //shrinkWrap: true,
                        itemCount: snapshat.data.docs.length,
                        itemBuilder: (context, i) {
                          print(
                            snapshat.data.docs.length,
                          );
//delete----------------------------------------------------------
                          return SizedBox(
                            height: 120.h,
                            child: Card(
                              elevation: 5,
                              color: white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  side: BorderSide(color: deepGreen, width: 2)),
                              child: Column(
                                children: [
                                  SizedBox(height: 10.w),
                                  getData("نجلاء محمد", nameIcon),
                                  SizedBox(height: 5.w),
                                  getData("1524789652", iDIcon),
                                  SizedBox(height: 5.w),
                                  getData("3", chairNumber),
                                 
                                      SizedBox(height: 5.w),
                                ],
                              ),
                            ),
                          );
                        }),
                  )
//chiar request------------------------------------------------------------------------------------
                : select == 2
                    ? Expanded(
                        flex: 4,
                        child: ListView.builder(
                            //shrinkWrap: true,
                            itemCount: snapshat.data.docs.length,
                            itemBuilder: (context, i) {
                              print(
                                snapshat.data.docs.length,
                              );
//delete----------------------------------------------------------
                              return SizedBox(
                                height: 180.h,
                                child: Card(
                                  elevation: 5,
                                  color: white,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      side: BorderSide(
                                          color: deepGreen, width: 2)),
                                  child: Column(
                                    children: [
                                      SizedBox(height: 10.w),
                                      getData("ريم محمد", nameIcon),
                                      SizedBox(height: 5.w),
                                      getData("125875424", iDIcon),
                                      SizedBox(height: 5.w),
                                      getData("2", chairNumber),
                                      SizedBox(height: 5.w),
                                      getData("12:30 AM", starTime),
                                      SizedBox(height: 5.w),
                                      getData("1:30 AM", endTime),
                                      SizedBox(height: 5.w),
                                    ],
                                  ),
                                ),
                              );
                            }),
                      )
                    :
//---------------------------------------------------------
                    Expanded(child: getChaiar())
          ],
        ));
  }

//get data from database--------------------------------------
  Widget getData(text, icon) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.0.w),
        child: Row(children: [
          Icon(
            icon,
            color: deepGreen,
          ),
          SizedBox(width: 10.w),
          drowText(context, text, 12.3,
              fontWeight: FontWeight.bold, color: black)
        ]),
      ),
    );
  }

//-----------------------------------------------------
  getChaiar() {
    return Container(
      child: Column(
        children: [
          Center(
              child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: SizedBox(
                width: double.infinity,
                child: drowButtoms(context, "اضافة كرسي جديد", 12, white, () {},
                    backgrounColor: deepGreen)),
          )),
        ],
      ),
    );
  }
}
