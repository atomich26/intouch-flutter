
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intouch/intouch_widgets/route_animations.dart';
import 'package:intouch/models/event.dart';
import 'package:intouch/models/user.dart';
import 'package:intouch/screens/home/pages/event_form.dart';
import 'package:intouch/screens/home/pages/feed.dart';
import 'package:intouch/screens/home/pages/notifications.dart';
import 'package:intouch/screens/home/pages/post_form.dart';
import 'package:intouch/screens/home/pages/profile.dart';
import 'package:intouch/screens/home/pages/search.dart';
import 'package:intouch/screens/auth/category_selection.dart';




import '../../models/category.dart';
import '../../services/database.dart';

class Home extends StatefulWidget {
  const Home({super.key});



  @override
  State<Home> createState() => _HomeState();


}

class _HomeState extends State<Home> with AutomaticKeepAliveClientMixin  {
  @override 
bool get wantKeepAlive => true;
  
  late Future<List<Category>?> _categories;
  late Future<AppUserData> _userData;
  late Future<List<Event>?> _events;
  final CategoryDatabaseService _categoryDatabaseService = CategoryDatabaseService();
  final UserDatabaseService _userDatabaseService = UserDatabaseService();
  final EventDatabaseService _eventDatabaseService = EventDatabaseService();

  @override
  void initState() {
    super.initState();
    _categories = _categoryDatabaseService.getCategoriesFirestore();
    _userData = _userDatabaseService.getUserById(FirebaseAuth.instance.currentUser!.uid);
    _events = _eventDatabaseService.getEventsFirestore();
  }


  
  

  final PageController controller = PageController();
  //Controller for the navigation bar
  int _destinationIndex = 0;
  //Controller for the PageView
  int _pageIndex = 0;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
        body: FutureBuilder(
          future: Future.wait([_categories, _events]),
          builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
            return PageView(
              controller: controller,
              children: <Widget>[
                Feed(events: snapshot.data?[1],),
                Search(categories: snapshot.data?[0]),
                Notifications(categories: snapshot.data?[0]),
                Profile(user: _userData),                 
              ],
              //To sync the bottom navigation bar with pageview
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
              Navigator.of(context).push(fromTheBottom(EventForm()));
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
          //to sync the page with the bottom navigation bar
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