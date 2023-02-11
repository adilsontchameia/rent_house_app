import 'services.dart';

class HomeAdvertisementManager {
  //? Firebase
  final CollectionReference _ref = FirebaseFirestore.instance.collection('ads');

  //? Get all sales
  Stream<List<AdvertisementModel>> getAllSales() {
    return _ref.snapshots().map((querySnapshot) {
      List<AdvertisementModel> sales = [];

      for (var document in querySnapshot.docs) {
        print("Document data: ${document.data()}");

        AdvertisementModel sale = AdvertisementModel.fromJson(
            document.data() as Map<String, dynamic>);
        sales.add(sale);
      }

      return sales;
    });
  }

  Stream<List<AdvertisementModel>> getSlideSales() {
    return _ref
        .where(
          'isPromo',
          isEqualTo: true,
        )
        .snapshots()
        .map((querySnapshot) {
      List<AdvertisementModel> sales = [];
      for (var document in querySnapshot.docs) {
        AdvertisementModel sale = AdvertisementModel.fromJson(
            document.data() as Map<String, dynamic>);
        sales.add(sale);
      }
      return sales;
    });
  }

  Future<AdvertisementModel> getById(String id) async {
    DocumentSnapshot document = await _ref.doc(id).get();

    if (document.exists) {
      AdvertisementModel advertisementModel =
          AdvertisementModel.fromJson(document.data() as Map<String, dynamic>);
      return advertisementModel;
    }

    return AdvertisementModel();
  }

  Future<void> updateData(Map<String, dynamic> data, String id) async {
    return _ref.doc(id).update(data);
  }
}
