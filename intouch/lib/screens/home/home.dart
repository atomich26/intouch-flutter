
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intouch/models/user.dart';
import 'package:intouch/screens/home/pages/feed.dart';
import 'package:intouch/screens/home/pages/notifications.dart';
import 'package:intouch/screens/home/pages/profile.dart';
import 'package:intouch/screens/home/pages/search.dart';



import '../../models/category.dart';
import '../../services/cloud_functions.dart';
import '../../services/database.dart';

class Home extends StatefulWidget {
  const Home({super.key});



  @override
  State<Home> createState() => _HomeState();


}

class _HomeState extends State<Home> {
  
  
  late Future<List<Category>?> _categories;
  late Future<AppUserData> _userData;
  CategoryDatabaseService _categoryDatabaseService = CategoryDatabaseService();
  UserDatabaseService _userDatabaseService =UserDatabaseService();

  @override
  void initState() {
    super.initState();
     _categories = _categoryDatabaseService.getCategoriesFirestore();
    _userData = _userDatabaseService.getUserById(FirebaseAuth.instance.currentUser!.uid);
    
  }


  
  

  final PageController controller = PageController();
  int _destinationIndex = 0;
  int _pageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder<List<Category>?>(
          future: _categories,
          builder: (context, categories) {
            return PageView(
              controller: controller,
              children: <Widget>[
                Feed(categories: categories.data,),
                Search(categories: categories.data),
                const Notifications(),
                Profile(user: _userData),                 
              ],
              onPageChanged: (page) {
                setState(() {
                      _pageIndex = page;
                        if(page > 1)  {
                        _destinationIndex = page+1;
                         }
                       else {
                       _destinationIndex = page;
                      }
                    
                   });
              });
          }
        ),
      bottomNavigationBar: NavigationBar(
        labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
        selectedIndex: _destinationIndex,
        destinations: [
          const NavigationDestination(
            icon: Icon(Icons.home_filled), 
            label: "Feed",
            ),
          const NavigationDestination(
            icon: Icon(Icons.search_outlined), 
            label: "Search",
            ),
          IconButton(
            onPressed: (){
              //Navigator.of(context).push(fromTheBottom(EventForm()));
              //print(FirebaseAuth.instance.currentUser!.uid);
              _categoryDatabaseService.getCategoriesFirestore();
            }, 
            icon: const Icon(Icons.add_circle_rounded)
            ),
          const NavigationDestination(
            icon: Icon(Icons.notifications), 
            label: "Notification",
            ),
          const NavigationDestination(
            icon: Icon(Icons.person), 
            label: "Profile",
            ),
          ],
          onDestinationSelected: (destination) =>setState (()
            {
              if(destination != 2)
              {
                _destinationIndex = destination;
              if (_destinationIndex > 1) 
                {
                  _pageIndex = _destinationIndex-1;
                }
              else {
                _pageIndex = _destinationIndex;
              }
              controller.jumpToPage(_pageIndex,);
            }
          }
          ) ,
        ),
    );
  }
}