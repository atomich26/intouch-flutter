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

class _CategoryBoxState extends State<CategoryBox> with AutomaticKeepAliveClientMixin{
  //bool _isSelected = false;
  @override
  bool get wantKeepAlive => true;
  final StorageService _storageRef = StorageService();
  

  @override
  Widget build(BuildContext context) {
    super.build(context);
    Future<String>? imageUrl = _storageRef.getCategoryImageUrl(widget.cover);
    return FutureBuilder(
      future: imageUrl,
      builder: (context, imageUrl) {
        return Padding(
          padding: const EdgeInsets.all(12.0),
          child: Container( // to modify height, go to Search/gridDelegate/childAspectRatio
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.purple[50],
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
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 2.5),
                        child: Text(widget.name, textAlign: TextAlign.center, textScaler: const TextScaler.linear(0.9), style: const TextStyle(fontWeight: FontWeight.bold),),
                      )
                    )
                  )
                ],
            )
          )
        );
      }
    );
  }
}