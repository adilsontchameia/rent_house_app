import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../config/router/router.dart';
import '../core/factories/dialog_factory.dart';
import '../features/presentation/check_auth/check_auth_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      navigatorKey: DialogFactory.navigatorKey,
      debugShowCheckedModeBanner: false,
      onGenerateRoute: (settings) => generateRoute(settings),
      theme: ThemeData(useMaterial3: true),
      home: const CheckAuthScreen(),
    );
  }
}
