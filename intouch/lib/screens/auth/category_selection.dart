
import 'package:flutter/material.dart';
import 'package:intouch/intouch_widgets/intouch_widgets.dart';
import 'package:intouch/models/category.dart';
import 'package:intouch/services/database.dart';

class CategorySelection extends StatefulWidget {
  CategorySelection({super.key});

  @override
  State<CategorySelection> createState() => _CategorySelectionState();
}

class _CategorySelectionState extends State<CategorySelection> {
  late Future<List<Category>?> _categories;
  final CategoryDatabaseService _categoryDatabaseService = CategoryDatabaseService();

  
  
  @override
  void initState() {
    super.initState();
    _categories = _categoryDatabaseService.getCategoriesFirestore();
    
  }
  Set<Category> categorySelected = <Category> {};
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: inTouchAppBar(context, 'Preferences', null, () => null),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Choose the categories you are interested in', style: TextStyle(fontSize: 24.0)),
          ),
          SizedBox(height: 8.0),
          FutureBuilder(
            future: _categories, 
            builder: (context, categories){
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Wrap(
                  alignment: WrapAlignment.start,
                  spacing: 5.0,
                  children: categories.hasData? categories.data!.map(
                      (e) => FilterChip(
                          avatarBorder: RoundedRectangleBorder(),
                          selectedColor: Theme.of(context).colorScheme.primary.withOpacity(0.5),
                          selectedShadowColor: Theme.of(context).colorScheme.primary.withOpacity(0.5),
                          label: Text(e.name, style: TextStyle(fontSize: 16.0),),
                          selected: categorySelected.contains(e),
                          onSelected: (bool selected){
                            setState(() {
                              selected? categorySelected.add(e): categorySelected.remove(e);
                              });
                            }))
                          .toList() : <Widget> [SizedBox()]
                        ),
                      );
                    }
                  ),
        const Expanded(
          child: SizedBox.expand()),
        Row(
          children: <Widget>[
          Expanded(
            flex: 1,
            child: InTouchLongButton(
              context, 
              "Confirm", 
              null, 
              true, 
              (){
                
              }
              )
              ),
            Expanded(child: InTouchLongButton(
              context, 
              "Reset", 
              null, 
              false, 
              (){
                setState(() {
                  categorySelected = <Category>{};
                });
              }))
            ],
            )    
            ],
          )
        );
    
  }
}