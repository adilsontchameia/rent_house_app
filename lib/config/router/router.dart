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

    case ChatMessageScreen.routeName:
      return MaterialPageRoute(builder: (context) => const ChatMessageScreen());
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
      final imageIndex = settings.arguments as Map<String, dynamic>;
      return MaterialPageRoute(
        builder: (context) =>
            ImmersiveViewerScreen(imageIndex: imageIndex['imageIndex']),
      );

    default:
      return MaterialPageRoute(
          builder: (context) => const RouteErrorScreen(
              title: 'Sorry, we could not found the requested page'));
  }
}
