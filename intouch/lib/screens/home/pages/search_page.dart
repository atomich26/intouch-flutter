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
  //initial setting
  String centerPageString = "Search what you like";
  //controller if first search is made
  bool searchDone = false;
  //switch between user search and event search
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
                //check the presence of @ at the beginning of the query
                if(_searchController.text.startsWith("@")){
                  //sanitize query
                  String search = _searchController.text.substring(1);
                  //check if sanitized query is empty
                  if(search != ""){
                    searchDone = true;
                    userSearch = true;
                  } else {
                    searchDone = false;
                    centerPageString = "The search query cannot be empty";
                    }
                  } else {
                    //check if query is empty
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
      //check if search has been made
      body: (searchDone == false) ? 
        Center(
          child: Column(
            children: [
              Text(centerPageString),
            ],
          )
        )
      //check if it is an event or user search
       : (userSearch == true) ? 
        SearchPageUser(query: _searchController.text.substring(1)) : SearchPageEvent(query: _searchController.text),
      );
    }
}
