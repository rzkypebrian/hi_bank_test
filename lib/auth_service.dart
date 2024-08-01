import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final GoogleSignIn googleSignIn = GoogleSignIn();

  Future<GoogleSignInAccount?> signInWithGoogle() async {
    try {
      return await googleSignIn.signIn();
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<void> signOut() async {
    await googleSignIn.signOut();
  }
}
