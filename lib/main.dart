import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rent_house_app/features/presentation/register/register_screen.dart';

void main() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: const RegisterScreen(),
    );
  }
}
