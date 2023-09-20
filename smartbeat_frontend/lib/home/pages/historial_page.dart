import 'package:flutter/material.dart';
import 'package:smartbeat_frontend/shared/components/custom_scaffold.dart';

class HistorialPage extends StatelessWidget {
  const HistorialPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Text('Historial medico'),
      ),
    );
  }
}
