import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intouch/intouch_widgets/intouch_widgets.dart';
import 'package:intouch/intouch_widgets/text_form_field.dart';

class PostForm extends StatefulWidget {
  const PostForm({super.key});

  @override
  State<PostForm> createState() => _PostFormState();
}

class _PostFormState extends State<PostForm> {

  final TextEditingController _descriptionController = TextEditingController();
  bool isDescriptionError = false;
  String descriptionError = "";
  List<File?> _images = <File>[];


   // Image Picker
  final _picker = ImagePicker();
  // Implementazione Image Picker
  Future<void> _openImagePicker(bool isCamera) async {
    final XFile? pickedImage =
        isCamera ? await _picker.pickImage(source: ImageSource.camera): await _picker.pickImage(source:ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        if(_images.length<4){
        _images.add(File(pickedImage.path));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Too many images, please choose one to remove")));
      }});
    }
  }

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
        slivers: <Widget> [
          SliverList.list(
            children: <Widget>[
              Form(
                child: Column(
                  children: <Widget>[
                    PageView(
                      children: _images.map((e) => 
                        Stack(
                          alignment: Alignment.topRight,
                          children: [
                            Container(
                              padding: EdgeInsets.all(12.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                
                              ),
                              child: SizedBox(child: Image.file(e!)),),
                            FloatingActionButton(
                              child: const Icon(Icons.cancel),
                              onPressed: (){
                                setState(() {
                                  _images.remove(e);
                                });
                              })
                            ]
                          )).toList(),
                    ),

                    InTouchLongButton(
                      context, 
                      "Take Photo", 
                      null, 
                      true, 
                      (){_openImagePicker(true);}),
                    
                    InTouchLongButton(
                      context, 
                      "From Gallery", 
                      null, 
                      false, 
                      (){_openImagePicker(false);}),
                      
                    inTouchTextFormField(
                      context: context, 
                      title: "Description", 
                      isPassword: false, 
                      isEmail: false, 
                      controller: _descriptionController, 
                      errorText: descriptionError, 
                      isError: isDescriptionError, 
                      isMultiline: true),  
                  ],
                ),
              )
            ],
          )
        ]
      ),
    bottomNavigationBar: Padding(
      padding: EdgeInsets.fromLTRB(0, 0, 0, MediaQuery.of(context).viewInsets.bottom),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: <Widget>[
              Expanded(
                child: SizedBox(width: double.infinity)),
              Expanded(
                child: InTouchLongButton(
                  context, 
                  "Submit", 
                  null, 
                  true, 
                  (){print(_descriptionController.text);}),
                  )
                ]
              ),
        ],
      ),
    )
    );
    
  }
}