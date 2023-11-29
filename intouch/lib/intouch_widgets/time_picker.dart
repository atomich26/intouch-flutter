import "package:flutter/material.dart";
import "package:intl/intl.dart";

class TimePicker extends StatefulWidget {
  TimePicker({
    super.key,
    required this.title,
    this.icon,
    required this.controller,
    required this.errorText,
    required this.isError});


    String title;
    IconData? icon;
    TextEditingController controller;
    String errorText;
    bool isError;

  @override
  State<TimePicker> createState() => _TimePickerState();
}

class _TimePickerState extends State<TimePicker> {

  Future<void> _selectTime(BuildContext context) async {
    TimeOfDay? picked = await showTimePicker(
      context: context, 
      initialTime: TimeOfDay.now());
    if (picked != null){
      setState(() {
        String minutes="";
        minutes = picked.minute <= 9?  "0${picked.minute}" : "${picked.minute}";
        widget.controller.text = "${picked.hour}:${minutes}";
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
              FocusScope.of(context).requestFocus(new FocusNode());
              _selectTime(context);
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