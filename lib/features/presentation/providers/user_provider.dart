import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rent_house_app/features/presentation/home/home.dart';
import 'package:rent_house_app/features/services/auth_service.dart';
import 'package:rent_house_app/features/services/user_manager.dart';
import 'dart:developer';
import 'dart:io';

import 'package:geolocator/geolocator.dart';

import 'package:permission_handler/permission_handler.dart' as permission;
import 'package:location_geocoder/location_geocoder.dart';
import 'package:rent_house_app/helpers/factories/dialogs.dart';

class UserAuthProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();
  final UserManager _userManager = UserManager();
  final String kAPiKey = 'AIzaSyAFNp_Brt4Bdmek4Jr1iau7RYYIbIL5h6g';
  Position? position;
  StreamSubscription? _gpsStatusSubscription;
  //ErrorMessage
  String? error;
  //ShopData
  double? userAddressLatitude;
  double? userAddressLongitude;
  bool permissionAllowed = false;
  String featureName = '';
  String addressLine = '';
  String userAddress = '';
  String? userEmail;
  String? pickedError;
  bool? gpsEnabled;
  //Image Utils
  XFile? fileImage;
  bool isReady = false;
  final ShowAndHideDialogs _dialogs = ShowAndHideDialogs();

  void init() async {
    final status = await permission.Permission.locationWhenInUse.request();
    if (status == permission.PermissionStatus.granted) {
      await getCurrentLocation();
    }
    _verifyGpsStatus();
  }

  @override
  void dispose() {
    super.dispose();
    _gpsStatusSubscription?.cancel();
  }

  Future<void> _verifyGpsStatus() async {
    try {
      gpsEnabled = await Geolocator.isLocationServiceEnabled();
      _gpsStatusSubscription =
          Geolocator.getServiceStatusStream().listen((status) {
        gpsEnabled = status == ServiceStatus.enabled;
        notifyListeners();
      });
      final status = await permission.Permission.locationWhenInUse.request();

      switch (status) {
        case permission.PermissionStatus.denied:
          if (Platform.isIOS || Platform.isAndroid) {
            permission.openAppSettings();
          }
          //if (Platform.isAndroid) showToastMessage('Permission Danied');
          break;
        case permission.PermissionStatus.granted:
          debugPrint('Has Permission');
          break;
        case permission.PermissionStatus.restricted:
          debugPrint('Permission Restricted');
          break;
        case permission.PermissionStatus.limited:
          debugPrint('Permission Limited');
          break;
        case permission.PermissionStatus.provisional:
          debugPrint('Provisional Limited');
          break;
        case permission.PermissionStatus.permanentlyDenied:
          permission.openAppSettings();
          break;
      }
    } on Geolocator catch (e) {
      log(e.toString());
    }
  }

  Future<void> getCurrentLocation() async {
    try {
      position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      userAddressLatitude = position!.latitude;
      userAddressLongitude = position!.longitude;
      final coordinates = Coordinates(
        userAddressLatitude,
        userAddressLongitude,
      );
      final LocatitonGeocoder geocoder = LocatitonGeocoder(kAPiKey);
      final address = await geocoder.findAddressesFromCoordinates(coordinates);
      featureName = address.first.featureName!;
      addressLine = address.first.addressLine!;
      userAddress = '$featureName\n$addressLine';
      log(userAddress);
      log(userAddressLatitude.toString());
      log(userAddressLongitude.toString());
      notifyListeners();
      permissionAllowed = true;
    } catch (e) {
      //_dialogs.showToastMessage('Não foi possivel determinar sua localização, por favor, tente novamente.');
      log('Location Exeption: $e');
    }
  }

