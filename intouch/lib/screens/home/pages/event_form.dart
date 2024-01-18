import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
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

  //Controller di ogni voce della textview
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _startController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  File? _image;

  // Image Picker
  final _picker = ImagePicker();
  // Implementazione Image Picker
  Future<void> _openImagePicker(bool isCamera) async {
    final XFile? pickedImage =
        isCamera ? await _picker.pickImage(source: ImageSource.camera): await _picker.pickImage(source:ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }

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

                                    
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12.0),
                          height: 300,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: const BorderRadius.all(Radius.circular(16.0))
                          ),
                          
                          child: Container(
                            child: _image != null ?
                                Stack(
                                  alignment: Alignment.topRight,
                                  children: <Widget>[
                                    SizedBox(
                                      width: double.infinity,
                                      child: Image.file(_image!, fit:BoxFit.cover)),
                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: FloatingActionButton(
                                        backgroundColor: Colors.white.withOpacity(0.3),
                                        mini: true,
                                        child: const Icon(Icons.cancel),
                                        onPressed: (){
                                          setState(() {
                                            _image = null;
                                          });
                                        }),
                                    )
                                    ]
                                  ) 
                              : const Center(child: Text("Image not selected")),
                          )
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: InTouchLongButton(
                                  context, 
                                  "Take Photo", 
                                  Icons.camera,
                                  true, 
                                  (){
                                    _openImagePicker(true);
                                  }),
                              
                            ),
                            Expanded(
                              flex: 1,
                              child:
                                  InTouchLongButton(
                                  context, 
                                  "From Gallery", 
                                  Icons.browse_gallery,
                                  false, 
                                  (){
                                    _openImagePicker(false);
                                  }),
                            )
                          ],
                        ),
                      ],
                    ),
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
                          (){
                            setState(() {
                              _image = null;
                              _titleController.text = "";
                              _dateController.text = "";
                              _startController.text = "";
                              _addressController.text = "";
                              _cityController.text = "";
                              _descriptionController.text = "";
                            });
                          }),
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