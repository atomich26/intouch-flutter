///import 'dart:js_interop';

import 'package:flutter/material.dart';
import 'package:intouch/intouch_widgets.dart';
import 'package:intouch/screens/auth/register.dart';
import 'package:intouch/services/auth_service.dart';
import 'package:intouch/wrapper.dart';

class Login extends StatefulWidget {
  Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: inTouchAppBar(context, 'Log In'),
      body:Container(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(12.0, 24.0, 12.0, 0.0),
            child: Column(
              children: <Widget> [
                inTouchTextFormField(
                  context, 
                  'E-Mail', 
                  null, 
                  false, 
                  true, 
                  emailController, 
                  emailValidator,),

                SizedBox(height: 12.0),

                inTouchTextFormField(
                  context, 
                  'Password', 
                  null, 
                  true, 
                  false, 
                  passwordController, 
                  (value) => value!.isNotEmpty ? 'Please enter the password': null),

                SizedBox(height: 12.0),
                Expanded(
                  child: SizedBox.expand()),
                Row(
                  crossAxisAlignment:CrossAxisAlignment.end,
                  children: <Widget>[
                    Expanded(
                      child: inTouchLongButton(context, 'Login', null, true, () async {
                        if(_formKey.currentState!.validate())
                        {
                        await _auth.signInWithEmailAndPassword(emailController.text, passwordController.text)
                        .then((result) {
                            if (result == null){
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Something went wrong!')));
                            } else{
                              Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (BuildContext context) => Wrapper()),
                              (route) => false);
                              }
                            }
                          );
                        }
                    })),
                    Expanded(
                      child: inTouchLongButton(context, 'Sign Up', null, false, (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Register()));
                      })),
                  ],
                ),
                SizedBox(height: 24.0,)
              ],
            ),
          )
        ),
      ),
    );
  }
}