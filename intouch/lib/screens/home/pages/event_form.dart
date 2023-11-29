import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intouch/intouch_widgets/date_picker.dart';
import 'package:intouch/intouch_widgets/intouch_widgets.dart';
import 'package:intouch/intouch_widgets/text_form_field.dart';
import 'package:intouch/intouch_widgets/time_picker.dart';


class EventForm extends StatefulWidget {
  const EventForm({super.key});

  @override
  State<EventForm> createState() => _EventFormState();
}

class _EventFormState extends State<EventForm> {

  final _errorUtil = "TBA";

  //Controller di ogni voce della textview
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _startController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  
  final TextEditingController _descriptionController = TextEditingController();

  //riceve la presenza di errori da parte del server
  bool isTitleError = false;
  bool isDateError = false;
  bool isStartError = false;
  bool isAddressError = false;
  bool isCityError = false;
  bool isDescriptionError = false;

  //riceve il messaggio di errore dal server
  String titleError = "";
  String dateError = "";
  String startError = "";
  String addressError = "";
  String cityError = "";
  String descriptionError = "";
  
  bool private = false;

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent, 
        iconTheme: const IconThemeData(color: Colors.black),
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        ),
      body: CustomScrollView(
        shrinkWrap: true,
        slivers: <Widget>[
          SliverList.list(
            children: <Widget>[
            Container(
            padding: const EdgeInsets.all(12.0),
            child: Form(
              child: Column(
                children: <Widget>[
                    
                  inTouchTextFormField(
                    context: context, 
                    title: 'Title', 
                    icon: Icons.title_rounded,
                    isPassword: false, 
                    isEmail: false,
                    isMultiline: false,
                    isError: isTitleError,
                    errorText: titleError,
                    controller: _titleController, 
                          ),
                    
                    DatePicker(
                      context: context, 
                      title: 'Date',
                      icon: Icons.calendar_month_outlined,
                      controller: _dateController,
                      isError: isDateError,
                      errorText: dateError,
                      ),
                    
                    
                    TimePicker(
                          title: 'Start Time', 
                          icon: Icons.access_time_outlined,
                          controller: _startController, 
                          isError: isStartError,
                          errorText: startError),
                    
                    inTouchTextFormField(
                    context: context, 
                    title: 'Address', 
                    icon: Icons.location_on,
                    isPassword: false, 
                    isEmail: false,
                    isMultiline: false,
                    isError: isAddressError,
                    errorText: addressError,
                    controller: _addressController, 
                          ),
                    
                    inTouchTextFormField(
                    context: context, 
                    title: 'City', 
                    icon: Icons.maps_home_work,
                    isPassword: false, 
                    isEmail: false,
                    isMultiline: false,
                    isError: isCityError,
                    errorText: cityError,
                    controller: _cityController, 
                          ),

                    
                    inTouchTextFormField(
                    context: context, 
                    title: 'Description', 
                    icon: Icons.description,
                    isPassword: false, 
                    isEmail: false,
                    isMultiline: true,
                    isError: isDescriptionError,
                    errorText: descriptionError,
                    controller: _descriptionController, 
                      ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Text("Private Event"),
                        Switch(
                          activeColor: Theme.of(context).colorScheme.primary,
                          value: private, 
                          onChanged: (bool value){
                            setState(() {
                              private = value;
                            });
                          }),
                      ],
                    ),
                    
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget> [
                        Expanded(
                        flex: 1,
                        child: InTouchLongButton(
                          context,
                          "Submit",
                          null,
                          true, 
                          (){}),
                         ),
                        Expanded(
                        flex: 1,
                        child: InTouchLongButton(
                          context,
                          "Reset",
                          null,
                          false, 
                          (){}),
                          )
                        ],
                        ), 
                    ],
                  )
                ),
              ),
            ]
          ),
      ]
      ),
    );
  }
}