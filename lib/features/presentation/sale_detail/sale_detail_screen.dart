import 'dart:developer';

import 'package:rent_house_app/core/utils.dart';
import 'package:rent_house_app/features/presentation/sale_detail/sale_details.dart';
import 'package:rent_house_app/features/presentation/widgets/error_icon_on_fetching.dart';

import 'widget/immersive_viewer_screen.dart';

class SaleDetailsScreen extends StatefulWidget {
  static const routeName = '/details-screen';
  const SaleDetailsScreen({super.key, required this.advertisement});

  final AdvertisementModel advertisement;

  @override
  State<SaleDetailsScreen> createState() => _SaleDetailsScreenState();
}

class _SaleDetailsScreenState extends State<SaleDetailsScreen> {
  String imageIndex = '';
  bool highView = false;
  int selectedImageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 247, 247, 247),
      body: SingleChildScrollView(
        physics: highView
            ? const NeverScrollableScrollPhysics()
            : const ScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(children: [
              GestureDetector(
                onDoubleTap: () {
                  setState(() {
                    if (!highView) {
                      highView = true;
                    } else {
                      highView = false;
                    }
                  });
                },
                child: AnimatedContainer(
                  duration: const Duration(seconds: 1),
                  height: highView ? height : height * 0.60,
                  width: width,
                  color: Colors.white,
                  child: Card(
                    elevation: 3.0,
                    margin: EdgeInsets.zero,
                    child: Hero(
                      tag: 'header_pic',
                      child: CachedNetworkImage(
                        imageUrl: imageIndex.isEmpty
                            ? widget.advertisement.image!.first
                            : imageIndex,
                        errorWidget: (context, url, error) =>
                            const ErrorIconOnFetching(),
                        fit: BoxFit.fill,
                        placeholder: (context, str) => Center(
                          child: Image.asset(
                            'assets/loading.gif',
                            height: height,
                            width: width,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              AnimatedOpacity(
                duration: const Duration(seconds: 1),
                opacity: !highView ? 1.0 : 0.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const CustomSmallButton(
                      onTap: null,
                      icon: FontAwesomeIcons.arrowLeft,
                    ),
                    CustomSmallButton(
                      onTap: () {
                        if (imageIndex.isEmpty &&
                            widget.advertisement.image!.isNotEmpty) {
                          imageIndex = widget.advertisement.image!.first;
                        }
                        Navigator.of(context).pushNamed(
                          ImmersiveViewerScreen.routeName,
                          arguments: {
                            'imageIndex': imageIndex,
                          },
                        );
                      },
                      icon: FontAwesomeIcons.image,
                    ),
                  ],
                ),
              ),
            ]),
            SizedBox(
              height: height * 0.10,
              width: width,
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: widget.advertisement.image!.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  log('debugApp Seller ID: ${widget.advertisement.sellerId!}');
                  log('debugApp Ads ID: ${widget.advertisement.id!}');

                  final bool isSelected = selectedImageIndex == index;
                  return Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 5.0,
                        vertical: 5.0,
                      ),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            imageIndex = widget.advertisement.image![index];
                            selectedImageIndex = index;
                          });
                        },
                        child: Stack(
                          children: [
                            FadeInLeft(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(5.0),
                                child: CachedNetworkImage(
                                    imageUrl:
                                        widget.advertisement.image![index],
                                    height: 100.0,
                                    width: 100.0,
                                    placeholder: (context, str) => Container(
                                          height: 80.0,
                                          width: 80.0,
                                          color: Colors.white,
                                          child: Image.asset(
                                            'assets/loading.gif',
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                    errorWidget: (context, url, error) =>
                                        const ErrorIconOnFetching()),
                              ),
                            ),
                            if (!isSelected)
                              Positioned(
                                bottom: 0,
                                child: Container(
                                  height: 100,
                                  width: 100,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5.0),
                                    color: Colors.black.withOpacity(0.5),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FadeInRight(
                    child: VerifiedSeller(
                        sellerId: widget.advertisement.sellerId!),
                  ),
                  FadeInLeft(
                    child: Text(
                      'Data: ${formatDateTime(widget.advertisement.publishedDate!)}',
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 12.0,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                  FadeInLeft(
                    child: Text(
                      'Provincia: ${widget.advertisement.province}',
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 12.0,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                  FadeInLeft(
                    child: ExpansionTile(
                        tilePadding: EdgeInsets.zero,
                        collapsedIconColor: Colors.brown,
                        iconColor: Colors.brown,
                        title: const Text('Detalhes',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18.0)),
                        subtitle: const Text(
                            'Resumo dos compartimentos da casa.',
                            style: TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 12.0)),
                        children: [
                          AllCompartmentsAvailable(
                              advertisement: widget.advertisement)
                        ]),
                  ),
                  FadeInLeft(
                    child: ExpansionTile(
                        tilePadding: EdgeInsets.zero,
                        collapsedIconColor: Colors.brown,
                        iconColor: Colors.brown,
                        title: const Text(
                          'Descrição',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                          ),
                        ),
                        subtitle: const Text('Mais detalhes do anúncio.',
                            style: TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 12.0)),
                        children: [
                          ReadMoreText(
                            widget.advertisement.additionalDescription!,
                            trimLines: 2,
                            colorClickableText: Colors.blue,
                            trimMode: TrimMode.Line,
                            trimCollapsedText: '\nVer mais',
                            trimExpandedText: '\nVer menos',
                            textAlign: TextAlign.justify,
                            lessStyle: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.brown),
                            moreStyle: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.brown),
                          ),
                        ]),
                  ),
                  MoreButtons(advertisement: widget.advertisement),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
