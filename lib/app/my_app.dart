import 'package:rent_house_app/features/presentation/check_auth/check_auth_screen.dart';

import 'app.dart';

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
