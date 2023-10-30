
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:intouch/intouch_widgets/date_picker.dart';
import 'package:intouch/wrapper.dart';
import '../../intouch_widgets/intouch_widgets.dart';
import '../../intouch_widgets/text_form_field.dart';
import '../../services/auth_service.dart';


class Register extends StatefulWidget {
  const Register({super.key});
  
  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _birthdayController = TextEditingController();
  
  @override
  void initState(){
    super.initState();
    _usernameController.addListener(() {
      final String text = _usernameController.text.toString();
      _usernameController.value = _usernameController.value.copyWith(text: text);
    });
    _emailController.addListener(() {
      final String text = _emailController.text.toString();
      _emailController.value = _emailController.value.copyWith(text: text);
    });
    _passwordController.addListener(() {
      final String text = _passwordController.text.toString();
      _passwordController.value = _passwordController.value.copyWith(text: text);
    });
    _confirmPasswordController.addListener(() {
      final String text = _confirmPasswordController.text.toString();
      _confirmPasswordController.value = _confirmPasswordController.value.copyWith(text: text);
    });
    _birthdayController.addListener((){
      final String text = _birthdayController.text.toString();
      _birthdayController.value = _birthdayController.value.copyWith(text: text);
    });
    
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _emailController.dispose();
    _confirmPasswordController.dispose();
    _birthdayController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: inTouchAppBar(context, 'Register'),
      body:Container(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(12.0, 24.0, 12.0, 0.0),
            child: Column(
              children: <Widget> [

                inTouchTextFormField(
                  context: context, 
                  title: 'Username', 
                  icon: Icons.person_2_rounded, 
                  isPassword: false, 
                  isEmail: false, 
                  controller: _usernameController, 
                  validator: (value) => value!.isEmpty ? "You must insert a username" : null),

                SizedBox(height: 12.0),
                
                inTouchTextFormField(
                  context: context,  
                  title: 'E-Mail', 
                  icon: Icons.alternate_email_rounded, 
                  isPassword: false, 
                  isEmail: false, 
                  controller: _emailController, 
                  validator: emailValidator),

                SizedBox(height: 12.0),

                inTouchTextFormField(
                  context: context, 
                  title: 'Password', 
                  icon: Icons.password_rounded, 
                  isPassword: true, 
                  isEmail: false, 
                  controller: _passwordController, 
                  validator: passwordValidator),

                SizedBox(height: 12.0),

                inTouchTextFormField(
                  context: context, 
                  title: 'Confirm Password', 
                  icon: Icons.password_rounded, 
                  isPassword: true, 
                  isEmail: false, 
                  controller: _confirmPasswordController, 
                  validator: (value) => value == _passwordController.text ? null: 'Please enter the same password'),

                SizedBox(height: 12.0),

                DatePicker(
                  context: context, 
                  title: 'Birthday',
                  icon: Icons.calendar_month_outlined,
                  controller: _birthdayController, 
                  validator: birthdayValidator),

                Expanded(
                  child: SizedBox.expand()),
                Row(
                  crossAxisAlignment:CrossAxisAlignment.end,
                  children: <Widget>[
                    Expanded(
                      child: InTouchLongButton(context, 'Confirm', null, true, () async {
                        if(_formKey.currentState!.validate()){
                          await _auth.registerWithEmailAndPassword(_emailController.text, _passwordController.text)
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
                      child: InTouchLongButton(context, 'Reset', null, false, (){
                        setState(() {
                          _usernameController.text = "";
                          _emailController.text = "";
                          _passwordController.text = "";
                          _confirmPasswordController.text = "";
                          _birthdayController.text = "";
                        });
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
