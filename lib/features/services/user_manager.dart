import '../../app/app.dart';
import 'services.dart';

class UserManager extends ChangeNotifier {
  //? Firebase
  final CollectionReference _ref =
      FirebaseFirestore.instance.collection('users');
  final CollectionReference _sellerRef =
      FirebaseFirestore.instance.collection('seller');
  final FirebaseStorage _storage = FirebaseStorage.instance;
  late final FirebaseAuth _firebaseAuth;

  UserManager() {
    _firebaseAuth = FirebaseAuth.instance;
  }

  //? Create User - Create User Info On Firebase Firestore
  Future<void> create(UserModel user) async {
    try {
      return await _ref.doc(user.id).set(user.toJson());
    } on FirebaseException catch (e) {
      log('Create Error: ${e.toString()}');
    }
    notifyListeners();
  }

  //? Get Current User
  User getUser() {
    notifyListeners();
    return _firebaseAuth.currentUser!;
  }

  //? Get Seller By ID
  Stream<UserModel> getUserById(String id) {
    notifyListeners();
    return _ref.doc(id).snapshots().map((documentSnapshot) {
      if (documentSnapshot.exists) {
        return UserModel.fromJson(
          documentSnapshot.data() as Map<String, dynamic>,
        );
      } else {
        // Return null if the document doesn't exist
        return UserModel();
      }
    });
  }

  Stream<SellerModel> getSellerById(String id) {
    notifyListeners();
    return _sellerRef.doc(id).snapshots().map((documentSnapshot) {
      if (documentSnapshot.exists) {
        return SellerModel.fromJson(
          documentSnapshot.data() as Map<String, dynamic>,
        );
      } else {
        // Return null if the document doesn't exist
        return SellerModel();
      }
    });
  }

  //? Update user device token
  Future<void> updateData(Map<String, dynamic> data, String id) async {
    return _ref.doc(id).update(data);
  }

  Future<String> uploadPicture(String filePath, String? imageName) async {
    XFile file = XFile(filePath);

    try {
      await _storage.ref('profilePics/$imageName').putFile(File(file.path));
    } on FirebaseException catch (e) {
      log('Upload: $e');
    }

    String downloadUrl =
        await _storage.ref('profilePics/$imageName').getDownloadURL();
    log('DownloadUrl Manager: $downloadUrl');
    return downloadUrl;
  }
}
