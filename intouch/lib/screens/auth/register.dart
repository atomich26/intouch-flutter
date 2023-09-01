import 'package:flutter/material.dart';
import 'package:intouch/wrapper.dart';
import '../../intouch_widgets.dart';
import '../../services/auth_service.dart';

class Register extends StatefulWidget {
  const Register({super.key});
  
  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  
  
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  @override
  void initState(){
    super.initState();
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
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _emailController.dispose();
    _confirmPasswordController.dispose();
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
                /*TextFormField(
                  validator: (val) => val!.isNotEmpty ? null: 'Please Enter an Username',
                  onChanged: (val){
                    setState(() => username = val);
                  }),*/
                
                SizedBox(height: 12.0),

                inTouchTextFormField(
                  context, 
                  'E-Mail', 
                  null, 
                  false, 
                  true, 
                  _emailController, 
                  emailValidator),

                SizedBox(height: 12.0),

                inTouchTextFormField(
                  context, 
                  'Password', 
                  null, 
                  true, 
                  false, 
                  _passwordController, 
                  (value) => value.toString().length>8? null: 'Please enter a stronger password'),

                SizedBox(height: 12.0),

                inTouchTextFormField(
                  context, 
                  'Confirm Password', 
                  null, 
                  true, 
                  false, 
                  _confirmPasswordController, 
                  (value) => value == _passwordController.text ? null: 'Please enter the same password'),

                Expanded(
                  child: SizedBox.expand()),
                Row(
                  crossAxisAlignment:CrossAxisAlignment.end,
                  children: <Widget>[
                    Expanded(
                      child: inTouchLongButton(context, 'Confirm', null, true, () async {
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
                      child: inTouchLongButton(context, 'Reset', null, false, (){})),
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
