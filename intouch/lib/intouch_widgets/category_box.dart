import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:intouch/services/firebase_storage.dart';

class CategoryBox extends StatefulWidget {
  
  BuildContext context;
  String id;
  String name;
  String cover;
  
  CategoryBox({
    super.key,
    required this.context,
    required this.id,
    required this.name,
    required this.cover});

  @override
  State<CategoryBox> createState() => _CategoryBoxState();
}

class _CategoryBoxState extends State<CategoryBox> {
  //bool _isSelected = false;
  final StorageService _storageRef = StorageService();
  

  @override
  Widget build(BuildContext context) {

    Future<String> imageUrl = _storageRef.getImageUrl(widget.cover);
    return FutureBuilder(
      future: imageUrl,
      builder: (context, imageUrl) {
        return Padding(
          padding: const EdgeInsets.all(12.0),
          child: Container( // to modify height, go to Search/gridDelegate/childAspectRatio
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.grey[200],
              ),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:<Widget> [
                  Expanded(
                    flex: 3,
                    child: Container(
                      height: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
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
                      child: Text(widget.name)))
                ],
            )
          )
        );
      }
    );
  }
}