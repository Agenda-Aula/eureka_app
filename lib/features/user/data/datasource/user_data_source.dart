import 'package:app/features/user/data/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class RegisterUserDataSourceImp extends UserDataSource {
  final _firebaseAuth = FirebaseAuth.instance;
  final googleSignIn = GoogleSignIn();

  @override
  Future<UserModel> createAccount(String email, String password) async {
    final result = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);

    return UserModel(
      email: result.user.email,
      profileUrl: result.user.photoUrl,
      displayName: result.user.displayName,
    );
  }

  @override
  Future<UserModel> isSignIn() async {
    final currentUser = await _firebaseAuth.currentUser();
    if (currentUser == null) {
      return null;
    }
    return UserModel(
        email: currentUser.email,
        profileUrl: currentUser.photoUrl,
        displayName: currentUser.displayName);
  }

  @override
  Future<void> signOut() => _firebaseAuth.signOut();
}

abstract class UserDataSource {

  Future<UserModel> isSignIn();

  Future<void> signOut();

  Future<UserModel> createAccount(String email, String password);
}
