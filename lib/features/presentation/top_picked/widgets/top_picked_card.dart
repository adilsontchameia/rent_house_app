import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rent_house_app/features/presentation/home_screen/home.dart';
import 'package:rent_house_app/features/presentation/home_screen/widgets/search_text_field.dart';
import 'package:rent_house_app/features/presentation/sale_detail/sale_details.dart';
import 'package:rent_house_app/features/presentation/top_picked/widgets/top_picked_card_model.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class TopPickedCard extends StatefulWidget {
  TopPickedCard({
    Key? key,
  }) : super(key: key);

  final AdvertisementModel advertisement = AdvertisementModel();

  @override
  State<TopPickedCard> createState() => _TopPickedCardState();
}

class _TopPickedCardState extends State<TopPickedCard> {
  final TextEditingController _searchController = TextEditingController();
  final HomeAdvertisementManager advertisementManager =
      HomeAdvertisementManager();
  String query = '';
  bool? topPickedFilter;
  String? categoryFilter;
  int? minPriceFilter;
  int? maxPriceFilter;
  bool sortByTitleAZ = false;
  late bool isVisible;
  final double minPrice = 5000.0;
  final double maxPrice = 500000.0;
  final double priceIncrement = 1000.0;

  int get divisions {
    return ((maxPrice - minPrice) / priceIncrement).ceil();
  }

  @override
  void initState() {
    isVisible = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SearchField(
          controller: _searchController,
          label: 'Pesquise aqui...',
          icon: FontAwesomeIcons.magnifyingGlass,
          onChanged: (value) {
            query = value;
            setState(() {
              if (value.trim().isNotEmpty) {
                isVisible = true;
              } else {
                isVisible = false;
              }
            });
          },
          isVisible: isVisible,
        ),
        ExpansionTile(
            tilePadding: EdgeInsets.zero,
            collapsedIconColor: Colors.brown,
            iconColor: Colors.brown,
            leading: const Icon(FontAwesomeIcons.filter, color: Colors.brown),
            title: const Text('Por Categorias',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0)),
            children: [
              Wrap(
                spacing: 5.0,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        topPickedFilter = null;
                        categoryFilter = null;
                        minPriceFilter = null;
                        maxPriceFilter = null;
                        sortByTitleAZ = false;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.brown,
                        foregroundColor: Colors.white,
                        elevation: 2,
                        padding: const EdgeInsets.all(5),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(2.0))),
                    child: const Text('Todos'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        sortByTitleAZ = !sortByTitleAZ;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.brown,
                        foregroundColor: Colors.white,
                        elevation: 2,
                        padding: const EdgeInsets.all(5),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(2.0))),
                    child: Text(sortByTitleAZ ? 'Ordenar ZA' : 'Ordenar AZ'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        topPickedFilter = true;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.brown,
                        foregroundColor: Colors.white,
                        elevation: 2,
                        padding: const EdgeInsets.all(5),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(2.0))),
                    child: const Text('Promoções'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        categoryFilter = 'Electronics';
                      });
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.brown,
                        foregroundColor: Colors.white,
                        elevation: 2,
                        padding: const EdgeInsets.all(5),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(2.0))),
                    child: const Text('Apartamentos'),
                  ),

                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        categoryFilter = 'casa';
                      });
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.brown,
                        foregroundColor: Colors.white,
                        elevation: 2,
                        padding: const EdgeInsets.all(5),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(2.0))),
                    child: const Text('Casas'),
                  ),
                  //TODO change
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        categoryFilter = 'Electronics';
                      });
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.brown,
                        foregroundColor: Colors.white,
                        elevation: 2,
                        padding: const EdgeInsets.all(5),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(2.0))),
                    child: const Text('Quartos'),
                  ),
                ],
              ),
            ]),
        ExpansionTile(
            tilePadding: EdgeInsets.zero,
            collapsedIconColor: Colors.brown,
            iconColor: Colors.brown,
            leading: const Icon(FontAwesomeIcons.filterCircleDollar,
                color: Colors.brown),
            title: const Text('Por Preço',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0)),
            children: [
              RangeSlider(
                activeColor: Colors.brown,
                inactiveColor: Colors.grey,
                values: RangeValues(minPriceFilter?.toDouble() ?? minPrice,
                    maxPriceFilter?.toDouble() ?? maxPrice),
                min: minPrice,
                max: maxPrice,
                divisions: divisions,
                labels: RangeLabels(
                  KwanzaFormatter.formatKwanza(double.parse(
                    '${minPriceFilter ?? 5000}',
                  )),
                  KwanzaFormatter.formatKwanza(double.parse(
                    '${maxPriceFilter ?? 500000}',
                  )),
                ),
                onChanged: (RangeValues values) {
                  setState(() {
                    minPriceFilter = values.start.round();
                    maxPriceFilter = values.end.round();
                  });
                },
              ),
            ]),
        StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('sales').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return buildLoadingIndicator();
            } else if (snapshot.hasError) {
              return buildErrorWidget(snapshot.error);
            } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              if (query.isEmpty) {
                return const NoResultsFoundWidget(
                  message: 'No sales found',
                );
              } else {
                return const NoResultsFoundWidget(
                  message: 'No matching results found',
                );
              }
            } else {
              return GridViewWithData(
                snapshot: snapshot.data!,
                query: query,
                topPickedFilter: topPickedFilter,
                categoryFilter: categoryFilter,
                minPriceFilter: minPriceFilter,
                maxPriceFilter: maxPriceFilter,
                sortByTitleAZ: sortByTitleAZ,
              );
            }
          },
        ),
      ],
    );
  }

  Widget buildLoadingIndicator() {
    return const Align(
      alignment: Alignment.bottomCenter,
      child: CircularProgressIndicator(color: Colors.brown),
    );
  }

  Widget buildErrorWidget(dynamic error) {
    return Center(
      child: Text(
        'Error: $error',
        style: const TextStyle(color: Colors.red),
      ),
    );
  }
}

