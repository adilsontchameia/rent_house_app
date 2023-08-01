import 'package:rent_house_app/features/presentation/chat_messages/chat_messages_screen.dart';
import 'package:rent_house_app/features/presentation/check_auth/check_auth_screen.dart';

import 'routes.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case SaleDetailsScreen.routeName:
      final advertisement = settings.arguments as AdvertisementModel;
      return MaterialPageRoute(
          builder: (context) => SaleDetailsScreen(
                advertisement: advertisement,
              ));
    case HomeResumeScreen.routeName:
      return MaterialPageRoute(builder: (context) => HomeResumeScreen());

    case ChatMessagesListScreen.routeName:
      return MaterialPageRoute(
          builder: (context) => const ChatMessagesListScreen());
    case ChatMessagesScreen.routeName:
      final arguments = settings.arguments as Map<String, dynamic>;
      final name = arguments['name'];
      final uid = arguments['uid'];
      return MaterialPageRoute(
        builder: (context) => ChatMessagesScreen(
          name: name,
          uid: uid,
        ),
      );
    case CheckAuthScreen.routeName:
      return MaterialPageRoute(builder: (context) => const CheckAuthScreen());
    case LoginScreen.routeName:
      return MaterialPageRoute(builder: (context) => const LoginScreen());
    case RegisterScreen.routeName:
      return MaterialPageRoute(builder: (context) => const RegisterScreen());
    case ProfileScreen.routeName:
      return MaterialPageRoute(builder: (context) => ProfileScreen());
    case FilteredAdvertisimentScreen.routeName:
      return MaterialPageRoute(
          builder: (context) => const FilteredAdvertisimentScreen());
    case ImmersiveViewerScreen.routeName:
      final arguments = settings.arguments as Map<String, dynamic>;
      final imageIndex = arguments['imageIndex'];
      return MaterialPageRoute(
        builder: (context) => ImmersiveViewerScreen(imageIndex: imageIndex),
      );

    default:
      return MaterialPageRoute(
          builder: (context) => const RouteErrorScreen(
              title: 'Sorry, we could not found the requested page'));
  }
}
