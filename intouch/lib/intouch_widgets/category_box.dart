import 'package:flutter/material.dart';

class CategoryBox extends StatefulWidget {
  
  BuildContext context;
  int index;
  
  CategoryBox({
    super.key,
    required this.context,
    required this.index});

  @override
  State<CategoryBox> createState() => _CategoryBoxState();
}

class _CategoryBoxState extends State<CategoryBox> {
  bool _isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GestureDetector(
        onTap:() {
          setState(() {
            _isSelected = !_isSelected;
          });
        },
        child: Card(
          elevation: 0,
          color: _isSelected? Colors.deepOrange[100*(widget.index % 9)] : Colors.blue[100*(widget.index % 9)],
          child: Center(
            child: Text('Tile ${widget.index}')
          ),
        )
      ),  
    );
  }
}