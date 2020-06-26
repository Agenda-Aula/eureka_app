import 'package:app/features/authentication/data/models/auth_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationServiceImp extends AuthenticationService {

  final _firebaseAuth = FirebaseAuth.instance;
  final _googleSignIn = GoogleSignIn();

  @override
  Future<AuthModel> signUp(String email, String password) async {
    final authResult = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);

    return AuthModel(
      email: authResult.user.email,
      profileUrl: authResult.user.photoUrl,
      displayName: authResult.user.displayName,
    );
  }

  @override
  Future<AuthModel> getAuthenticatedUser() async {
    final currentUser = await _firebaseAuth.currentUser();
    if (currentUser == null) {
      return null;
    }
    return AuthModel(
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

abstract class AuthenticationService {
	Future<AuthModel> signUp(String email, String password);

	Future<void> signInWithGoogle();

	Future<void> signInWithCredentials(String email, String password);

	Future<void> signOut();

	Future<AuthModel> getAuthenticatedUser();
}
