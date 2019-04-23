
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:login/Pages/Setup/welcome.dart';
import 'package:login/Pages/home.dart';


class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _email, _password;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.transparent,
        //statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.light
    ));
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        title: Text('Login', style: TextStyle(color: Colors.black),),
        backgroundColor: Colors.white,
        elevation: 0.0
      ),

      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              validator: (input) {
                if(input.isEmpty){
                  return 'Please type and e-mail';
                }
              },
              onSaved: (input) => _email = input,
              decoration: InputDecoration(
                labelText: 'E-mail'
              ),
            ),

            TextFormField(
              validator: (input) {
                if(input.length < 6){
                  return 'Your password needs to be longer';
                }
              },
              onSaved: (input) => _password = input,
              decoration: InputDecoration(
                labelText: 'Password'
              ),
              obscureText: true,
            ),
            FlatButton(
              onPressed: signIn, 
              child: Text("Login"),
              color: Color.fromARGB(255, 255, 111, 97),
              textColor: Colors.white,
            )
          ],
        ),
      ),
    );
  }

  Future<void> signIn() async{
    final formState = _formKey.currentState;

    if(formState.validate()){
      formState.save();
      try{
        FirebaseUser user = await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password);
        Navigator.pop(context);
        //Navigator.push(context, MaterialPageRoute(builder: (context) => WelcomePage()));
      }catch(e){
        print(e.message);
      }
      
    }
  }
}
