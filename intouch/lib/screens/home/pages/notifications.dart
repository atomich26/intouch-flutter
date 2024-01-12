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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
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
                        print(categorySelected);
                        selected? categorySelected.add(e): categorySelected.remove(e);
                      });
                    }) )
                  .toList()
            )
                ),
          ),
        ],
      )
  );
  }
}