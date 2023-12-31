
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intouch/intouch_widgets/intouch_widgets.dart';
import 'package:intouch/intouch_widgets/profile_circle.dart';
import 'package:intouch/intouch_widgets/route_animations.dart';
import 'package:intouch/screens/home/pages/friends_list_page.dart';
import 'package:intouch/services/auth_service.dart';
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
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    
    
  }

 
  
  

  @override
  Widget build(BuildContext context){
    return Scaffold(         
                body: SafeArea(
                  minimum: EdgeInsets.all(8.0),
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
                              color: Colors.transparent,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: <Widget> [
                                          ProfileCircle(user: widget.user, radius: 64.0),
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
                                                  SizedBox( width: 12.0),
                                                  InkWell(
                                                    onTap: (){},
                                                    child: Column(
                                                      children: <Widget> [
                                                        Text(widget.user.joined!.length.toString()),
                                                        const Text('Events'),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox( width: 12.0),
                                                  InkWell(
                                                    onTap:(){},
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
                                        child:Container(
                                          height: 200,
                                          child: Column(
                                            crossAxisAlignment:CrossAxisAlignment.start,
                                            children: <Widget> [
                                              Text(widget.user.name!, textScaler: TextScaler.linear(1.5),),
                                              SizedBox(height: 12.0),
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
                                            context, "Ask to be Friends", Icons.add_reaction, true, (){}),
                                        ) ,
                                        Expanded(
                                          child: InTouchLongButton(
                                            context, "Favourites", Icons.list_alt, false, (){}),
                                        )
                                        ],
                                      )
                                      : const Row()],
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
                  ),
                )
              );
            }
            
}