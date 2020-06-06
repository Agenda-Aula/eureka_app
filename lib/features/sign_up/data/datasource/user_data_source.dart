import 'package:app/features/sign_up/data/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserDataSourceImp extends UserDataSource {

  final _firebaseAuth = FirebaseAuth.instance;
  final _googleSignIn = GoogleSignIn();

  @override
  Future<UserModel> signUp(String email, String password) async {
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

  @override
  Future<void> signInWithCredentials(String email, String password) async {
    return await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

	Future<void> signInWithGoogle() async {
		final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
		final GoogleSignInAuthentication googleAuth =
		await googleUser.authentication;
		final AuthCredential credential = GoogleAuthProvider.getCredential(
			accessToken: googleAuth.accessToken,
			idToken: googleAuth.idToken,
		);
		await _firebaseAuth.signInWithCredential(credential);
	}
}

abstract class UserDataSource {
	Future<UserModel> signUp(String email, String password);

	Future<void> signInWithGoogle();

	Future<void> signInWithCredentials(String email, String password);

	Future<void> signOut();

	Future<UserModel> isSignIn();


}
