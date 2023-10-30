import 'package:flutter/material.dart';

class inTouchTextFormField extends StatefulWidget {
  
  inTouchTextFormField({
    super.key,
    required this.context,
    required this.title,
    this.icon,
    required this.isPassword,
    required this.isEmail,
    required this.controller,
    required this.validator,
  });

  BuildContext context;
  String title;
  IconData? icon;
  bool isPassword;
  bool isEmail;
  TextEditingController controller;
  FormFieldValidator<String> validator;
  
  @override
  State<inTouchTextFormField> createState() => _inTouchTextFormFieldState();
}

class _inTouchTextFormFieldState extends State<inTouchTextFormField> {
  late bool _isPasswordVisible = widget.isPassword;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4.0, 8.0, 4.0, 8.0),
      child: TextFormField(
        validator: widget.validator,
        controller: widget.controller,
        style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
        obscureText: _isPasswordVisible,
        keyboardType: widget.isEmail ? TextInputType.emailAddress : null,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide(style: BorderStyle.none),
            borderRadius: BorderRadius.circular(15.0)
            ),
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          labelText: widget.title,
          prefixIcon: Icon(widget.icon),
          suffixIcon: widget.isPassword? IconButton(
            onPressed: (){
              setState((){
                _isPasswordVisible = !_isPasswordVisible;
              });
    
            },
            icon: _isPasswordVisible? Icon(Icons.visibility) : Icon(Icons.visibility_off)): null
          ),
        ),
    );
  }
}