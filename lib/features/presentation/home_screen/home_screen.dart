import '../../services/advertisement_service.dart';
import 'home.dart';

class HomeResumeScreen extends StatefulWidget {
  static const routeName = '/home-screen';
  const HomeResumeScreen({super.key});

  @override
  State<HomeResumeScreen> createState() => _HomeResumeScreenState();
}

class _HomeResumeScreenState extends State<HomeResumeScreen>
    with WidgetsBindingObserver {
  final HomeAdvertisementManager advertisementManager =
      HomeAdvertisementManager();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Mô Cúbico',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 21.0,
                        letterSpacing: 3,
                        color: Colors.brown,
                      ),
                    ),
                  ],
                ),
                const Text(
                  'Promoções',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                      letterSpacing: 2,
                      color: Colors.brown),
                ),
                PromotionSlider(),
                const Text(
                  'Últimas Novidades',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                      letterSpacing: 2,
                      color: Colors.brown),
                ),
                StreamBuilder<List<AdvertisementModel>>(
                  stream: advertisementManager.getAllSales(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      // If the stream is still waiting for data, display a loading indicator.
                      return const Center(
                        child: CircularProgressIndicator(
                          color: Colors.brown,
                        ),
                      );
                    } else if (snapshot.hasError) {
                      // If an error occurred while fetching data, display an error message.
                      return Center(
                        child: Text(
                          'Error: ${snapshot.error}',
                          style: const TextStyle(color: Colors.red),
                        ),
                      );
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      // If there's no data or the data list is empty, display a message and image.
                      return Center(
                        child: Column(
                          children: [
                            Image.asset(
                              'assets/not_found.jpg',
                              height: 120.0,
                              width: 120.0,
                              fit: BoxFit.cover,
                            ),
                            const Text(
                              'No sales found',
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.brown,
                              ),
                            ),
                          ],
                        ),
                      );
                    } else {
                      // If there's data available, display a ListView of sales cards.
                      return ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          AdvertisementModel advertisement =
                              snapshot.data![index];
                          return LatestSalesCard(
                            advertisement: advertisement,
                          );
                        },
                      );
                    }
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
