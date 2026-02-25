import 'package:flutter/material.dart';
import 'screens/dashboard/dashboard_main.dart';

void main() {
  runApp(const SafeFlowParrainApp());
}

class SafeFlowParrainApp extends StatelessWidget {
  const SafeFlowParrainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SafeFlow Parrain',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        fontFamily: 'Roboto',
      ),
      home: const DashboardMain(), // Direct au dashboard
    );
  }
}
