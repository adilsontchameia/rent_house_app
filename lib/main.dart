import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:rent_house_app/app/my_app.dart';
import 'package:rent_house_app/features/presentation/providers/user_data_provider.dart';
import 'package:rent_house_app/features/presentation/providers/user_provider.dart';
import 'package:rent_house_app/features/services/chat_service.dart';
import 'package:rent_house_app/features/services/user_manager.dart';
import 'package:rent_house_app/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  //Prevent from landscape
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<UserAuthProvider>(
          create: (_) => UserAuthProvider(),
          lazy: false,
        ),
        ChangeNotifierProvider<UserManager>(
          create: (_) => UserManager(),
          lazy: false,
        ),
        ChangeNotifierProvider<UserDataProvider>(
          create: (_) => UserDataProvider(),
          lazy: false,
        ),
        ChangeNotifierProvider<ChatService>(
          create: (_) => ChatService(),
          lazy: false,
        ),
      ],
      child: const MyApp(),
    ),
  );
}
