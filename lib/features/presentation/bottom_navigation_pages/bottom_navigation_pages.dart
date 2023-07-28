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
  HomeResumeScreen(),
  const FilteredAdvertisimentScreen(),
  const ChatMessageScreen(),
  ProfileScreen(),
];

class _BottomNavigationScreensState extends State<BottomNavigationScreens> {
  int currentIndex = 0;
  final pageController = PageController(initialPage: 0);
  ScrollController scrollController = ScrollController();
  bool showBottomNavBar = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          NotificationListener(
            onNotification: (scrollNotification) {
              if (scrollNotification is ScrollUpdateNotification) {
                setState(() {
                  showBottomNavBar = scrollNotification.scrollDelta! > 0;
                });
              }
              return false;
            },
            child: PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: pageController,
              onPageChanged: (index) {
                setState(() {
                  currentIndex = index;
                  showBottomNavBar = true;
                });
              },
              children: appPages,
            ),
          ),
          AnimatedOpacity(
            opacity: showBottomNavBar ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 350),
            child: Stack(
              children: [
                Positioned(
                  bottom: 20.0,
                  left: 20.0,
                  right: 20.0,
                  child: Container(
                    alignment: Alignment.center,
                    height: 50.0,
                    decoration: BoxDecoration(
                      color: Colors.brown,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
