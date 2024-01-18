import 'package:flutter/material.dart';
import 'package:intouch/intouch_widgets/intouch_widgets.dart';
import 'package:intouch/models/category.dart';

class Notifications extends StatefulWidget {
  Notifications({
    super.key,
    this.categories});
  List<Category>? categories;
  
  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  final String title = 'Notifications';
  Set<Category> categorySelected = <Category> {};
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: inTouchAppBar(context,title, null,(){
        return null;
      }),
      body: Center(
        child: FilledButton(
          onPressed: (){
            showModalBottomSheet(

              context: context, 
              builder: (context){
                return StatefulBuilder(
                  builder: (BuildContext context, StateSetter setState)
                  {
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
                              children: widget.categories!.map(
                                (e) => FilterChip(
                                  selectedColor: Theme.of(context).colorScheme.primary.withOpacity(0.5),
                                  selectedShadowColor: Theme.of(context).colorScheme.primary.withOpacity(0.5),
                                  label: Text(e.name),
                                  selected: categorySelected.contains(e),
                                  onSelected: (bool selected){
                                    setState(() {
                                      selected? categorySelected.add(e): categorySelected.remove(e);
                                    });
                                  }))
                                .toList()
                                )
                              ),
                        ),
                      ],
                                        ),
                    );}
                );
              });
          }, 
          child: Text("Show Categories")),
      )
  );
  }
}