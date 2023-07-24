import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

import '../data/models/user_model.dart';

class UserManager {
  //? Firebase
  final CollectionReference _ref =
      FirebaseFirestore.instance.collection('users');
  final FirebaseStorage _storage = FirebaseStorage.instance;

  //? Create User - Create User Info On Firebase Firestore
  Future<void> create(UserModel user) async {
    try {
      return await _ref.doc(user.id).set(user.toJson());
    } on FirebaseException catch (e) {
      log('Create Error: ${e.toString()}');
    }
  }

  //? Get User By ID
  Future<UserModel> getById(String id) async {
    DocumentSnapshot document = await _ref.doc(id).get();

    if (document.exists) {
      UserModel user =
          UserModel.fromJson(document.data() as Map<String, dynamic>);
      return user;
    }

    return UserModel();
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
