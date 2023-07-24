import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rent_house_app/features/presentation/best_promo/best_promotion_screen.dart';
import 'package:rent_house_app/features/presentation/favourites/favourites_screen.dart';
import 'package:rent_house_app/features/presentation/profile/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

TextEditingController _searchController = TextEditingController();

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;
  final pageController = PageController(initialPage: 0);

  //Tab icons
  final tabIcons = [
    FontAwesomeIcons.house,
    FontAwesomeIcons.cartShopping,
    FontAwesomeIcons.a,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            PageView(
              controller: pageController,
              onPageChanged: (index) {
                setState(() {
                  currentIndex = index;
                });
              },
              children: const [
                ProfileScreen(),
                FavouriteScreen(),
                BestPromotionsScreen(),
              ],
            ),
            Positioned(
              bottom: 20.0,
              left: 20.0,
              right: 20.0,
              child: Container(
                alignment: Alignment.center,
                height: 50.0,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(40.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ...tabIcons.asMap().entries.map(
                            (entry) => IconButton(
                              onPressed: () {
                                pageController.animateToPage(entry.key,
                                    duration: const Duration(milliseconds: 600),
                                    curve: Curves.easeInSine);
                              },
                              icon: Icon(
                                entry.value,
                                color: currentIndex == entry.key
                                    ? Colors.white
                                    : Colors.grey,
                                size: 22,
                              ),
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
    );
  }
}
