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
  late bool isButtonSelected;
  final double minPrice = 5000.0;
  final double maxPrice = 500000.0;
  final double priceIncrement = 1000.0;
  List<bool> buttonSelectedStates = [true, false, false, false, false, false];

  int get divisions {
    return ((maxPrice - minPrice) / priceIncrement).ceil();
  }

  @override
  void initState() {
    isVisible = false;
    isButtonSelected = false;
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
                  _buildFilterButton(
                    buttonText: 'Todos',
                    onPressed: () {
                      setState(() {
                        topPickedFilter = null;
                        categoryFilter = null;
                        minPriceFilter = null;
                        maxPriceFilter = null;
                        sortByTitleAZ = false;
                        isButtonSelected = !isButtonSelected;
                      });
                    },
                    isSelected: buttonSelectedStates[0],
                    index: 0,
                  ),
                  _buildFilterButton(
                    buttonText: sortByTitleAZ ? 'Ordenar ZA' : 'Ordenar AZ',
                    onPressed: () {
                      setState(() {
                        sortByTitleAZ = !sortByTitleAZ;
                        isButtonSelected = !isButtonSelected;
                      });
                    },
                    isSelected: buttonSelectedStates[1],
                    index: 1,
                  ),
                  _buildFilterButton(
                    buttonText: 'Promoções',
                    onPressed: () {
                      setState(() {
                        topPickedFilter = true;
                        isButtonSelected = !isButtonSelected;
                      });
                    },
                    isSelected: buttonSelectedStates[2],
                    index: 2,
                  ),
                  _buildFilterButton(
                    buttonText: 'Apartamentos',
                    onPressed: () {
                      setState(() {
                        categoryFilter = 'apartamentos';
                        isButtonSelected = !isButtonSelected;
                      });
                    },
                    isSelected: buttonSelectedStates[3],
                    index: 3,
                  ),
                  _buildFilterButton(
                    buttonText: 'Casas',
                    onPressed: () {
                      setState(() {
                        categoryFilter = 'casa';
                        isButtonSelected = !isButtonSelected;
                      });
                    },
                    isSelected: buttonSelectedStates[4],
                    index: 4,
                  ),
                  _buildFilterButton(
                    buttonText: 'Quartos',
                    onPressed: () {
                      setState(() {
                        categoryFilter = 'quartos';
                        isButtonSelected = !isButtonSelected;
                      });
                    },
                    isSelected: buttonSelectedStates[5],
                    index: 5,
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

  Widget _buildFilterButton({
    required String buttonText,
    required VoidCallback onPressed,
    required bool isSelected,
    required int index,
  }) {
    return ElevatedButton(
      onPressed: () {
        onPressed();
        setState(() {
          for (int i = 0; i < buttonSelectedStates.length; i++) {
            buttonSelectedStates[i] = i == index;
          }
        });
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? Colors.brown : Colors.brown.shade300,
        foregroundColor: isSelected ? Colors.white : Colors.black,
        elevation: 2,
        padding: const EdgeInsets.all(5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(2.0),
        ),
      ),
      child: Text(buttonText),
    );
  }
}
