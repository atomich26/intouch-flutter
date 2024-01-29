
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intouch/intouch_widgets/intouch_widgets.dart';
import 'package:intouch/intouch_widgets/post_grid.dart';
import 'package:intouch/intouch_widgets/profile_circle.dart';
import 'package:intouch/intouch_widgets/route_animations.dart';
import 'package:intouch/models/category.dart';
import 'package:intouch/models/post.dart';
import 'package:intouch/screens/home/pages/event_list_page.dart';
import 'package:intouch/screens/home/pages/friends_list_page.dart';
import 'package:intouch/services/database.dart';
import '../../../models/user.dart';

class ProfilePage extends StatefulWidget {
  AppUserData user;
  ProfilePage({
    super.key,
    required this.user});
  


  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  final PostDatabaseService _postDatabaseService = PostDatabaseService();


  @override
  Widget build(BuildContext context){
    Future<List<Post>?>? postByAuthor = _postDatabaseService.getPostByAuthorId(widget.user.id!);
    return Scaffold(         
                body: SafeArea(
                  minimum: const EdgeInsets.all(8.0),
                  child: Container(
                    child: CustomScrollView (
                      slivers:<Widget>[
                        SliverAppBar(
                          backgroundColor: Colors.white,
                          floating: true,
                          snap: true,
                          expandedHeight: MediaQuery.of(context).size.height/2,
                          flexibleSpace: FlexibleSpaceBar(
                            background: Container(
                              padding: const EdgeInsets.fromLTRB(0, 20.0, 0, 0),
                              color: Colors.transparent,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: <Widget> [
                                          ProfileCircle(user: widget.user, radius: 48.0),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                children: <Widget> [
                                                  InkWell(
                                                    onTap:(){

                                                      widget.user.friends!.isNotEmpty ? Navigator.of(context).push(fromTheRight(FriendsListPage(friendId: widget.user.friends!))) : null;
                                                    },
                                                    child: Column(
                                                      children: <Widget> [
                                                        Text( widget.user.friends!.length.toString()),
                                                        const Text('Friends'),
                                                      ],
                                                    ),
                                                  ),
                                                  const SizedBox( width: 12.0),
                                                  InkWell(
                                                    onTap: (){
                                                      if(widget.user.joined!.isNotEmpty){
                                                        Navigator.of(context).push(fromTheRight(EventsListPage(eventId: widget.user.joined!)));
                                                      }
                                                    },
                                                    child: Column(
                                                      children: <Widget> [
                                                        Text(widget.user.joined!.length.toString()),
                                                        const Text('Events'),
                                                      ],
                                                    ),
                                                  ),
                                                  const SizedBox( width: 12.0),
                                                  InkWell(
                                                    onTap:(){
                                                      if(widget.user.created!.isNotEmpty){
                                                        Navigator.of(context).push(fromTheRight(EventsListPage(eventId: widget.user.created!)));
                                                      }
                                                    },
                                                    child: Column(
                                                      children: <Widget> [
                                                        Text(widget.user.created!.length.toString()),
                                                        const Text('Created'),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child:SizedBox(
                                          height: 150,
                                          child: Column(
                                            crossAxisAlignment:CrossAxisAlignment.start,
                                            children: <Widget> [
                                              Text(widget.user.name!, textScaler: const TextScaler.linear(1.5),),
                                              const SizedBox(height: 12.0),
                                              Text(widget.user.biography!)
                                              ]
                                          ),
                                        ),
                                      ),
                                  
                                    widget.user.id != FirebaseAuth.instance.currentUser!.uid? 
                                      Row(
                                        children: <Widget> [
                                        Expanded(
                                          child: InTouchLongButton(
                                            context, "Friend Request", Icons.add_reaction, true, (){
                                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Function not implemented in Demo version")));
                                            }),
                                        ) ,
                                        Expanded(
                                          child: InTouchLongButton(
                                            context, "Favourites", Icons.list_alt, false, (){
                                              _showPreferences(context, widget.user);
                                            }),
                                        )
                                        ],
                                      )
                                      : const Row()],
                                  ), 
                                
                              ),
                            ),
                          ),
                        FutureBuilder(
                          future: postByAuthor,
                          builder: (context, snapshot) {
                           return snapshot.hasData?
                              SliverGrid(
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 8.0,
                              mainAxisSpacing: 8.0
                              ),
                            delegate: SliverChildBuilderDelegate(
                              (BuildContext context, int index) {
                                return PostGrid(post: snapshot.data![index]);
                                
                              },
                              childCount: snapshot.data!.length,
                            ),
                            ): SliverGrid(
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              childAspectRatio: 0.7),
                            delegate: SliverChildBuilderDelegate(
                              (BuildContext context, int index) {
                                return Container(
                                  padding:const EdgeInsets.all(8.0),
                                  alignment: Alignment.center,
                                  color: Colors.teal[100 * (index % 9)],
                                  child: Text('Grid Item $index'),
                                );
                              },
                              childCount: 0,
                            ),
                          );  
                          }
                        ),
                      ]
                    ),
                  ),
                )
              );
            }
            
}

void _showPreferences(BuildContext context, AppUserData user){
  final CategoryDatabaseService categoryDatabaseService =CategoryDatabaseService();
  List<Future<Category>> preferences = List.generate(user.preferences!.length, (e) => categoryDatabaseService.getCategorybyId(user.preferences?[e]));
  showModalBottomSheet(
    context: context, 
    builder: (context){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: SingleChildScrollView(
              child: Wrap(
                spacing: 7.5,
                children: preferences.map((e) => 
                  FutureBuilder(
                    future: e, builder:(context, preference){
                      return !preference.hasData? const SizedBox.shrink() :Chip(label: Text(preference.data!.name));
                    })).toList()
              ),
            ),
          ),
        ],
      ),
    );

  });
}