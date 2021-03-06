import 'package:flutter/material.dart';

import '../../Widget/Colors.dart';
import '../../Widget/widget.dart';
import 'manageUser.dart';
import 'manageWheelChair.dart';

class AdmianHomeNavigation extends StatefulWidget {
  AdmianHomeNavigation({Key key}) : super(key: key);

  @override
  State<AdmianHomeNavigation> createState() => _AdmianHomeNavigationState();
}

class _AdmianHomeNavigationState extends State<AdmianHomeNavigation> {
  int _selectedIndex = 1;
  final List page = [
    ManageUser(),
    ManageWheelChair(),
  ];
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        
        body: page[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: deepGreen,
          selectedFontSize: 14,
          selectedItemColor: white,
          unselectedItemColor: Colors.grey[400],
          unselectedFontSize: 11,
          currentIndex: _selectedIndex,
          onTap: onTabTapped,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.manage_accounts_sharp),
              label: "إدارة المستخدمين",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.insert_chart_outlined_rounded),
              label: "إدارة الكراسي",
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
