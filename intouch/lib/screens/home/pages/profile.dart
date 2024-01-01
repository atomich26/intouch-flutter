
import 'package:flutter/material.dart';
import 'package:intouch/intouch_widgets/intouch_widgets.dart';
import 'package:intouch/intouch_widgets/profile_circle.dart';
import 'package:intouch/intouch_widgets/route_animations.dart';
import 'package:intouch/screens/home/pages/friends_list_page.dart';
import 'package:intouch/services/auth_service.dart';
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
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    
    
  }

  final String title = 'Profile';
  final AuthService _auth = AuthService();
 
  
  

  @override
  Widget build(BuildContext context){
    return Scaffold(
        appBar: inTouchAppBar(context, '$title', Icons.exit_to_app, (){
          _auth.signOut();
            return null;}
            ),
            body: FutureBuilder<AppUserData?>(
               future: widget.user,
               builder: (context, user){
                return Container(
                  margin: EdgeInsets.all(8.0),
                  child: CustomScrollView (
                    slivers:<Widget>[
                      SliverAppBar(
                        backgroundColor: Colors.white,
                        floating: true,
                        expandedHeight: MediaQuery.of(context).size.height/2,
                        bottom: PreferredSize(
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
                                        user.hasData? ProfileCircle(user: user.data, radius: 24.0): CircleAvatar( foregroundImage: AssetImage("assets/images/intouch-default-user.png") as ImageProvider, radius: 64,),
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
                                                SizedBox( width: 12.0),
                                                InkWell(
                                                  onTap: (){},
                                                  child: Column(
                                                    children: <Widget> [
                                                      Text(user.hasData? user.data!.joined!.length.toString(): "0"),
                                                      const Text('Events'),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox( width: 12.0),
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
                                      child:Container(
                                        height: 200,
                                        child: Column(
                                          crossAxisAlignment:CrossAxisAlignment.start,
                                          children: <Widget> [
                                            Text(user.hasData? user.data!.name!: "", textScaler: TextScaler.linear(1.5),),
                                            SizedBox(height: 12.0),
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
                      SliverGrid(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: 0.7),
                        delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                            return Container(
                              padding:EdgeInsets.all(8.0),
                              alignment: Alignment.center,
                              color: Colors.teal[100 * (index % 9)],
                              child: Text('Grid Item $index'),
                            );
                          },
                          childCount: 50,
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