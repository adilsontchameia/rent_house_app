import '../filtered_advertisiment.dart';

class FilteredAdvertisimentCard extends StatefulWidget {
  FilteredAdvertisimentCard({
    Key? key,
  }) : super(key: key);

  final AdvertisementModel advertisement = AdvertisementModel();

  @override
  State<FilteredAdvertisimentCard> createState() =>
      _FilteredAdvertisimentCardState();
}

class _FilteredAdvertisimentCardState extends State<FilteredAdvertisimentCard> {
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
                        categoryFilter = 'apartamentos';
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
                        categoryFilter = 'quartos';
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
              return const CircularProgressOnFecthing();
            } else if (snapshot.hasError) {
              return const ErrorIconOnFetching();
            } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              if (query.isEmpty) {
                return const NoResultsFoundWidget();
              } else {
                return const NoResultsFoundWidget();
              }
            } else {
              //TODO implement
              //AdvertisementModel advertisement = snapshot.data![index];

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
}
