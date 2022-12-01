import 'package:firebase_auth/firebase_auth.dart';

class FireBaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;


  Future<UserCredential> signUpUser({required String email, required String password}) async {
    return await _auth.createUserWithEmailAndPassword(email: email, password: password);
  }

  Future<UserCredential> signInUser({required String email, required String password}) async {
    return await _auth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future resetPassword({required String email}) async {
    return await _auth.sendPasswordResetEmail(email: email);
  }

}