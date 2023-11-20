import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_file.dart';

class DatePicker extends StatefulWidget {
  
   DatePicker({
    super.key,
    required this.context,
    required this.title,
    this.icon,
    required this.controller,
    //required this.validator,
  });

  BuildContext context;
  String title;
  IconData? icon;
  TextEditingController controller;
  //FormFieldValidator<String> validator;

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {


  Future<void> _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
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
    return Padding(
      padding: const EdgeInsets.fromLTRB(4.0, 8.0, 4.0, 8.0),
      child: TextFormField(
        //validator: widget.validator,
        controller: widget.controller,
        readOnly: true,
        style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide(style: BorderStyle.none),
            borderRadius: BorderRadius.circular(15.0),
            ),
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          labelText: widget.title,
          prefixIcon: Icon(widget.icon),
          
        ),
        onTap:() {
          FocusScope.of(context).requestFocus(new FocusNode());
          _selectDate(context);
        },
      ),
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
  else return null;
  }
  
}

