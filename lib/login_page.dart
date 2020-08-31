import 'package:flutter/material.dart';
import 'package:login_demo/authentication.dart';
import 'first_screen.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _googleSignInButton(),
              SizedBox(height: 10),
              _facebookSignInButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _googleSignInButton() {
    return OutlineButton(
      splashColor: Colors.grey,
      onPressed: () {_signInGoogle(); },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      highlightElevation: 0,
      borderSide: BorderSide(color: Colors.grey),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _displayAssetImage("images/google_logo.png", 35),
            _displayButtonText('Sign in with Google')
          ],
        ),
      ),
    );
  }

  _signInGoogle()
  {
    Authentication().signInWithGoogle().then((value) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) {
            return FirstScreen(user: value);
          },
        ),
      );
    });
  }

  Widget _facebookSignInButton() {
    return OutlineButton(
      splashColor: Colors.grey,
      onPressed: () {_signInFacebook();},
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular((40))),
      highlightElevation: 0,
      borderSide: BorderSide(color: Colors.grey),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _displayAssetImage("images/facebook_logo.png", 40),
            _displayButtonText("Sign in with Facebook")
          ],
        ),
      ),
    );
  }

  _signInFacebook()
  {
    Authentication().signInWithFacebook().then((value) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) {
            return FirstScreen(user: value);
          },
        ),
      );
    });
  }

  _displayAssetImage(String image, double size)
  {
    return Image(
      image: AssetImage(image),
      height: size,
    );
  }

  _displayButtonText(String txt)
  {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Text(
        txt,
        style: TextStyle(
          fontSize: 20,
          color: Colors.grey,
        ),
      ),
    );
  }
}
