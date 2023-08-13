import 'package:flutter/material.dart';

class eventForm extends StatelessWidget {
  const eventForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body:Center(
        child:Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text("This is the Event Form"),
            SizedBox(height: 40,),
            FilledButton(
              onPressed: (){
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Content Posted"),
                    duration: Duration(seconds: 1) )
                );
              }, 
              child: Text("Post"))
          ],
        ),
        
      ),
    );
  }
}