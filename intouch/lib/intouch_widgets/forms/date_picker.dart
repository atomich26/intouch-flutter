import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePicker extends StatefulWidget {
  
   DatePicker({
    super.key,
    required this.context,
    required this.title,
    this.icon,
    required this.controller,
    required this.errorText,
    required this.isError,
    //required this.validator,
  });

  final BuildContext context;
  final String title;
  final IconData? icon;
  final TextEditingController controller;
  final String errorText;
  final bool isError;
  //FormFieldValidator<String> validator;

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {


  Future<void> _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      locale:const Locale('it'),
      initialDate: DateTime.now(), 
      firstDate: DateTime(1900, 1), 
      lastDate: DateTime(2050, 12));
    if (picked != null){
      setState(() {
        widget.controller.text = DateFormat('dd/MM/yyyy').format(picked);
        
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(4.0, 8.0, 4.0, 8.0),
          child: TextFormField(
            //validator: widget.validator,
            controller: widget.controller,
            readOnly: true,
            style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  style: BorderStyle.solid,
                  color: widget.isError ? Theme.of(context).colorScheme.error : Theme.of(context).colorScheme.primary),
                borderRadius: BorderRadius.circular(15.0),
                ),
              floatingLabelBehavior: FloatingLabelBehavior.auto,
              labelText: widget.title,
              labelStyle: TextStyle(color: widget.isError ? Theme.of(context).colorScheme.error : Theme.of(context).colorScheme.onBackground),
              prefixIcon: Icon(widget.icon, color: widget.isError ? Theme.of(context).colorScheme.error : Theme.of(context).colorScheme.onBackground),
              
            ),
            onTap:() {
              FocusScope.of(context).requestFocus(FocusNode());
              _selectDate(context);
            },
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

String? birthdayValidator (String? birthday){
  if(birthday == null || birthday.isEmpty){
    return 'Please insert your birthday';
  }
  else{
  String datePattern = "yMd";
  DateTime birthdayDate = DateFormat(datePattern).parse(birthday);
  DateTime today = DateTime.now();
  
  if(birthdayDate.isAfter(today)){
    return 'Please insert a proper date';
  }
  else {
    return null;
    }
  }
  
}

