import 'package:app/features/auth/data/models/user_auth_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthDataSourceImp extends AuthDataSource {
  final _firebaseAuth = FirebaseAuth.instance;
  final googleSignIn = GoogleSignIn();

  @override
  Future<UserAuthModel> createAccount(String email, String password) async {
    final authResult = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    return UserAuthModel.mapFrom(authResult.user);
  }

  @override
  Future<UserAuthModel> currentUser() async {
    final firebaseUser = await _firebaseAuth.currentUser();
    return UserAuthModel.mapFrom(firebaseUser);
  }

  @override
  Stream<UserAuthModel> get onAuthStateChanged =>
      _firebaseAuth.onAuthStateChanged
          .map((firebaseUser) => UserAuthModel.mapFrom(firebaseUser));

  @override
  Future<UserAuthModel> signIn(String email, String password) async {
    final authResult = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    return UserAuthModel.mapFrom(authResult.user);
  }

  @override
  Future<UserAuthModel> signInWithGoogle() async {
    final googleAccount = await googleSignIn.signIn();
    if (googleAccount != null) {
      final authResult = await _googleAuthResult();
      return UserAuthModel.mapFrom(authResult.user);
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
  Future<UserAuthModel> createAccount(String email, String password);

  Future<UserAuthModel> signIn(String email, String password);

  Future<bool> signOut();

  Future<UserAuthModel> signInWithGoogle();

  Future<UserAuthModel> currentUser();

  Stream<UserAuthModel> get onAuthStateChanged;
}
