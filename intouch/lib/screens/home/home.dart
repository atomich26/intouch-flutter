import 'dart:math';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:intouch/intouch_widgets/intouch_widgets.dart';
import 'package:intouch/screens/home/pages/feed.dart';
import 'package:intouch/screens/home/pages/notifications.dart';
import 'package:intouch/screens/home/pages/profile.dart';
import 'package:intouch/screens/home/pages/search.dart';
import 'package:intouch/screens/home/pages/event_form.dart';
import 'package:intouch/themes.dart';

import '../../models/category.dart';
import '../../services/cloud_functions.dart';

class Home extends StatefulWidget {
  const Home({super.key});



  @override
  State<Home> createState() => _HomeState();


}

class _HomeState extends State<Home> {

  @override
  void initState() {
    super.initState();
  }

  Future<List<Category>> _categories = getCategories();

  final PageController controller = PageController();
  int _destinationIndex = 0;
  int _pageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder<List<Category>>(
          future: _categories,
          builder: (context, categories) {
            return PageView(
              controller: controller,
              children: <Widget>[
                Feed(),
                categories.hasData? Search(categories: categories.data!): Notifications(),
                Notifications(),
                Profile(),
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
          NavigationDestination(
            icon: Icon(Icons.home_filled), 
            label: "Feed",
            ),
          NavigationDestination(
            icon: Icon(Icons.search_outlined), 
            label: "Search",
            ),
          IconButton(
            onPressed: (){
              getCategories();
            }, 
            icon: Icon(Icons.add_circle_rounded)
            ),
          NavigationDestination(
            icon: Icon(Icons.notifications), 
            label: "Notification",
            ),
          NavigationDestination(
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