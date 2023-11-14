import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intouch/intouch_widgets/intouch_widgets.dart';
import 'package:intouch/services/auth_service.dart';
import '../../../models/user.dart';
import '../../../wrapper.dart';


class Profile extends StatefulWidget {
  Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  @override
  void initState() {
    super.initState();
    print('Profile function activation');
    
  }

  final String title = 'Profile';

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: inTouchAppBar(context, '$title'),
            body: Container(
              margin: EdgeInsets.all(8.0),
              child: CustomScrollView (
                slivers:<Widget>[
                  SliverAppBar(
                    backgroundColor: Colors.white,
                    expandedHeight: 350.0,
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
                                    CircleAvatar(
                                      backgroundColor: Colors.greenAccent,
                                      radius: 64.0,
                                      ),
                                    Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              children: <Widget> [
                                                Text('52'),
                                                Text('Option 1'),
                                              ],
                                            ),
                                            Column(
                                              children: <Widget> [
                                                Text('222'),
                                                Text('option 2'),
                                              ],
                                            ),
                                            Column(
                                              children: <Widget> [
                                                Text('15'),
                                                Text('option 3'),
                                              ],
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              constraints: BoxConstraints(maxWidth: 200.0),
                                                  child: InTouchLongButton(context, 'Log Out (Temp)', null, true, () async {
                                                    await _auth.signOut()
                                                    .then((result){
                                                      Navigator.pushAndRemoveUntil(
                                                      context, 
                                                      MaterialPageRoute(builder: (BuildContext context) => Wrapper()),
                                                      (route) => false);});
                                                  }),
                                                ),
                                              ],
                                            ),
                                        ],
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child:Column(
                                    crossAxisAlignment:CrossAxisAlignment.start,
                                    children: <Widget> [
                                      Text('Something Rather', textScaleFactor: 1.5,),
                                      SizedBox(height: 12.0),
                                      Text('Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec.')
                                      ]
                                    
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
            )
          );
        }
}