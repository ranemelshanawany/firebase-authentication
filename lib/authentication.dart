import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';

class Authentication {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FacebookLogin facebookSignIn = new FacebookLogin();

  Future<FirebaseUser> signInWithGoogle() async {
    try {
      final GoogleSignInAccount googleSignInAccount =
          await googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      final AuthResult authResult =
          await _auth.signInWithCredential(credential);
      final FirebaseUser user = authResult.user;

      assert(!user.isAnonymous);
      assert(await user.getIdToken() != null);
      final FirebaseUser currentUser = await _auth.currentUser();
      assert(user.uid == currentUser.uid);

      return user;
    } on Exception catch (e) {
      return null;
    }
  }

  Future<FirebaseUser> signInWithFacebook() async {
    try {
      final FacebookLoginResult result = await facebookSignIn.logIn(['email']);

      if (result.status == FacebookLoginStatus.loggedIn) {
        FacebookAccessToken facebookAccessToken = result.accessToken;
        final AuthCredential credential = FacebookAuthProvider.getCredential(
            accessToken: facebookAccessToken.token);

        final AuthResult authResult =
            await _auth.signInWithCredential(credential);
        final FirebaseUser user = authResult.user;

        assert(user.email != null);
        assert(user.displayName != null);

        assert(!user.isAnonymous);
        assert(await user.getIdToken() != null);
        FirebaseUser currentUser = await _auth.currentUser();
        assert(user.uid == currentUser.uid);

        return user;
      } else {
        print(result.errorMessage);
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  void signOut() async {
    await facebookSignIn.logOut();
    await googleSignIn.signOut();
    await _auth.signOut();

    print("User Sign Out");
  }
}
