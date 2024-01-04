import 'package:flutter/material.dart';
import 'package:intouch/intouch_widgets/route_animations.dart';
import 'package:intouch/models/category.dart';
import 'package:intouch/screens/home/pages/search_pages/search_category_page.dart';
import 'package:intouch/services/firebase_storage.dart';

class CategoryBox extends StatefulWidget {
  
  BuildContext context;
  Category category;
  
  CategoryBox({
    super.key,
    required this.context,
    required this.category});

  @override
  State<CategoryBox> createState() => _CategoryBoxState();
}

class _CategoryBoxState extends State<CategoryBox> with AutomaticKeepAliveClientMixin{
  
  @override
  bool get wantKeepAlive => true;
  final StorageService _storageRef = StorageService();
  bool _isSelected = false;
  

  @override
  Widget build(BuildContext context) {
    super.build(context);
    Future<String>? imageUrl = _storageRef.getCategoryImageUrl(widget.category.cover);
    return FutureBuilder(
      future: imageUrl,
      builder: (context, imageUrl) {
        return InkWell(
          onTap:(){
            Navigator.of(context).push(fromTheRight(SearchCategoryPage(category: widget.category, image:imageUrl.data!)));
          },
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container( // to modify height, go to Search/gridDelegate/childAspectRatio
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: _isSelected? Colors.purple[300] : Colors.purple[50],
                ),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:<Widget> [
                    Expanded(
                      flex: 3,
                      child: Container(
                        height: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10.0),
                            topRight: Radius.circular(10.0)),
                          image: DecorationImage(
                              image: imageUrl.hasData? NetworkImage(imageUrl.data!) : const AssetImage("assets/images/intouch-default.png") as ImageProvider,
                              fit: BoxFit.cover,)
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Center(   
                            widthFactor: MediaQuery.of(context).size.width,
                            heightFactor: MediaQuery.of(context).size.height,
                            child: Text(
                              widget.category.name, 
                              textAlign: TextAlign.center, 
                              textScaler: const TextScaler.linear(0.8), 
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: _isSelected? Colors.white: Colors.black)),
                      )
                    )
                  ],
              )
            )
          ),
        );
      }
    );
  }
}