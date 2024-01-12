
import 'package:flutter/material.dart';
import 'package:intouch/intouch_widgets/intouch_widgets.dart';
import 'package:intouch/intouch_widgets/postgrid.dart';
import 'package:intouch/intouch_widgets/profile_circle.dart';
import 'package:intouch/intouch_widgets/route_animations.dart';
import 'package:intouch/models/post.dart';
import 'package:intouch/screens/home/pages/friends_list_page.dart';
import 'package:intouch/services/auth_service.dart';
import 'package:intouch/services/database.dart';
import '../../../models/user.dart';

class Profile extends StatefulWidget {
  Future<AppUserData> user;
  Profile({
    super.key,
    required this.user});
  


  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;


  final String title = 'Profile';
  final AuthService _auth = AuthService();
  final PostDatabaseService _postDatabaseService = PostDatabaseService();
 
  
  

  @override
  Widget build(BuildContext context){
    Future<List<Post>?>? postByAuthor;
    return Scaffold(
        appBar: inTouchAppBar(context, title, Icons.exit_to_app, (){
          _auth.signOut();
            return null;}
            ),
            body: FutureBuilder<AppUserData?>(
               future: widget.user,
               builder: (context, user){
                return Container(
                  margin: const EdgeInsets.all(8.0),
                  child: CustomScrollView (
                    slivers:<Widget>[
                      SliverAppBar(
                        backgroundColor: Colors.white,
                        floating: true,
                        expandedHeight: MediaQuery.of(context).size.height/2,
                        bottom: const PreferredSize(
                          preferredSize: Size.fromHeight(60), 
                          child: Text('')),
                        flexibleSpace: FlexibleSpaceBar(
                          background: Container(
                            color: Colors.transparent,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: <Widget> [
                                        user.hasData? ProfileCircle(user: user.data, radius: 64.0): const CircleAvatar( foregroundImage: AssetImage("assets/images/intouch-default-user.png"), radius: 64,),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              children: <Widget> [
                                                InkWell(
                                                  onTap: (){
                                                    if(user.hasData){
                                                      if(user.data!.friends!.isNotEmpty){
                                                        Navigator.of(context).push(fromTheRight(FriendsListPage(friendId: user.data!.friends!)));
                                                      }
                                                    }
                                                  },
                                                  child: Column(
                                                    children: <Widget> [
                                                      Text(user.hasData? user.data!.friends!.length.toString(): "0"),
                                                      const Text('Friends'),
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox( width: 12.0),
                                                InkWell(
                                                  onTap: (){},
                                                  child: Column(
                                                    children: <Widget> [
                                                      Text(user.hasData? user.data!.joined!.length.toString(): "0"),
                                                      const Text('Events'),
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox( width: 12.0),
                                                InkWell(
                                                  onTap: (){},
                                                  child: Column(
                                                    children: <Widget> [
                                                      Text(user.hasData? user.data!.created!.length.toString(): "0"),
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
                                        height: 200,
                                        child: Column(
                                          crossAxisAlignment:CrossAxisAlignment.start,
                                          children: <Widget> [
                                            Text(user.hasData? user.data!.name!: "", textScaler: const TextScaler.linear(1.5),),
                                            const SizedBox(height: 12.0),
                                            Text(user.hasData? user.data!.biography!: "")
                                            ]
                                          
                                        ),
                                      ),
                                    ),
                                  ],
                                ), 
                              
                            ),
                          ),
                        ),
                      user.hasData?
                      FutureBuilder(
                        future: postByAuthor = _postDatabaseService.getPostByAuthorId(user.data!.id!) ,
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
                          ) : SliverGrid(
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
                          ),
                    ]
                  ),
                );
              }
            )
          );
        }
}