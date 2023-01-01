import 'filtered_advertisiment.dart';

class FilteredAdvertisimentScreen extends StatelessWidget {
  static const routeName = '/filtered-Advertisiment-screen';
  const FilteredAdvertisimentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: FilteredAdvertisimentCard(),
        ),
      ),
    );
  }
}
