import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/route_manager.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:rent_house_app/features/presentation/home/home.dart';

class AuthService {
//Google Sign In
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
}
