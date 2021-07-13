import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

final _auth = FirebaseAuth.instance;
final googleSignIn = GoogleSignIn(hostedDomain: 'sci.pdn.ac.lk');

//TODO: Add email authentication logic

Future<User> signInWithGoogle() async {
  await Firebase.initializeApp();

  final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
  final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;

  Map<String, dynamic> decodedToken = JwtDecoder.decode(googleSignInAuthentication.idToken);

  if (decodedToken['hd'] == 'sci.pdn.ac.lk') {
    final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken, idToken: googleSignInAuthentication.idToken);

    final UserCredential authResult = await _auth.signInWithCredential(credential);
    final User user = authResult.user;

    if (user != null) {
      assert(user.email != null);
      assert(user.displayName != null);
      assert(user.photoURL != null);
      assert(!user.isAnonymous);
      assert(await user.getIdToken() != null);

      final User currentUser = _auth.currentUser;
      assert(user.uid == currentUser.uid);

      print('Sign in with google succeded: $user');

      return user;
    }
  }
  return null;
}

Future<void> signOutGoogle() async {
  await googleSignIn.signOut();
  _auth.signOut();
  print('User signed out');
}

Future<void> googleDisconnect() async {
  await googleSignIn.disconnect();
  _auth.signOut();
}
