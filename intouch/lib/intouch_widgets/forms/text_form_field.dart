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
    required this.errorText,
    required this.isError,
    required this.isMultiline,
    this.validator,
  });

  BuildContext context;
  String title;
  IconData? icon;
  bool isPassword;
  bool isEmail;
  bool isError;
  bool isMultiline;
  TextEditingController controller;
  FormFieldValidator<String>? validator;
  String errorText;

  
  
  @override
  State<inTouchTextFormField> createState() => _inTouchTextFormFieldState();
}

class _inTouchTextFormFieldState extends State<inTouchTextFormField> {
  late FocusNode myFocusNode;
  @override
  void initState() {
    super.initState();
    myFocusNode = FocusNode();
  }
  @override
  void dispose() {
    myFocusNode.dispose();
    super.dispose();
  }
  late bool _isPasswordVisible = widget.isPassword;
  
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(4.0, 8.0, 4.0, 8.0),
          child: TextFormField(
            //validator: widget.validator,
            maxLines: widget.isMultiline? null : 1,
            focusNode: myFocusNode,
            onTap: () {
              setState(() {
                FocusScope.of(context).requestFocus(myFocusNode);
            });
            },
            controller: widget.controller,
            validator: widget.validator,
            style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
            obscureText: _isPasswordVisible,
            keyboardType: widget.isEmail ? TextInputType.emailAddress : null,
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  style: BorderStyle.solid,
                  color: widget.isError? Theme.of(context).colorScheme.error : Theme.of(context).colorScheme.primary),
                borderRadius: BorderRadius.circular(15.0),
                ),
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  style: BorderStyle.solid,
                  color: widget.isError? Theme.of(context).colorScheme.error : Colors.black),
                borderRadius: BorderRadius.circular(15.0)
                ),
              floatingLabelBehavior: FloatingLabelBehavior.auto,
              labelText: widget.title,
              labelStyle: myFocusNode.hasFocus? TextStyle(color: widget.isError? Theme.of(context).colorScheme.error:Theme.of(context).colorScheme.primary)
                : TextStyle(color: widget.isError? Theme.of(context).colorScheme.error:Theme.of(context).colorScheme.onBackground),
                  
              prefixIcon: Icon(widget.icon, color: myFocusNode.hasFocus? (widget.isError? Theme.of(context).colorScheme.error : Theme.of(context).colorScheme.primary)
                    : widget.isError? Theme.of(context).colorScheme.error : Theme.of(context).colorScheme.onBackground,
                
              ),
              suffixIcon: widget.isPassword? IconButton(
                color: myFocusNode.hasFocus? (widget.isError? Theme.of(context).colorScheme.error : Theme.of(context).colorScheme.primary) 
                  :widget.isError? Theme.of(context).colorScheme.error : Theme.of(context).colorScheme.onBackground,
                onPressed: (){
                  setState((){
                    _isPasswordVisible = !_isPasswordVisible;
                  });
                },
                icon: _isPasswordVisible? const Icon(Icons.visibility) : const Icon(Icons.visibility_off)): null,
                
              ),
            ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(12.0, 0, 0, 0),
          child: Text(
            widget.isError? widget.errorText: "",
            style: TextStyle(
              color: Theme.of(context).colorScheme.error,
              fontSize: 12),
            textAlign: TextAlign.left,
            ),
        )
      ],
    );
  }
}

