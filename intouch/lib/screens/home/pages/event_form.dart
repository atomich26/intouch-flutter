import 'dart:io';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:intouch/intouch_widgets/forms/date_picker.dart';
import 'package:intouch/intouch_widgets/intouch_widgets.dart';
import 'package:intouch/intouch_widgets/forms/text_field_category.dart';
import 'package:intouch/intouch_widgets/forms/text_form_field.dart';
import 'package:intouch/intouch_widgets/forms/time_picker.dart';
import 'package:intouch/models/category.dart';
import 'package:intouch/services/cloud_functions.dart';
import 'package:intouch/services/firebase_storage.dart';
import 'package:intouch/wrapper.dart';


class EventForm extends StatefulWidget {
  const EventForm({
    super.key,
    this.categories});
  final Future<List<Category>?>? categories;
  @override
  State<EventForm> createState() => _EventFormState();
}

class _EventFormState extends State<EventForm> {

    final _formKey = GlobalKey<FormState>();
    final _errorUtil = ErrorEventUtil();

    bool _isLoading = false;
    



  //Controller di ogni voce della textview
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _availableCotroller = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();
  final TextEditingController _startTimeController = TextEditingController();
  final TextEditingController _endTimeController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final ValueNotifier<Category?> _categorySelected = ValueNotifier(null);

  final StorageService _storageService = StorageService();

  File? _image;
  String? imageName; 
 
  

  // Image Picker
  final _picker = ImagePicker();
  // Implementazione Image Picker
  Future<void> _openImagePicker(bool isCamera) async {
    final XFile? pickedImage =
        isCamera ? await _picker.pickImage(source: ImageSource.camera, imageQuality: 10): await _picker.pickImage(source:ImageSource.gallery, imageQuality: 10);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }

  //riceve la presenza di errori da parte del server
  bool isTitleError = false;
  bool isAvailableError = false;
  bool isCategoryError = false;
  bool isStartDateError = false;
  bool isEndDateError = false;
  bool isStartTimeError = false;
  bool isEndTimeError = false;
  bool isAddressError = false;
  bool isCityError = false;
  bool isDescriptionError = false;

  //riceve il messaggio di errore dal server
  String titleError = "";
  String availableError = "";
  String categoryError = "";
  String startDateError = "";
  String endDateError = "";
  String startTimeError = "";
  String endTimeError = "";
  String imageError = "";
  String addressError = "";
  String cityError = "";
  String descriptionError = "";
  
  bool private = false;

