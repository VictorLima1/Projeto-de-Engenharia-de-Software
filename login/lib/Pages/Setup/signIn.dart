
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:login/Pages/Setup/signUp.dart';
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
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        brightness: Brightness.light,
        title: Text('Login', style: TextStyle(color: Colors.black),),
        backgroundColor: Colors.white,
        elevation: 0.0,
        iconTheme: IconThemeData(
            color: Colors.black, //change your color here
          ),
      ),

      backgroundColor: Colors.white,

      body: Form(
        /*color: Colors.white,*
        padding: new EdgeInsets.only(left: 50, right: 50),*/
        key: _formKey,
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 50, bottom: 30),
              child: Icon(
                Icons.verified_user,
                size: 200,
                color: Color.fromARGB(255, 255, 111, 97),
                )
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 15, left: 50, right: 50),
              child: TextFormField(
                validator: (input) {
                  if(input.isEmpty){
                    return 'Insira um e-mail válido';
                  }
                },
                onSaved: (input) => _email = input,
                decoration: InputDecoration(
                  labelText: 'E-mail',
                  labelStyle: TextStyle(color: Colors.grey),
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Color.fromARGB(255, 255, 111, 97))),
                  border: OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(10.0),
                    //borderSide: new BorderSide(),
                  )
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.only(bottom: 30, left: 50, right: 50),
              child: TextFormField(
              cursorColor: Color.fromARGB(255, 255, 111, 97),
              validator: (input) {
                if(input.length < 6){
                  return 'Sua senha tá errada, otáro!';
                }
              },
              onSaved: (input) => _password = input,
              decoration: InputDecoration(
                labelText: 'Senha',
                labelStyle: TextStyle(color: Colors.grey),
                fillColor: Colors.white,
                focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Color.fromARGB(255, 255, 111, 97))),
                  border: OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(10.0),
                    //borderSide: new BorderSide(),
                  )
              ),
              obscureText: true,
              ),
            ),

            OutlineButton(
              onPressed: signIn, 
              child: Text("Login"),
              //color: Color.fromARGB(255, 255, 111, 97),
              textColor: Color.fromARGB(255, 255, 111, 97),
              borderSide: BorderSide(color: Color.fromARGB(255, 255, 111, 97)),
              highlightedBorderColor: Color.fromARGB(255, 255, 111, 97),
              shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15.0)),
            ),

            Padding(
              padding: EdgeInsets.only(top: 5),
              child: OutlineButton(
              onPressed: irCadastro, 
              child: Text("Não tem uma conta? Inscreva-se aqui"),
              //color: Color.fromARGB(255, 255, 111, 97),
              textColor: Color.fromARGB(255, 255, 111, 97),
              borderSide: BorderSide(color: Colors.white),
              highlightedBorderColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15.0)),
            ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> irCadastro(){
    Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp(), fullscreenDialog: true));
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
