import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sports_meet/core/models/user.dart';

class FireStoreService {

  final CollectionReference _collectionReference = FirebaseFirestore.instance.collection('users');

  Future createUser({required UserModel user}) async {
    await _collectionReference.doc(user.id).set(user.toJson());
  }

  Future getUser(String uid) async {
    var userData = await _collectionReference.doc(uid).get();
    return UserModel.fromJson(userData.data());
  }
  
  Future updateUser(String uid, Map<String, dynamic> json) async {
    await _collectionReference.doc(uid).update(json);
  }

}