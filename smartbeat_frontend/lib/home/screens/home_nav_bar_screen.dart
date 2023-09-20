import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smartbeat_frontend/home/pages/analisis_medico_page.dart';
import 'package:smartbeat_frontend/home/pages/historial_page.dart';
import 'package:smartbeat_frontend/home/pages/profile_page.dart';

class HomeNavBarScreen extends StatefulWidget {
  static String route = 'home_nav_bar_screen';

  @override
  State<HomeNavBarScreen> createState() => _HomeNavBarScreenState();
}

class _HomeNavBarScreenState extends State<HomeNavBarScreen> {
  List<Widget> _pages = <Widget>[];
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _pages = <Widget>[
      const ProfilePage(),
      const AnalisisMedicoPage(),
      const HistorialPage(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.20),
              spreadRadius: 10,
              blurRadius: 50,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          currentIndex: _selectedIndex,
          onTap: (value) {
            _selectedIndex = value;
            setState(() {});
          },
          items: const [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.person,
                  size: 40,
                ),
                label: ''),
            BottomNavigationBarItem(
                icon: Icon(
                  FontAwesomeIcons.briefcaseMedical,
                  size: 30.0,
                ),
                label: ''),
            BottomNavigationBarItem(
                icon: Icon(
                  FontAwesomeIcons.clipboardList,
                  size: 30.0,
                ),
                label: ''),
          ],
        ),
      ),
    );
  }
}
