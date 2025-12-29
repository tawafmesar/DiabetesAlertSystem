import 'package:flutter/material.dart';
import '../../controller/activity_controller.dart';
import '../widget/custom_drawer.dart';
import 'Medicationscreen.dart';
import 'Metricsscreen.dart';
import 'activity_screen.dart';
import 'alarm/homepage_alarm_overview.dart';
import 'home_screeen.dart';


class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final pages = [
      HomeScreen(),
      MetricsScreen(),
      MedicationScreen(),
      ActivityScreen(),
      HomePageAlarmOverview(title: 'Alarm',)
    ];

    return Scaffold(
      drawer: const CustomDrawer(),
      body: pages[_currentIndex],
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFFEF3F2C),
                Color(0xFF954695),
                Color(0xFF0067B5),

              ],
              stops: [0.0, 0.6, 1.0],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              transform: GradientRotation(0.4),
            ),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              spreadRadius: 5,
              offset: Offset(0, -3),
            ),
          ],
        ),
        child: BottomNavigationBar(
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white60,
          backgroundColor: Colors.transparent,
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentIndex,
          onTap: (selectedIndex) {
            setState(() => _currentIndex = selectedIndex);
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.show_chart),
              label: 'Metrics',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.medication),
              label: 'Medication',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.fitness_center),
              label: 'Activity',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.alarm),
              label: 'Alarm',
            ),
          ],
        ),
      ),
    );
  }
}
