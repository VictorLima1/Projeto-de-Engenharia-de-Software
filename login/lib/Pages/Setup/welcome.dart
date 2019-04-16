import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:login/Pages/Setup/signIn.dart';
import 'package:login/Pages/Setup/signUp.dart';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light
    ));

    return Scaffold(
      appBar: AppBar(
        title: Text('iWay'),
        backgroundColor: Colors.lightGreen,
        //backgroundColor: Colors.white,
      ),

      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          RaisedButton(
              onPressed: navigateToSignIn,
              child: Text('Sign in'),
          ),

          RaisedButton(
              onPressed: navigateToSignUp,
              child: Text('Sign up'),
          ),
        ],
      ),
    );
  }

  void navigateToSignIn(){
    Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage(), fullscreenDialog: true));

  }

  void navigateToSignUp(){
    Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp(), fullscreenDialog: true));
  }
}