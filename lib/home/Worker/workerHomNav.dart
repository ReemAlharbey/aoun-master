import 'package:flutter/material.dart';

import '../../Widget/Colors.dart';
import 'AcceptedRequests.dart';
import 'workerRequest.dart';
class WorkerHome extends StatefulWidget {
  WorkerHome({Key key}) : super(key: key);

  @override
  State<WorkerHome> createState() => _WorkerHomeState();
}

class _WorkerHomeState extends State<WorkerHome> {
   int _selectedIndex = 0;
  final List page = [
     WorkerRequest(),
    AcceptedRequests()
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
              icon: Icon(Icons.insert_chart_outlined_rounded),
              label: "إدارة الطلبات",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.check_circle_outline),
              label: "طلباتي",
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