//Register User Using Email
  Future<void> signUp({
    String? name,
    String? email,
    String? phone,
    String? address,
    var latitude,
    var longitude,
    String? password,
    XFile? image,
  }) async {
    try {
      _dialogs.showProgressIndicator();
      position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      if (isReady) {
        //GetImage URL to store to DB
        final String imageUrl = await _userManager
            .uploadPicture(image!.path, DateTime.now().toString())
            .then((url) async {
          await _authService.register(
            name: name,
            email: email,
            phone: phone,
            address: address,
            latitude: position!.latitude,
            longitude: position!.longitude,
            location: GeoPoint(position!.latitude, position!.longitude),
            password: password,
            image: url,
          );

          await _userManager.create(_authService.user);
          _dialogs.disposeProgressIndicator();
          Get.off(() => const HomeScreen());

          return url;
        });
      } else {
        log('Nulo');
      }
    } on FirebaseAuthException catch (e) {
      _dialogs.disposeProgressIndicator();
      if (e.code == 'email-already-in-use') {
        _dialogs.showToastMessage(
            'E-mail in Use: This e-mail is already in use, if it might be a error, please contact the Support Team.');
      } else if (e.code == 'invalid-email') {
        _dialogs.showToastMessage(
            'Invalid E-mail: You entered an invalid e-mail address.');
      } else if (e.code == 'operation-not-allowed') {
        _dialogs.showToastMessage(
            'email/password accounts are not enabled. Enable email/password accounts in the Firebase Console, under the Auth tab');
      } else if (e.code == 'weak-password') {
        _dialogs.showToastMessage(
            'Weak Password: The password is not strong enough.');
      } else if (e.code == 'network-request-failed') {
        _dialogs.showToastMessage(
            'Internet Connection: Please, check your internet connection before proceed.');
      } else {
        _dialogs.showToastMessage('Unkown Error: $e.');
      }
    } catch (e) {
      _dialogs.disposeProgressIndicator();
      log('Register: $e');
    }
    notifyListeners();
  }

  Future<void> login(String email, String password) async {
    try {
      _dialogs.showProgressIndicator();
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then((_) {
        _dialogs.disposeProgressIndicator();
        Get.off(() => const HomeScreen());
      });
    } on FirebaseAuthException catch (e) {
      _dialogs.disposeProgressIndicator();
      if (e.code == 'user-not-found') {
        _dialogs.showToastMessage('User not Found: Please check your email.');
      } else if (e.code == 'wrong-password') {
        _dialogs.showToastMessage(
            'Wrong Password: Please check it before proceed.');
      } else if (e.code == 'invalid-email') {
        _dialogs.showToastMessage(
            'Invalid E-mail: Please check your email, it might be wrong.');
      } else if (e.code == 'user-disabled') {
        _dialogs.showToastMessage(
            'User Disabled: This account has been disabled by the ADMIN, please contact the Support Team.');
      } else if (e.code == 'too-many-requests') {
        _dialogs.showToastMessage(
            'Too Many Requests: Please take a break and hold on some minutes.');
      } else if (e.code == 'network-request-failed') {
        _dialogs.showToastMessage(
            'Internet Connection: Please, check your internet connection before proceed.');
      } else {
        _dialogs.showToastMessage(
            'Unknown Error: Unknown error, please contact the Support Team.');
      }
    }

    notifyListeners();
  }

  Future<void> resetPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        error = 'No user found for that email.';
        debugPrint(error);
      } else if (e.code == 'wrong-password') {
        error = 'Wrong password provided for that user.';
        debugPrint(error);
      }
    }
    notifyListeners();
  }

  Future<XFile> getGalleryImage() async {
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 20,
      );

      if (pickedFile != null) {
        fileImage = XFile(pickedFile.path);
      } else {
        pickedError = 'No Image Selected';
        debugPrint(pickedError);
      }
    } catch (e) {
      log('Image: $e');
    }

    notifyListeners();
    return fileImage!;
  }

  Future<XFile> getCameraImage() async {
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 20,
      );

      if (pickedFile != null) {
        fileImage = XFile(pickedFile.path);
      } else {
        pickedError = 'No Image Selected';
      }
    } catch (e) {
      log('Image: $e');
    }

    notifyListeners();
    return fileImage!;
  }
}
