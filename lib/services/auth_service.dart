import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuthService {
  static GoogleSignIn _googleSignin = GoogleSignIn();
  Future<void> loginbygoogle() async {
    final GoogleSignInAccount? googleUser = await _googleSignin.signIn();
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    print(googleUser?.displayName);
    print(googleAuth?.accessToken);
    print(googleAuth?.idToken);

    final Credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(Credential);
    print(userCredential.user);
  }

  Future<void> googlelogout() async {
    await FirebaseAuth.instance.signOut().then((value) {
      _googleSignin.signOut();
    });
  }
}
