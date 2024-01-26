import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intouch/intouch_widgets/intouch_widgets.dart';
import 'package:intouch/intouch_widgets/text_form_field.dart';
import 'package:intouch/models/event.dart';
import 'package:intouch/services/auth_service.dart';
import 'package:intouch/services/database.dart';

class PostForm extends StatefulWidget {
   PostForm({
    super.key,
    required this.event});

  Event event;
  

  @override
  State<PostForm> createState() => _PostFormState();
}

class _PostFormState extends State<PostForm> {

  final TextEditingController _descriptionController = TextEditingController();
  bool isDescriptionError = false;
  String descriptionError = "";
  List<File> _images = <File>[];
  PostDatabaseService _postDatabaseService = PostDatabaseService();


   // Image Picker
  final _picker = ImagePicker();
  // Implementazione Image Picker
  Future<void> _openImagePicker(bool isCamera) async {
    
    final XFile? pickedImage =
        isCamera ? 
        await _picker.pickImage(
          source: ImageSource.camera,
          imageQuality: 10)
          : 
        await _picker.pickImage(
          source: ImageSource.gallery,
          imageQuality: 10);
    if (pickedImage != null) {
      setState(() {
        if(_images.length<4){
        _images.add(File(pickedImage.path));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Too many images, please choose one to remove")));
      }});
    }
  }
  
  bool _isLoading = false;

  @override

  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent, 
        iconTheme: const IconThemeData(color: Colors.black),
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      body:CustomScrollView(
        shrinkWrap: true,
        slivers: <Widget> [
          SliverList.list(
            children: <Widget>[
              Form(
                child: Column(
                  children: <Widget>[
                    Column(
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
                  () async {
                    if(_images.length == 0){
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Add at least one image to the post")));
                    }
                    else {
                        setState(() {
                      _isLoading = !_isLoading;
                      });
                      _isLoading?
                      await _postDatabaseService.uploadPost(
                      FirebaseAuth.instance.currentUser!.uid,
                      widget.event.id,
                      _descriptionController.text,
                      _images
                    ).then((value){
                      Navigator.of(context).pop();}
                    ): {};}
                  }),
                )
              ]
            ),
          _isLoading ? const LinearProgressIndicator(): SizedBox(height: 1,)
          ],
        ),
      )
    );
    
  }
}