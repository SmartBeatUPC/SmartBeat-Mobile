import 'package:flutter/material.dart';
import 'package:smartbeat_frontend/shared/components/custom_scaffold.dart';

class HomeScreen extends StatelessWidget {
  static String route = 'home_screen';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Center(
        child: Text('Home'),
      ),
    );
  }
}
