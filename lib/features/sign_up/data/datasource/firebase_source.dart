import 'package:app/features/sign_up/data/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthDataSourceImp extends AuthDataSource {
  final _firebaseAuth = FirebaseAuth.instance;
  final googleSignIn = GoogleSignIn();

  @override
  Future<UserModel> createAccount(String email, String password) async {
    final authResult = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    return UserModel.mapFrom(authResult.user);
  }

  @override
  Future<UserModel> currentUser() async {
    final firebaseUser = await _firebaseAuth.currentUser();
    return UserModel.mapFrom(firebaseUser);
  }

  @override
  Stream<UserModel> get onAuthStateChanged =>
      _firebaseAuth.onAuthStateChanged
          .map((firebaseUser) => UserModel.mapFrom(firebaseUser));

  @override
  Future<UserModel> signIn(String email, String password) async {
    final authResult = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    return UserModel.mapFrom(authResult.user);
  }

  @override
  Future<UserModel> signInWithGoogle() async {
    final googleAccount = await googleSignIn.signIn();
    if (googleAccount != null) {
      final authResult = await _googleAuthResult();
      return UserModel.mapFrom(authResult.user);
    }
    return null;
  }

  @override
  Future<bool> signOut() async {
    _firebaseAuth.signOut();
    final userAuth = await _firebaseAuth.currentUser();
    if (userAuth == null) {
      return true;
    } else {
      return false;
    }
  }

  Future<AuthResult> _googleAuthResult() async {
    final googleAccount = await googleSignIn.signIn();
    GoogleSignInAuthentication googleAuth = await googleAccount.authentication;
    final authResult = await _firebaseAuth.signInWithCredential(
      GoogleAuthProvider.getCredential(
        idToken: googleAuth.idToken,
        accessToken: googleAuth.accessToken,
      ),
    );
    return authResult ?? null;
  }
}

abstract class AuthDataSource {
  Future<UserModel> createAccount(String email, String password);

  Future<UserModel> signIn(String email, String password);

  Future<bool> signOut();

  Future<UserModel> signInWithGoogle();

  Future<UserModel> currentUser();

  Stream<UserModel> get onAuthStateChanged;
}
