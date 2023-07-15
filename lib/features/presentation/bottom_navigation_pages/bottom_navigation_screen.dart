import 'package:rent_house_app/features/services/user_manager.dart';

import 'widgets/bottom_nav.dart';

class BottomNavigationScreens extends StatefulWidget {
  static const routeName = '/bottom-navigation-screens';
  const BottomNavigationScreens({super.key});

  @override
  State<BottomNavigationScreens> createState() =>
      _BottomNavigationScreensState();
}

final tabIcons = [
  FontAwesomeIcons.house,
  FontAwesomeIcons.chartSimple,
  FontAwesomeIcons.message,
  FontAwesomeIcons.user,
];

final appPages = [
  const HomeResumeScreen(),
  const FilteredAdvertisimentScreen(),
  const ListChatMessagesScreen(),
  ProfileScreen(),
];

class _BottomNavigationScreensState extends State<BottomNavigationScreens>
    with WidgetsBindingObserver {
  int currentIndex = 0;
  bool isVisible = true;
  final pageController = PageController(initialPage: 0);
  final UserManager _userManager = UserManager();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    super.dispose();

    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    setState(() {
      super.didChangeAppLifecycleState(state);
      switch (state) {
        case AppLifecycleState.resumed:
          _userManager.setUserState(true);
          break;
        case AppLifecycleState.inactive:
        case AppLifecycleState.detached:
        case AppLifecycleState.paused:
          _userManager.setUserState(false);
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: pageController,
              onPageChanged: (index) {
                setState(() {
                  currentIndex = index;
                });
              },
              children: appPages,
            ),
            Stack(
              children: [
                Positioned(
                  bottom: 20.0,
                  left: 20.0,
                  right: 20.0,
                  child: AnimatedOpacity(
                    opacity: isVisible ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 1000),
                    curve: Curves.bounceInOut,
                    child: Container(
                      alignment: Alignment.center,
                      height: 50.0,
                      width: width,
                      decoration: BoxDecoration(
                        color: Colors.brown,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            ...tabIcons.asMap().entries.map(
                                  (entry) => TabIcons(
                                    isSelected: currentIndex == entry.key,
                                    iconData: entry.value,
                                    onTap: () {
                                      pageController.animateToPage(
                                        duration: const Duration(
                                          milliseconds: 350,
                                        ),
                                        curve: Curves.fastLinearToSlowEaseIn,
                                        entry.key,
                                      );
                                      setState(() {
                                        currentIndex = entry.key;
                                      });
                                    },
                                  ),
                                ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: 20.0,
              right: 2.0,
              child: Container(
                height: 50.0,
                width: 50.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.brown,
                ),
                child: IconButton(
                  onPressed: () {
                    setState(() {
                      if (isVisible) {
                        isVisible = false;
                      } else {
                        isVisible = true;
                      }
                    });
                  },
                  icon: Icon(
                    isVisible
                        ? FontAwesomeIcons.downLeftAndUpRightToCenter
                        : FontAwesomeIcons.upRightAndDownLeftFromCenter,
                    color: Colors.white,
                    size: 15.0,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