  @override
  Widget build(BuildContext context) {

    var dateParser= DateFormat('dd/MM/yyyy HH:mm');
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
              key: _formKey,
              child: Column(
                children: <Widget>[
                    
                  inTouchTextFormField(
                    context: context, 
                    title: 'Title', 
                    icon: Icons.title_rounded,
                    isPassword: false, 
                    isEmail: false,
                    isNumber: false,
                    isMultiline: false,
                    isError: isTitleError,
                    errorText: titleError,
                    controller: _titleController, 
                          ),

                  inTouchTextFormField(
                    context: context, 
                    title: 'Available', 
                    icon: Icons.person,
                    isPassword: false, 
                    isEmail: false,
                    isNumber: true,
                    isMultiline: false,
                    isError: isAvailableError,
                    errorText: availableError,
                    controller: _availableCotroller, 
                          ),

                  FutureBuilder(
                    future: widget.categories,
                    builder: (context, categories) {
                      return !categories.hasData? const SizedBox.shrink() : 
                      inTouchTextFormFieldCategory(
                        context: context, 
                        title: 'Categories', 
                        icon: Icons.person,
                        isPassword: false, 
                        isEmail: false,
                        isMultiline: false,
                        isError: isCategoryError,
                        errorText: categoryError,
                        controller: _categoryController,
                        categorySelected: _categorySelected,
                        categories: categories.data!,
                              );
                    }
                  ),
                    
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: DatePicker(
                            context: context, 
                            title: 'Start Date',
                            icon: Icons.calendar_month_outlined,
                            controller: _startDateController,
                            isError: isStartDateError,
                            errorText: startDateError,
                            ),
                      ),
                      Expanded(
                        flex: 1,
                        child: DatePicker(
                            context: context, 
                            title: 'End Date',
                            icon: Icons.calendar_month_outlined,
                            controller: _endDateController,
                            isError: isEndDateError,
                            errorText: endDateError,
                            ),
                      ),
                    ],
                  ),
                    
                    
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: TimePicker(
                            title: 'Start Time', 
                            icon: Icons.access_time_outlined,
                            controller: _startTimeController, 
                            isError: isStartTimeError,
                            errorText: startTimeError),
                      ),
                      Expanded(
                        flex: 1,
                        child: TimePicker(
                            title: 'End Time', 
                            icon: Icons.access_time_outlined,
                            controller: _endTimeController, 
                            isError: isEndTimeError,
                            errorText: endTimeError),
                      ),
                    ],
                  ),

                  
                    
                  inTouchTextFormField(
                    context: context, 
                    title: 'Address', 
                    icon: Icons.location_on,
                    isPassword: false, 
                    isEmail: false,
                    isNumber: false,
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
                    isNumber: false,
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
                        Text(imageError, style:const TextStyle(color: Colors.red)),
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
                    isNumber: false,
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
                          ()async{
                            if(_formKey.currentState!.validate()){
                          setState(() {
                          _isLoading = true;
                        });
                          if(_image == null){
                            setState(() {
                              _isLoading = false;
                              imageError = "One image is needed";
                            });
                           } else {
                          imageName = await _storageService.setEventImage(FirebaseAuth.instance.currentUser!.uid, _image!);
                          print(imageName);
                          print(dateParser.parse("${_startDateController.text} ${_startTimeController.text}"));
                          var data = <String, dynamic>{
                            "name" : _titleController.text,
                            "available" : int.parse(_availableCotroller.text),
                            "categoryId" : _categorySelected.value?.id,
                            "startAt": _startDateController.text.isNotEmpty && _startTimeController.text.isNotEmpty ? dateParser.parse(_startDateController.text+ " " + _startTimeController.text).millisecondsSinceEpoch : null,
                            "endAt": _endDateController.text.isNotEmpty && _endTimeController.text.isNotEmpty? dateParser.parse(_endDateController.text+" "+_endTimeController.text).millisecondsSinceEpoch : null,
                            "address": _addressController.text,
                            "city": _cityController.text,
                            "description": _descriptionController.text,
                            "restricted": private,
                            "cover": imageName,
                            "geo": [0, 0],
                          };
                          try{
                            //on-field deployment of user-upsert, a cloud function.
                              await FirebaseFunctions.instance.httpsCallable('events-upsert').call(data)
                              .then((result) {
                                Navigator.pushAndRemoveUntil(
                                  context, 
                                  MaterialPageRoute(builder: (context) => Wrapper()), 
                                  (route) => false);
                            });
                            } on FirebaseFunctionsException catch (e){
                              await _storageService.deleteEventImage(imageName!);
                          _isLoading = false;
                          if (e.code == "invalid-argument" && e.details != null){
                          String errorMessage = e.message.toString();
                          List errorList = e.details as List;
                          List<ErrorEventParser> errorParser = errorList.map(
                            (e) => ErrorEventParser(field: e["field"].toString(), message: e["message"].toString())).toList();
                          // isUsernameError = false;
                          // isUserError = false;
                          // isPasswordError = false;
                          // isEmailError = false;
                          // isBirthdayError = false;
                          for (ErrorEventParser errorItem in errorParser){

                            // if (errorItem.field == "username"){
                            //   setState(() {
                            //     usernameError = _errorUtil.getError(errorItem.message);
                            //     isUsernameError = true;
                                
                            //   });
                            // }
                            // if (errorItem.field == "name"){
                            //   setState(() {
                            //     userError = _errorUtil.getError(errorItem.message);
                            //     isUserError = true;
                            //   });

                            // }
                            // if (errorItem.field == "email"){
                            //   setState(() {
                            //     emailError = _errorUtil.getError(errorItem.message);
                            //     isEmailError = true;
                            //   });
                            // }
                            // if (errorItem.field == "password"){
                            //   setState(() {
                            //     passwordError = _errorUtil.getError(errorItem.message);
                            //     isPasswordError = true;
                            //   });
                            // }
                            // if (errorItem.field == "birthdate"){
                            //   setState(() {
                            //     birthdayError = _errorUtil.getError(errorItem.message);
                            //     isBirthdayError = true;
                            //   });
                            // }    
                          }
                          ScaffoldMessengerState().showSnackBar(SnackBar(content: Text(errorMessage)));
                          } else {

                          }
                        }
                      }}
                            
                          }),
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
                              _startDateController.text = "";
                              _categoryController.text ="";
                              _categorySelected.value = null;
                              _endDateController.text = "";
                              _startTimeController.text = "";
                              _endTimeController.text = "";
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