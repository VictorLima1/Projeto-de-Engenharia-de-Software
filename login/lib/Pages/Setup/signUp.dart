import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:login/Pages/Setup/signIn.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
    String _email, _password;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark
    
    ));


    return Scaffold(
      appBar: AppBar(
        title: Text('Sign up')
      ),

      body: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        key: _formKey,
        child: Stack(
          children: <Widget>[
            Image.asset(
              "images/background.jpg",
              width: double.maxFinite,
              height: 335,
            ),

            Positioned(
              top: 245,
              child: Container(
                padding: EdgeInsets.all(40),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15)
                  )
                ),



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

                    Padding(
                      padding: EdgeInsets.only(top: 16, bottom: 62),
                      child: TextFormField(
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
                      )
                    ),

                    Container(
                      height: 45,
                      width: double.maxFinite,
                      child: RaisedButton(
                        onPressed: signUp,
                        child: Text('Sign up'),
                        )
                    ),



                  ]
                )
              ),
            ),
/*
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
            ),*/
            
          ],
        ),
      ),
    );
  }

  Future<void> signUp() async{
    final formState = _formKey.currentState;

    if(formState.validate()){
      formState.save();
      try{
        FirebaseUser user = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email, password: _password);
        user.sendEmailVerification();
        Navigator.of(context).pop(); 

        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
     
      }catch(e){
        print(e.message);
      }
      
    }
  }
}