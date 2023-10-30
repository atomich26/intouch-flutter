import 'dart:collection';

class Category{
  late String id;
  late String name;
  late String cover;
  
  Category ({
    required this.id,
    required this.name,
    required this.cover
  });

  factory Category.fromMap(HashMap<String, dynamic> data){
    return Category(
      id : data['id']!, 
      name : data['name']!,
      cover : data['cover']!);
    
  }
}