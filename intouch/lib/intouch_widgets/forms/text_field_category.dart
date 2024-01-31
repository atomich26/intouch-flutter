import 'package:flutter/material.dart';
import 'package:intouch/models/category.dart';

class inTouchTextFormFieldCategory extends StatefulWidget {
  
  inTouchTextFormFieldCategory({
    super.key,
    required this.context,
    required this.title,
    this.icon,
    required this.isPassword,
    required this.isEmail,
    required this.controller,
    required this.categorySelected,
    required this.errorText,
    required this.isError,
    required this.isMultiline,
    required this.categories,
    this.validator,
  });

  final BuildContext context;
  final String title;
  final IconData? icon;
  final bool isPassword;
  final bool isEmail;
  final bool isError;
  final bool isMultiline;
  final TextEditingController controller;
  final ValueNotifier<Category?> categorySelected;
  final FormFieldValidator<String>? validator;
  final String errorText;
  final List<Category> categories;

  
  
  @override
  State<inTouchTextFormFieldCategory> createState() => _inTouchTextFormFieldCategoryState();
}

class _inTouchTextFormFieldCategoryState extends State<inTouchTextFormFieldCategory> {
  late FocusNode myFocusNode;
  @override
  void initState() {
    super.initState();
    myFocusNode = FocusNode();
  }
  @override
  void dispose() {
    myFocusNode.dispose();
    super.dispose();
  }
  late bool _isPasswordVisible = widget.isPassword;


void _selectCategory(BuildContext context , List<Category> categories) {
  showModalBottomSheet(context: context, builder: (context){
    return Padding(
      padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
           mainAxisSize: MainAxisSize.min,
                      children: [
                        Center(
                          child: SingleChildScrollView(
                            child: Wrap(
                              spacing: 5.0,
                              children: categories.map(
                                (e) => ActionChip(
                                  label: Text(e.name),
                                  onPressed:  (){
                                    setState(() {
                                      widget.categorySelected.value= e;
                                      print(widget.categorySelected.value?.name);
                                      widget.controller.text = e.name;
                                      Navigator.of(context).pop(e);
                                    });
                                  }))
                                .toList()
                                )
                              ),
                            ),
                          ],
                      ),
                    );
  });
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
            readOnly: true,
            maxLines: widget.isMultiline? null : 1,
            focusNode: myFocusNode,
            onTap: () {
              setState(() {
                FocusScope.of(context).requestFocus(myFocusNode);
               _selectCategory(context, widget.categories);
            });
            },
            controller: widget.controller,
            validator: widget.validator,
            style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
            obscureText: _isPasswordVisible,
            keyboardType: widget.isEmail ? TextInputType.emailAddress : null,
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  style: BorderStyle.solid,
                  color: widget.isError? Theme.of(context).colorScheme.error : Theme.of(context).colorScheme.primary),
                borderRadius: BorderRadius.circular(15.0),
                ),
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  style: BorderStyle.solid,
                  color: widget.isError? Theme.of(context).colorScheme.error : Colors.black),
                borderRadius: BorderRadius.circular(15.0)
                ),
              floatingLabelBehavior: FloatingLabelBehavior.auto,
              labelText: widget.title,
              labelStyle: myFocusNode.hasFocus? TextStyle(color: widget.isError? Theme.of(context).colorScheme.error:Theme.of(context).colorScheme.primary)
                : TextStyle(color: widget.isError? Theme.of(context).colorScheme.error:Theme.of(context).colorScheme.onBackground),
                  
              prefixIcon: Icon(widget.icon, color: myFocusNode.hasFocus? (widget.isError? Theme.of(context).colorScheme.error : Theme.of(context).colorScheme.primary)
                    : widget.isError? Theme.of(context).colorScheme.error : Theme.of(context).colorScheme.onBackground,
                
              ),
              suffixIcon: widget.isPassword? IconButton(
                color: myFocusNode.hasFocus? (widget.isError? Theme.of(context).colorScheme.error : Theme.of(context).colorScheme.primary) 
                  :widget.isError? Theme.of(context).colorScheme.error : Theme.of(context).colorScheme.onBackground,
                onPressed: (){
                  setState((){
                    _isPasswordVisible = !_isPasswordVisible;
                  });
                },
                icon: _isPasswordVisible? const Icon(Icons.visibility) : const Icon(Icons.visibility_off)): null,
                
              ),
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
 
