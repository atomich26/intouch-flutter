import 'package:flutter/material.dart';
import 'package:intouch/models/category.dart';


class CategoryButton extends StatefulWidget {
  CategoryButton({
    super.key,
    required this.context,
    required this.category,
    required this.onTap});

  BuildContext context;
  Category category;
  Function onTap;
  @override
  State<CategoryButton> createState() => _CategoryButtonState();
}

class _CategoryButtonState extends State<CategoryButton> {
  bool _isSelected = false;
  @override
  Widget build(BuildContext context) {
      
  return GestureDetector(
    onTap: (){setState(() {
      _isSelected = !_isSelected;
    });},
    child: Container(
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.0),
        color: _isSelected? Theme.of(context).colorScheme.primary: Theme.of(context).colorScheme.tertiary ,
        
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          widget.category.name, 
          style: TextStyle(fontSize: 20.0,
            color: _isSelected? Theme.of(context).colorScheme.onPrimary: Theme.of(context).colorScheme.onTertiary),
            ),
      )
    ),
  );
  }
}