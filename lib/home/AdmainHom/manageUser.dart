import 'package:aoun/Widget/Icons.dart';
import 'package:aoun/Widget/widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../Widget/AwesomDialog.dart';
import '../../Widget/Colors.dart';

class ManageUser extends StatefulWidget {
  ManageUser({Key key}) : super(key: key);

  @override
  State<ManageUser> createState() => _ManageUserState();
}

class _ManageUserState extends State<ManageUser> {
  List userRecord = [];
  CollectionReference userCollection =
      FirebaseFirestore.instance.collection("user");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: drawer(context),
      appBar: AppBar(
          title: drowText(context, "إدارة المستخدمين", 15),
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
                awesomDialog(context, "ادارة المستخدمين",
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
    return snapshat.data.docs.length > 0
        ? Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0.w, vertical: 14.h),
            child: ListView.builder(
                //shrinkWrap: true,
                itemCount: snapshat.data.docs.length,
                itemBuilder: (context, i) {
                  print(
                    snapshat.data.docs.length,
                  );
//delete----------------------------------------------------------
                  return SizedBox(
                    height: 150.h,
                    child: deleteUser(
                      snapshat.data.docs[i].id,
                      Card(
                        elevation: 5,
                        color: white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            side: BorderSide(color: deepGreen, width: 2)),
                        child: Column(
                          children: [
                            getData(
                                snapshat.data.docs[i].data()['name'], nameIcon),
                            SizedBox(height: 5.w),
                            getData(snapshat.data.docs[i].data()['identity'],
                                iDIcon),
                            SizedBox(height: 5.w),
                            getData(snapshat.data.docs[i].data()['phone'],
                                phoneIcon),
                            SizedBox(height: 5.w),
                            getData(snapshat.data.docs[i].data()['emile'],
                                emailIcon),
                            SizedBox(height: 5.w),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
          )
        : Center(
            child:
                drowText(context, "لايوجد مستخدمين حاليا", 15, color: black));
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

//delete user---------------------------------------------------------------------
  Widget deleteUser(String id, Widget child) {
    return Dismissible(
      direction: DismissDirection.startToEnd,
      secondaryBackground: Container(),
      background: Container(
        color: deepGreen,
        child: Padding(
          padding: EdgeInsets.all(15.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 12.0.w, vertical: 5.h),
                child: Icon(Icons.delete, color: Colors.white, size: 36.sp),
              ),
              drowText(context, "خذف المستخدم", 12.3,
                  fontWeight: FontWeight.bold, color: white)
            ],
          ),
        ),
      ),
      confirmDismiss: (DismissDirection direction) async {
        return showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: drowText(context, "تأكيد الحذف", 12.3,
                  fontWeight: FontWeight.bold, color: deepGreen),
              content: drowText(
                  context, "هل أنت متأكد أنك تريد حذف هذالمستخدم؟", 12.3,
                  fontWeight: FontWeight.bold, color: black),
              actions: [
                FlatButton(
                  onPressed: () {
                    setState(() {
                      FirebaseFirestore.instance
                          .collection('user')
                          .doc(id)
                          .delete()
                          .then((value) {});
                      setState(() {});
                    });

                    Navigator.of(context).pop(true);
                  },
                  child: Center(
                    child: drowText(context, "حذف", 12.3,
                        fontWeight: FontWeight.bold, color: deepGreen),
                  ),
                ),
                FlatButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Center(
                    child: drowText(context, "الغاء", 12.3,
                        fontWeight: FontWeight.bold, color: black),
                  ),
                ),
              ],
            );
          },
        );
      },
      key: UniqueKey(),
      child: child,
    );
  }
}
