import 'package:app/features/sign_up/data/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class RegisterUserDataSourceImp extends RegisterUserDataSource {
  final _firebaseAuth = FirebaseAuth.instance;
  final googleSignIn = GoogleSignIn();

  @override
  Future<UserModel> createAccount(String email, String password) async {
    final authResult = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    return UserModel(
        email: authResult.user.email, displayName: authResult.user.displayName);
  }
}

abstract class RegisterUserDataSource {
  Future<UserModel> createAccount(String email, String password);
}
