
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intouch/intouch_widgets/intouch_widgets.dart';
import 'package:intouch/intouch_widgets/route_animations.dart';
import 'package:intouch/screens/auth/register.dart';
import 'package:intouch/services/auth_service.dart';
import 'package:intouch/wrapper.dart';

import '../../intouch_widgets/forms/text_form_field.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _emailController.addListener(() {
      final String text = _emailController.text.toString();
      _emailController.value = _emailController.value.copyWith(text: text);
    });
    _passwordController.addListener(() {
      final String text = _passwordController.text.toString();
      _passwordController.value = _passwordController.value.copyWith(text: text);
    });

  }
  
  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: inTouchAppBar(context ,'Log In', null, (){
        return null;
      }),
      body:Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 0.0),
          child: Column(
            children: <Widget> [
              Container(
                padding: const EdgeInsets.all(8.0),
                child: const Text("Insert your credentials to access your account", textScaler: TextScaler.linear(1.7),)
              ),
              
              inTouchTextFormField(
                context: context, 
                title: 'E-Mail', 
                icon: Icons.alternate_email_rounded, 
                isPassword: false, 
                isEmail: true,
                isNumber: false,
                isError: false,
                isMultiline: false,
                errorText: "",
                controller: _emailController, 
                validator: emailValidator,),
      
              const SizedBox(height: 12.0),
      
              inTouchTextFormField(
                context: context, 
                title: 'Password', 
                icon: Icons.password_rounded, 
                isPassword: true, 
                isEmail: false,
                isNumber: false,
                isError: false, 
                isMultiline: false,
                errorText: "",
                controller: _passwordController, 
                validator: (value) => value == null || value.isEmpty? 'Please enter the password': null),
      
              const SizedBox(height: 12.0),
              
              const Expanded(
                child: SizedBox.expand()),
              Row(
                crossAxisAlignment:CrossAxisAlignment.end,
                children: <Widget>[
                  Expanded(
                    child: InTouchLongButton(context, 'Login', null, true, () async {
                      if(_formKey.currentState!.validate()){
                      setState(() {
                        _isLoading = true;
                      });
                      await _auth.signInWithEmailAndPassword(_emailController.text, _passwordController.text)
                      .then((result) {
                          if (result.runtimeType == FirebaseAuthException){
                            setState(() {
                                _isLoading = false;
                            });
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(result.message.toString())));
                          } else {
                            Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (BuildContext context) => const Wrapper()),
                            (route) => false);
                            }
                          }
                        );
                      }
                  })),
                  Expanded(
                    child: InTouchLongButton(context, 'Sign Up', null, false, (){
                      Navigator.of(context).push(fromTheRight(const Register()));
                    })),
                ],
              ),
              const SizedBox(height:12.0),
              
            ],
          ),
        )
      ),
    bottomNavigationBar: _isLoading? const LinearProgressIndicator() : const SizedBox(height :1),);
  }
}