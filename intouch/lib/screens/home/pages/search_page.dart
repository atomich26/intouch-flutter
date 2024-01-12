import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intouch/screens/home/pages/search_pages/search_page_event.dart';
import 'package:intouch/screens/home/pages/search_pages/search_page_user.dart';


class SearchPage extends StatefulWidget {
  const SearchPage({
    super.key,});
  
  

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();

  String centerPageString = "Search what you like";
  bool searchDone = false;
  bool userSearch = true;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent, 
        iconTheme: const IconThemeData(color: Colors.black),
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        title: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            suffixIcon: IconButton(icon: const Icon(Icons.search_rounded), onPressed: (){
              setState(() {
                if(_searchController.text.startsWith("@")){
                  String search = _searchController.text.substring(1);
                  if(search != ""){
                    searchDone = true;
                    userSearch = true;
                  } else {
                    searchDone = false;
                    centerPageString = "The search query cannot be empty";
                    }
                  } else {
                    if(_searchController.text != ""){
                      searchDone = true;
                      userSearch = false;
                    } else {
                      searchDone = false;
                      centerPageString = "The search query cannot be empty";
                    }
                  }
                }); 
              },
            )
          ),
        ),
      ),
      body: (searchDone == false) ? 
        Center(
          child: Column(
            children: [
              Text(centerPageString),
            ],
          )
        )
       : (userSearch == true) ? 
        SearchPageUser(query: _searchController.text.substring(1)) : SearchPageEvent(query: _searchController.text),
        
      );
    }
}
