import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:sports_meet/core/models/user.dart';
import 'package:sports_meet/core/services/firebase_service.dart';
import 'package:sports_meet/core/services/firestore_service.dart';

class AuthenticationService extends ChangeNotifier {
  UserModel? _currentUser;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FireBaseService _fireBaseService = FireBaseService();
  final FireStoreService _fireStoreService = FireStoreService();
  Duration timeOutLimit = const Duration(seconds: 20);

  UserModel? get currentUser => _currentUser;


  Future _populateCurrentUser(String? uid) async {
    if (uid != null){
      UserModel userModel = await _fireStoreService.getUser(uid);
      if (userModel.verified){
        _currentUser = userModel;
        notifyListeners();
      }
    }
  }

  Future<UserCredential> registerUser({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await _fireBaseService
          .signUpUser(email: email, password: password)
          .timeout(timeOutLimit);
      return userCredential;
    } on IOException catch (e) {
      throw SocketException("IOException has occurred: $e");
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateUser ({required String uid, required Map<String, dynamic> json,}) async {
    await _fireStoreService.updateUser(uid, json);
    await _populateCurrentUser(uid);
  }

  Future<UserCredential> loginUserEmail({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential =
          await _fireBaseService.signInUser(email: email, password: password).timeout(timeOutLimit);
      return userCredential;
    } on IOException catch (e) {
      throw SocketException("IOException has occurred: $e");
    } catch (e) {
      rethrow;
    }
  }
  
  Future forgotPassword({required String email}) async {
    await _fireBaseService.resetPassword(email: email).timeout(timeOutLimit);
  }

  Future<bool?> isUserLoggedIn() async {
    User? user = _auth.currentUser;
    await _populateCurrentUser(user?.uid);
    return currentUser?.verified;
  }

  void logOut() async {
    await _auth.signOut();
  }
}
