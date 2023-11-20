///import 'dart:js_interop';

import 'package:flutter/material.dart';
import 'package:intouch/intouch_widgets/intouch_widgets.dart';
import 'package:intouch/intouch_widgets/loading_spinner.dart';
import 'package:intouch/intouch_widgets/route_animations.dart';
import 'package:intouch/screens/auth/register.dart';
import 'package:intouch/services/auth_service.dart';
import 'package:intouch/wrapper.dart';

import '../../intouch_widgets/text_form_field.dart';

class Login extends StatefulWidget {
  Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: inTouchAppBar(context ,'Log In', null, (){}),
      body:Container(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 0.0),
            child: Column(
              children: <Widget> [
                Container(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Insert your credentials to access your account", textScaleFactor: 1.7,)
                ),
                
                inTouchTextFormField(
                  context: context, 
                  title: 'E-Mail', 
                  icon: Icons.alternate_email_rounded, 
                  isPassword: false, 
                  isEmail: true,
                  isError: false,
                  errorText: "",
                  controller: emailController, 
                  validator: emailValidator,),

                SizedBox(height: 12.0),

                inTouchTextFormField(
                  context: context, 
                  title: 'Password', 
                  icon: Icons.password_rounded, 
                  isPassword: true, 
                  isEmail: false,
                  isError: false, 
                  errorText: "",
                  controller: passwordController, 
                  validator: (value) => value!.isEmpty ? 'Please enter the password': null),

                SizedBox(height: 12.0),
                
                Expanded(
                  child: SizedBox.expand()),
                Row(
                  crossAxisAlignment:CrossAxisAlignment.end,
                  children: <Widget>[
                    Expanded(
                      child: !_isLoading ? InTouchLongButton(context, 'Login', null, true, () async {
                        if(_formKey.currentState!.validate())
                        {
                        setState(() {
                          _isLoading = true;
                        });
                        await _auth.signInWithEmailAndPassword(emailController.text, passwordController.text)
                        .then((result) {
                            if (result == null){
                              setState(() {
                                  _isLoading = false;
                              });
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Something went wrong!')));
                            } else {
                              Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (BuildContext context) => Wrapper()),
                              (route) => false);
                              }
                            }
                          );
                        }
                    }) : LoadingSpinner()),
                    Expanded(
                      child: InTouchLongButton(context, 'Sign Up', null, false, (){
                        Navigator.of(context).push(fromTheRight(Register()));
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