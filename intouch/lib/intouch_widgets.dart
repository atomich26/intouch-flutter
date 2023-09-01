import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


AppBar inTouchAppBar(BuildContext context, String? title){
  return AppBar(
    title: Text(
              '$title',
              textAlign: TextAlign.left,
              textScaleFactor: 1.7,
              ),
    foregroundColor: Theme.of(context).colorScheme.onSurface,
    backgroundColor: Theme.of(context).colorScheme.surface,
    systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.transparent, statusBarIconBrightness: Brightness.dark),
    elevation: 0.0,
    actions: <Widget>[
        IconButton(
          icon: Icon(Icons.settings),
          onPressed: () {
            
          },
        ),
      ],
    );
}


TextFormField inTouchTextFormField(BuildContext context, String text, IconData? icon, bool isPassword, bool isEmail, TextEditingController controller, FormFieldValidator<String> validator){
  return TextFormField(
    validator: validator,
    controller: controller,
    style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
    obscureText: isPassword,
    keyboardType: isEmail ? TextInputType.emailAddress : null,
    decoration: InputDecoration(
      border: OutlineInputBorder(
        borderSide: BorderSide(style: BorderStyle.none),
        borderRadius: BorderRadius.circular(15.0)
        ),
      floatingLabelBehavior: FloatingLabelBehavior.auto,
      labelText: text,   
      ),
    );
}

String? emailValidator (String? email){
  if(email == null|| email.isEmpty){
    return 'Please insert an Email';
  }
  
  String emailPattern = r'\w+@\w+\.\w+';
  RegExp regex = RegExp(emailPattern);
  if(!regex.hasMatch(email)) {
    return 'Please insert a valid Email Address';
  }
  else return null;
}

Container inTouchLongButton(BuildContext context, String text, IconData? icon, bool isConfirm, Function onTap){
  return Container(
    width: MediaQuery.of(context).size.width,
    height:50,
    margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(90)),
    child: ElevatedButton(
      onPressed: ()
      {
        onTap();
      },
      style: ButtonStyle(
        elevation: MaterialStatePropertyAll(0.0),
        backgroundColor: 
            MaterialStateProperty.resolveWith<Color?>(
              
              (Set<MaterialState> states) {
                if(states.contains(MaterialState.pressed)){
                  if(isConfirm){
                    return Theme.of(context).colorScheme.primary.withOpacity(0.5);
                    } 
                  else{
                    return Theme.of(context).colorScheme.secondary.withOpacity(0.5);
                  }
                }
                else if(isConfirm){
                  return Theme.of(context).colorScheme.primary;
                }
                else{
                  return Theme.of(context).colorScheme.secondary;
                }
              }
            ),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))
            )
      ),
      child: Text(
        '$text',
        style: TextStyle(
          color: isConfirm? Theme.of(context).colorScheme.onPrimary : Theme.of(context).colorScheme.onSecondary, 
        )
      ),
    ),
  );
}

