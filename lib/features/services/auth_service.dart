import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/route_manager.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:rent_house_app/features/data/models/user_model.dart';
import 'package:rent_house_app/features/presentation/home/home.dart';
import 'package:rent_house_app/features/presentation/login/login_screen.dart';

class AuthService {
  //? Firebase
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  UserModel user = UserModel();

  //? Get Current User
  User getUser() {
    return _firebaseAuth.currentUser!;
  }

  //? Google Sign In
  Future<void> signInWithGoogle() async {
    try {
      //Show signin process
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      //Obtain auth details from request
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;

      //Create new credential ofr user
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      if (userCredential.user != null) {
        log(userCredential.user!.displayName!);
        Get.off(() => const HomeScreen());

        log(userCredential.user!.displayName!);
      } else {
        log('Login Error');

        log(userCredential.user!.displayName!);
      }

      //SignIn
    } on FirebaseAuthException catch (e) {
      log('Google: ${e.toString}');
    }
  }

  //? Login With Email and Password
  Future<void> login(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      log('SignIn: $e');
    }
  }

  //? Register With Email and Password
  Future<UserModel> register({
    String? name,
    String? email,
    String? phone,
    String? address,
    String? password,
    double? latitude,
    double? longitude,
    GeoPoint? location,
    String? image,
  }) async {
    await _firebaseAuth
        .createUserWithEmailAndPassword(
      email: email!,
      password: password!,
    )
        .then((_) async {
      user = UserModel(
        id: getUser().uid,
        name: name,
        email: email,
        phone: phone,
        address: address,
        latitude: latitude,
        longitude: longitude,
        location: GeoPoint(latitude!, longitude!),
        image: image,
      );
    });
    return user;
  }

  //? Sign-Out
  Future<void> signOut() async {
    await _firebaseAuth
        .signOut()
        .then((_) => Get.off(() => const LoginScreen()));
  }
}
