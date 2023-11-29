
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:intouch/intouch_widgets/date_picker.dart';
import 'package:intouch/services/cloud_functions.dart';
import 'package:intouch/wrapper.dart';
import '../../intouch_widgets/intouch_widgets.dart';
import '../../intouch_widgets/text_form_field.dart';


class Register extends StatefulWidget {
  const Register({super.key});
  
  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final _formKey = GlobalKey<FormState>();
  final _errorUtil = ErrorRegisterUtil();
  
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _birthdayController = TextEditingController();
  
  bool isUsernameError = false;
  bool isUserError = false;
  bool isPasswordError = false;
  bool isEmailError = false;
  bool isBirthdayError = false;

  String usernameError = "";
  String userError = "";
  String emailError = "";
  String passwordError = "";
  String birthdayError = "";

  late inTouchTextFormField usernameTextField;

  

  @override
  void initState(){
    super.initState();
    _usernameController.addListener(() {
      final String text = _usernameController.text.toString();
      _usernameController.value = _usernameController.value.copyWith(text: text);
    });
    _nameController.addListener(() {
      final String text = _nameController.text.toString();
      _nameController.value = _nameController.value.copyWith(text: text);
    });
    _emailController.addListener(() {
      final String text = _emailController.text.toString();
      _emailController.value = _emailController.value.copyWith(text: text);
    });
    _passwordController.addListener(() {
      final String text = _passwordController.text.toString();
      _passwordController.value = _passwordController.value.copyWith(text: text);
    });
    _birthdayController.addListener((){
      if(_birthdayController.text.isNotEmpty){
        final String text = _birthdayController.text.toString();
        _birthdayController.value = _birthdayController.value.copyWith(text: text);}
    });
    
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _emailController.dispose();
    _birthdayController.dispose();
    super.dispose();
  }

  

  

  @override
  Widget build(BuildContext context) {
    
    var parser= DateFormat('dd/MM/yyyy');
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: inTouchAppBar(context, 'Register', null, (){}),
      body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(12.0, 24.0, 12.0, 0.0),
            child: Column(
              children: <Widget> [

                inTouchTextFormField(
                context: context, 
                title: 'Username', 
                icon: Icons.near_me,
                isPassword: false, 
                isEmail: false,
                isMultiline: false,
                isError: isUsernameError,
                errorText: usernameError,
                controller: _usernameController, 
                //validator: (value) => value!.isEmpty ? "You must insert a username" : null
                      ),

                const SizedBox(height: 12.0),

                inTouchTextFormField(
                  context: context, 
                  title: 'Name', 
                  icon: Icons.person_2_rounded, 
                  isPassword: false, 
                  isEmail: false, 
                  isMultiline: false,
                  isError: isUserError,
                  errorText: userError,
                  controller: _nameController, 
                  //validator: (value) => value!.isEmpty ? "You must insert a name" : null
                  ),

                const SizedBox(height: 12.0),
                
                inTouchTextFormField(
                  context: context,  
                  title: 'E-Mail', 
                  icon: Icons.alternate_email_rounded, 
                  isPassword: false, 
                  isEmail: false, 
                  isMultiline: false,
                  isError: isEmailError,
                  errorText: emailError,
                  controller: _emailController, 
                  //validator: emailValidator
                  ),

                const SizedBox(height: 12.0),

                inTouchTextFormField(
                  context: context, 
                  title: 'Password', 
                  icon: Icons.password_rounded, 
                  isPassword: true, 
                  isEmail: false,
                  isMultiline: false,
                  isError: isPasswordError,
                  errorText: passwordError,
                  controller: _passwordController, 
                  //validator: passwordValidator
                  ),

                const SizedBox(height: 12.0),

                /*inTouchTextFormField(
                  context: context, 
                  title: 'Confirm Password', 
                  icon: Icons.password_rounded, 
                  isPassword: true, 
                  isEmail: false, 
                  controller: _confirmPasswordController, 
                  validator: (value) => value == _passwordController.text ? null: 'Please enter the same password'),

                SizedBox(height: 12.0),*/

                DatePicker(
                  context: context, 
                  title: 'Birthday',
                  icon: Icons.calendar_month_outlined,
                  controller: _birthdayController,
                  isError: isBirthdayError,
                  errorText: birthdayError,
                  //validator: birthdayValidator
                  ),

                const Expanded(
                  child: SizedBox.expand()),
                Row(
                  crossAxisAlignment:CrossAxisAlignment.end,
                  children: <Widget>[
                    Expanded(
                      child: InTouchLongButton(context, 'Confirm', null, true, () async {
                        if(_formKey.currentState!.validate()){
                          var data = <String, dynamic>{
                            'name': _nameController.text,
                            'username': _usernameController.text,
                            'email': _emailController.text,
                            'password': _passwordController.text,
                            'birthdate': _birthdayController.text.isNotEmpty ? parser.parse(_birthdayController.text).millisecondsSinceEpoch: null,
                          };
                          try{
                              await FirebaseFunctions.instance.httpsCallable('users-upsert').call(data);
                              FirebaseAuth.instance.signInWithEmailAndPassword(email: data["email"].toString(), password: data["password"].toString())
                              .then((result) {
                                Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(builder: (BuildContext context) => const Wrapper()),
                                (route) => false);
                            });
                            } on FirebaseFunctionsException catch (e){
                          if (e.code == "invalid-argument" && e.details != null){
                          String errorMessage = e.message.toString();
                          List errorList = e.details as List;
                          List<ErrorRegisterParser> errorParser = errorList.map(
                            (e) => ErrorRegisterParser(field: e["field"].toString(), message: e["message"].toString())).toList();
                          isUsernameError = false;
                          isUserError = false;
                          isPasswordError = false;
                          isEmailError = false;
                          isBirthdayError = false;
                          for (ErrorRegisterParser errorItem in errorParser){

                            if (errorItem.field == "username"){
                              setState(() {
                                usernameError = _errorUtil.getError(errorItem.message);
                                isUsernameError = true;
                                
                              });
                            }
                            if (errorItem.field == "name"){
                              setState(() {
                                userError = _errorUtil.getError(errorItem.message);
                                isUserError = true;
                              });

                            }
                            if (errorItem.field == "email"){
                              setState(() {
                                emailError = _errorUtil.getError(errorItem.message);
                                isEmailError = true;
                              });
                            }
                            if (errorItem.field == "password"){
                              setState(() {
                                passwordError = _errorUtil.getError(errorItem.message);
                                isPasswordError = true;
                              });
                            }
                            if (errorItem.field == "birthdate"){
                              setState(() {
                                birthdayError = _errorUtil.getError(errorItem.message);
                                isBirthdayError = true;
                              });
                            }    
                          }
                          ScaffoldMessengerState().showSnackBar(SnackBar(content: Text(errorMessage)));
                          } else {

                          }
                        }
                      }   
                    })),
                    Expanded(
                      child: InTouchLongButton(context, 'Reset', null, false, (){
                        setState(() {
                          _usernameController.text = "";
                          _nameController.text = "";
                          _emailController.text = "";
                          _passwordController.text = "";
                          _birthdayController.text = "";

                          isUsernameError = false;
                          isUserError = false;
                          isPasswordError = false;
                          isEmailError = false;
                          isBirthdayError = false;

                          usernameError = "";
                          userError = "";
                          emailError = "";
                          passwordError = "";
                          birthdayError = "";
                        });
                      })),
                  ],
                ),
               const SizedBox(height: 24.0,)
              ],
            ),
          )
        ),
      
    );
  }   
}
