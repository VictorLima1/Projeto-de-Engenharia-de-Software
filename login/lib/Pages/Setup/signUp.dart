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

     return new Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        brightness: Brightness.light,
        title: Text('Cadastro', style: TextStyle(color: Colors.black),),
        backgroundColor: Colors.white,
        elevation: 0.0,
        iconTheme: IconThemeData(
            color: Colors.black, //change your color here
        ),
      ),

      backgroundColor: Colors.white,
      body: Form(
        key: _formKey,
        /*color: Colors.white,
        padding: new EdgeInsets.only(left: 50, right: 50),*/
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 50, bottom: 30),
              child: Icon(
                Icons.person_pin_circle,
                size: 200,
                color: Color.fromARGB(255, 255, 111, 97),
                )
            ),

            Padding(
              padding: EdgeInsets.only(bottom: 15, left: 50, right: 50),
              child: TextFormField(
                validator: (input) {
                  if(input.isEmpty){
                    return 'Preencha um e-mail';
                  }
                },
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
                onSaved: (input) => _email = input,
                
              ),
            ),

            Padding(
              padding: EdgeInsets.only(bottom: 30, left: 50, right: 50),
              child: TextFormField(
                validator: (input) {
                  if(input.length < 6){
                    return 'Sua senha precisa ter pelo menos 6 caracteres';
                  }
                },
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
                onSaved: (input) => _password = input,
                obscureText: true,
              ),
            ),
            
            OutlineButton(
              onPressed: signUp,
              child: Text('Realizar cadastro'),
              textColor: Color.fromARGB(255, 255, 111, 97),
              borderSide: BorderSide(color: Color.fromARGB(255, 255, 111, 97)),
              highlightedBorderColor: Color.fromARGB(255, 255, 111, 97),
              shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15.0)),
              /*color: Color.fromARGB(255, 255, 111, 97),
              textColor: Colors.white,*/
            ),
          ],
        )
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