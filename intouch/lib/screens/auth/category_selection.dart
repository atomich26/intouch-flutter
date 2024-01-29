
import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:intouch/intouch_widgets/intouch_widgets.dart';
import 'package:intouch/models/category.dart';
import 'package:intouch/services/database.dart';
import 'package:intouch/wrapper.dart';

class CategorySelection extends StatefulWidget {
  const CategorySelection({super.key});

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
  bool _isLoading = false;
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Scaffold(
        appBar: inTouchAppBar(context, 'Preferences', null, () => null),
        body: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('Choose the categories you are interested in', style: TextStyle(fontSize: 24.0)),
            ),
            const SizedBox(height: 8.0),
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
                            avatarBorder: const RoundedRectangleBorder(),
                            selectedColor: Theme.of(context).colorScheme.primary.withOpacity(0.5),
                            selectedShadowColor: Theme.of(context).colorScheme.primary.withOpacity(0.5),
                            label: Text(e.name, style: const TextStyle(fontSize: 16.0),),
                            selected: categorySelected.contains(e),
                            onSelected: (bool selected){
                              setState(() {
                                selected? categorySelected.add(e): categorySelected.remove(e);
                                });
                              }))
                            .toList() : <Widget> [const SizedBox.shrink()]
                          ),
                        );
                      }
                    ),
          const Expanded(
            child: SizedBox.expand()),
          Column(
            children: [
              Row(
                children: <Widget>[
                Expanded(
                  flex: 1,
                  child: InTouchLongButton(
                    context, 
                    "Confirm", 
                    null, 
                    true, 
                    ()async{
                      setState(() {
                        _isLoading = !_isLoading;
                      });
                      var data = <String, List<String>>{
                        'preferences': categorySelected.map((e) => e.id).toList()};
                      try {
                      await FirebaseFunctions.instance.httpsCallable('users-preferences').call(data).then((value) => 
                        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const Wrapper()),(route) => false));
              
                      } on FirebaseFunctionsException catch (e){
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
                      }
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
                ),
            _isLoading ? const LinearProgressIndicator(): const SizedBox.shrink()],
            )    
          ],
        )
      ),
    );
    
  }
}