import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rent_house_app/features/presentation/home/home.dart';
import 'package:rent_house_app/helpers/factories/dialog_factory.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      navigatorKey: DialogFactory.navigatorKey,
      home: MaterialApp(
        theme: ThemeData(useMaterial3: true),
        home: const HomeScreen(),
      ),
    );
  }
}
