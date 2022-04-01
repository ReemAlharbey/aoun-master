import 'package:aoun/Widget/Colors.dart';
import 'package:flutter/material.dart';
import 'RequestWheelchair.dart';
import 'donateWheelchair.dart';
import 'notification.dart';
// ignore: camel_case_types
class userHomePage extends StatefulWidget {
  userHomePage({Key key}) : super(key: key);

  @override
  State<userHomePage> createState() => _userHomePageState();
}

// ignore: camel_case_types
class _userHomePageState extends State<userHomePage> {
  int _selectedIndex = 1;
  final List page = [
    
    donateWheelchar(),
    requestWheelchar(),
    notification(),
  
  ];
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: page[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor:deepGreen,
          selectedFontSize: 14,
          selectedItemColor: white,
          unselectedItemColor: Colors.grey[400],
          unselectedFontSize: 11,
          
          currentIndex: _selectedIndex,
          onTap: onTabTapped,
          items: const [
    
            BottomNavigationBarItem(
              icon: Icon(Icons.wheelchair_pickup),
              label: "اتبرع بكرسي",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.accessible),
              label: "طلب كرسي",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications),
              label: "الاشعارات",
            ),
            
            
            
          ],
        ),
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}

//"${snapshat.data.docs[i].data()['ordersName'][j]}"