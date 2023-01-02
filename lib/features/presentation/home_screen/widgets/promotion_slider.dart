import '../../../services/advertisement_service.dart';
import '../home.dart';

class PromotionSlider extends StatelessWidget {
  PromotionSlider({
    super.key,
  });

  final HomeAdvertisementManager advertisementManager =
      HomeAdvertisementManager();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;

    return StreamBuilder<List<AdvertisementModel>>(
      stream: advertisementManager.getSlideSales(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressOnFecthing();
        } else if (snapshot.hasError) {
          return const ErrorFecthingData();
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const NoPromotionAvailable(
              content: 'Sem promoções disponíveis');
        } else {
          return SizedBox(
            height: height * 0.30,
            width: width,
            child: Swiper(
              duration: 5000,
              curve: Curves.fastOutSlowIn,
              itemBuilder: (BuildContext context, int index) {
                AdvertisementModel advertisement = snapshot.data![index];
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(
                      SaleDetailsScreen.routeName,
                      arguments: advertisement,
                    );
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Stack(
                            children: [
                              CachedNetworkImage(
                                imageUrl: advertisement.image![0],
                                fit: BoxFit.fill,
                                height: 150.0,
                                width: double.infinity,
                                placeholder: (context, str) => Center(
                                  child: Container(
                                    color: Colors.white,
                                    height: height,
                                    width: width,
                                    child: Image.asset('assets/loading.gif'),
                                  ),
                                ),
                                errorWidget: (context, url, error) =>
                                    const ErrorIconOnFetching(),
                              ),
                              Positioned(
                                bottom: 0.0,
                                child: Container(
                                  height: 30,
                                  width: width,
                                  color: Colors.black.withOpacity(0.5),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          advertisement.title!,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18.0,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
              itemWidth: width,
              itemHeight: height,
              layout: SwiperLayout.TINDER,
              autoplay: true,
              itemCount: snapshot.data!.length,
            ),
          );
        }
      },
    );
  }
}