class GridViewWithData extends StatelessWidget {
  const GridViewWithData({
    Key? key,
    required this.snapshot,
    required this.query,
    this.topPickedFilter,
    this.categoryFilter,
    this.minPriceFilter,
    this.maxPriceFilter,
    this.sortByTitleAZ,
  }) : super(key: key);

  final QuerySnapshot snapshot;
  final String query;
  final bool? topPickedFilter;
  final String? categoryFilter;
  final int? minPriceFilter;
  final int? maxPriceFilter;
  final bool? sortByTitleAZ;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    List<DocumentSnapshot> filteredDocs = snapshot.docs.where((doc) {
      var data = doc.data() as Map<String, dynamic>;
      bool titleMatches =
          data['title'].toString().toLowerCase().contains(query.toLowerCase());
      bool provinceMatches = data['province']
          .toString()
          .toLowerCase()
          .contains(query.toLowerCase());
      bool priceAddress = data['address']
          .toString()
          .toLowerCase()
          .contains(query.toLowerCase());

      if (query.isEmpty || titleMatches || provinceMatches || priceAddress) {
        // Apply the filters
        if (topPickedFilter != null && data['isTopPicked'] != topPickedFilter) {
          return false;
        }

        if (categoryFilter != null &&
            !data['category']
                .toString()
                .toLowerCase()
                .contains(categoryFilter!)) {
          return false;
        }

        if (minPriceFilter != null &&
            (data['monthlyPrice'] as int) < minPriceFilter!) {
          return false;
        }

        if (maxPriceFilter != null &&
            (data['monthlyPrice'] as int) > maxPriceFilter!) {
          return false;
        }

        return true;
      }

      return false;
    }).toList();

    if (sortByTitleAZ == true) {
      filteredDocs.sort((a, b) => (a.data() as Map<String, dynamic>)['title']
          .compareTo((b.data() as Map<String, dynamic>)['title']));
    }

    if (filteredDocs.isEmpty) {
      return const NoResultsFoundWidget(message: 'No matching results found');
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Anúncios Listados: ${filteredDocs.length}',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16.0,
            letterSpacing: 2,
            color: Colors.brown,
          ),
        ),
        SizedBox(
          height: height,
          width: width,
          child: AlignedGridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 10,
            itemCount: filteredDocs.length,
            itemBuilder: (context, index) {
              var data = filteredDocs[index].data() as Map<String, dynamic>;

              return SizedBox(
                height: height * 0.30,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Stack(
                    children: [
                      CachedNetworkImage(
                        imageUrl: data['image'].first,
                        fit: BoxFit.fill,
                        height: height,
                        width: width,
                        placeholder: (context, str) => Center(
                          child: Image.asset('assets/loading.gif'),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Column(
                          children: [
                            Expanded(
                              child: Container(
                                height: 40,
                                width: width,
                                color: Colors.black.withOpacity(0.3),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0,
                                    vertical: 10.0,
                                  ),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        data['title'],
                                        softWrap: true,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18.0,
                                        ),
                                      ),
                                      Column(
                                        children: [
                                          TopPickedCardContent(
                                            content: data['province'],
                                            icon: FontAwesomeIcons.locationPin,
                                          ),
                                          TopPickedCardContent(
                                            content: data['address'],
                                            icon: FontAwesomeIcons.mapLocation,
                                          ),
                                          TopPickedCardContent(
                                            content:
                                                KwanzaFormatter.formatKwanza(
                                                    double.parse(
                                              data['monthlyPrice'].toString(),
                                            )),
                                            icon: FontAwesomeIcons.moneyBill,
                                          ),
                                        ],
                                      )
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
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class NoResultsFoundWidget extends StatelessWidget {
  const NoResultsFoundWidget({super.key, required this.message});
  final String message;
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Image.asset(
            'assets/not_found.jpg',
            height: 120.0,
            width: width,
            fit: BoxFit.cover,
          ),
          Text(
            message,
            style: const TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Colors.brown,
            ),
          ),
        ],
      ),
    );
  }
}

class ColoredRangeSlider extends StatefulWidget {
  ColoredRangeSlider({
    super.key,
    required this.values,
    required this.min,
    required this.max,
    required this.divisions,
    required this.onChanged,
  });

  RangeValues values;
  final double min;
  final double max;
  final int divisions;
  final ValueChanged<RangeValues> onChanged;

  @override
  State<ColoredRangeSlider> createState() => _ColoredRangeSliderState();
}

class _ColoredRangeSliderState extends State<ColoredRangeSlider> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.centerLeft,
      children: [
        Container(
          height: 6.0, // Customize the height of the background
          width: MediaQuery.of(context)
              .size
              .width, // Use the width of the screen or any desired width
          decoration: BoxDecoration(
            color:
                Colors.green.withOpacity(0.3), // Customize the background color
            borderRadius: BorderRadius.circular(
                10.0), // Customize the border radius if needed
          ),
        ),
        SfSlider.vertical(
          min: 0.0,
          max: 100.0,
          value: widget.values,
          interval: 20,
          showTicks: true,
          showLabels: true,
          enableTooltip: true,
          minorTicksPerInterval: 1,
          onChanged: (dynamic value) {
            setState(() {
              widget.values = value;
            });
          },
        ),
      ],
    );
  }
}
