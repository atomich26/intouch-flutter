import 'package:flutter/material.dart';
import 'package:flutter/services.dart';



AppBar inTouchAppBar(BuildContext context, String? title, IconData? icon, Function? Function() onTap){
  return AppBar(
    title: Text(
              '$title',
              textAlign: TextAlign.left,
              textScaler: const TextScaler.linear(1.6),
              ),
    foregroundColor: Theme.of(context).colorScheme.onSurface,
    backgroundColor: Theme.of(context).colorScheme.surface,
    systemOverlayStyle: const SystemUiOverlayStyle(statusBarColor: Colors.transparent, statusBarIconBrightness: Brightness.dark),
    shadowColor: Colors.transparent,
    surfaceTintColor: Colors.transparent,
    elevation: 0.0,
    actions: <Widget>[
        IconButton(
          icon: Icon(icon),
          onPressed: () {
             onTap();
          }),
        
      ],
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
  else {
    return null;
    }
}

String? passwordValidator (String? password){
  if(password == null || password.isEmpty){
    return 'Please insert a Password';
  }
  String passwordPattern =r'^((?=\S*?[A-Z])(?=\S*?[a-z])(?=\S*?[0-9]).{5,})\S$';
  RegExp regex = RegExp(passwordPattern);
  if(!regex.hasMatch(password)){
    return ('Please insert a password with at least: \n - 6 Characters \n - 1 Uppercase character \n - 1 Lowercase character \n - 1 number');
  }
  else {
    return null;
  }
}

Container InTouchLongButton(BuildContext context, String text, IconData? icon, bool isConfirm, Function onTap){
  return Container(
    width: MediaQuery.of(context).size.width,
    height:50,
    margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(90),
      color: Colors.transparent
      ),
    child: isConfirm ? 
      ElevatedButton(
        onPressed: ()
        {
          onTap();
        },
        style: ButtonStyle(
          elevation: const MaterialStatePropertyAll(0.0),
          backgroundColor: 
              MaterialStateProperty.resolveWith<Color?>(
                (Set<MaterialState> states) {
                  if(states.contains(MaterialState.pressed)){
                    return Theme.of(context).colorScheme.primary.withOpacity(0.5); 
                  }
                  else {
                    return Theme.of(context).colorScheme.primary;
                  }
                }
              ),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))
              )
            ),
        child: Text(
          text,
          style: TextStyle(
            color:Theme.of(context).colorScheme.onSecondary, 
          )
        ),
    ) : 
    OutlinedButton(
      onPressed: ()
      {
        onTap();
      },
      style: ButtonStyle(
        elevation: const MaterialStatePropertyAll(0.0),
        foregroundColor: MaterialStateProperty.all(Theme.of(context).colorScheme.primary),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))
        ),
          ),
      child: Text(
        text,
        style: TextStyle(
          color:Theme.of(context).colorScheme.primary, 
        )
      ),
    ),
  );
}

