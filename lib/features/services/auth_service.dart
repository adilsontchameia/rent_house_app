import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:rent_house_app/app/app.dart';
import 'package:rent_house_app/core/factories/dialogs.dart';
import 'package:rent_house_app/features/data/models/user_model.dart';

class AuthService {
  //? Firebase
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  UserModel user = UserModel();

  final ShowAndHideDialogs _dialogs = ShowAndHideDialogs();

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
        Get.off(() => const HomeResumeScreen());

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
  Future<void> login(
      BuildContext context, String email, String password) async {
    _dialogs.showProgressIndicator();
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      _dialogs.disposeProgressIndicator();
    } on FirebaseAuthException catch (e) {
      _dialogs.disposeProgressIndicator();
      if (e.code == 'user-not-found') {
        _dialogs.showToastMessage(
            'Usuário Não Encontrado: Certifique-se de ter já uma conta criada.');
      } else if (e.code == 'wrong-password') {
        _dialogs.showToastMessage(
            'Senha Errada: Por favor, revise sua senha antes de prosseguir.');
      } else if (e.code == 'invalid-email') {
        _dialogs.showToastMessage(
            'Email inválido: Por favor, revise seu email antes de prosseguir.');
      } else if (e.code == 'user-disabled') {
        _dialogs.showToastMessage(
            'Usuário Desabilitado: Sua conta foi DESATIVADA, por favor consulte o Suporte Técnico.');
      } else if (e.code == 'too-many-requests') {
        _dialogs.showToastMessage(
            'Requisições: Por favor, tente novamente depois de alguns minutos.');
      } else if (e.code == 'network-request-failed') {
        _dialogs.showToastMessage(
            'Conexão à Internet: Por favor, verifique sua internet antes de prosseguir.');
      } else {
        _dialogs.showToastMessage(
            'Erro Desconhecido: Ocorreu um erro desconhecido, por favor, contacte o Suporte Técnico.');
      }
    }
  }

  //? Register With Email and Password
  Future<UserModel> register({
    String? firstName,
    String? surnName,
    String? phone,
    String? email,
    String? address,
    String? password,
    double? latitude,
    double? longitude,
    String? image,
  }) async {
    try {
      log('Email Service:${email!}');
      await _firebaseAuth
          .createUserWithEmailAndPassword(
        email: email,
        password: password!,
      )
          .then((_) async {
        user = UserModel(
          id: getUser().uid,
          firstName: firstName,
          surnName: surnName,
          fullName: '$firstName $surnName',
          phone: phone,
          email: email,
          address: address,
          latitude: latitude,
          longitude: longitude,
          isTyping: false,
          isOnline: true,
          image: image,
        );
      });
      return user;
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
    }
    return UserModel();
  }

  //? Sign-Out
  Future<void> signOut() async {
    await _firebaseAuth
        .signOut()
        .then((_) => Get.off(() => const LoginScreen()));
  }
}
