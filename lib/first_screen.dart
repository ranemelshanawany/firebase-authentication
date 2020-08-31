import 'package:flutter/material.dart';
import 'login_page.dart';
import 'authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirstScreen extends StatelessWidget {
  final FirebaseUser user;

  FirstScreen({Key key, @required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Colors.blue[100], Colors.blue[400]],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              _displayImage(),
              SizedBox(height: 40),
              _displayTitleText("NAME"),
              _displayDetailsText(user.displayName),
              SizedBox(height: 20),
              _displayTitleText("EMAIL"),
              _displayDetailsText(user.email),
              SizedBox(height: 40),
              _buildSignOutButton(context)
            ],
          ),
        ),
      ),
    );
  }

  _displayImage() {
    return CircleAvatar(
      backgroundImage: NetworkImage(
        user.photoUrl,
      ),
      radius: 60,
      backgroundColor: Colors.transparent,
    );
  }

  _displayTitleText(String txt) {
    return Text(
      txt,
      style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
          color: Colors.black54),
    );
  }

  _displayDetailsText(String txt) {
    return Text(
        txt,
        style: TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.bold,
        color: Colors.deepPurple,)
    );
  }

  _buildSignOutButton(context)
  {
    return RaisedButton(
      onPressed: () {
        _returnToLogin(context);
      },
      color: Colors.deepPurple,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          'Sign Out',
          style: TextStyle(fontSize: 25, color: Colors.white),
        ),
      ),
      elevation: 5,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40)),
    );
  }

  _returnToLogin(context)
  {
    Authentication().signOut();
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) {
          return LoginPage();
        }), ModalRoute.withName('/'));
  }
}