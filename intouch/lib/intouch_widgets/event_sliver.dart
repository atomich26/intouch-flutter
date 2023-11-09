import 'package:flutter/material.dart';
import 'package:intouch/intouch_widgets/intouch_widgets.dart';
import 'package:intouch/models/category.dart';



class EventSliver extends StatefulWidget {
  
  Category event;
  String image;

  EventSliver({
    super.key,
    required this.event,
    required this.image});

  @override
  State<EventSliver> createState() => _EventSliverState();
}

class _EventSliverState extends State<EventSliver> {
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[50],
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            
            //stretch: true,
            floating: true,
            snap:true,
            pinned: true,
            leading: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey.withOpacity(0.5)
                  ),
                  child: IconButton.filled(
                    onPressed: Navigator.of(context).pop, 
                    icon: Icon(Icons.arrow_back_outlined), 
                    color: Colors.white,
                    style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll<Color>(Colors.black.withOpacity(0.8))),
                      
                      ),
                  ),
                ),
            expandedHeight: 350.0,
            
            elevation: 0.0,
            backgroundColor: Colors.purple[50],
            flexibleSpace: Stack(
              children: <Widget> [
                    Hero(
                    tag: 'eventImage${widget.event.name}', 
                    child: 
                        Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(widget.image),
                              fit: BoxFit.cover,
                              alignment: Alignment.topCenter)
                          ),
                        ),
                      )
                    ]
                  ),
                ),
        SliverList.list(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.event.name,
                textAlign: TextAlign.left,
                textScaleFactor: 2.5,
                style: TextStyle(fontWeight: FontWeight.bold),),
              ),
            SizedBox(height: 8.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget> [
                    CircleAvatar(
                      radius: 24.0,
                      foregroundColor: Colors.blueAccent,
                    ),
                    SizedBox( width: 8.0),
                    Text('Some Stupid Fool')
                  ],
                )
              ),
            ),
            Column(
              children:[
                Row(
                  children: <Widget> [
                  Icon(Icons.place, size: 28.0,),
                  Text("Somewhere far far away", textScaleFactor: 1.4)
                    ],
                  ),
                SizedBox(height: 12.0),
                Row(
                  children: <Widget> [
                  Icon(Icons.calendar_month, size: 28.0,),
                  Text("01/01/00 20:30", textScaleFactor: 1.4)
                    ],
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(dummy),
                      Text(dummy),
                      Text(dummy),
                      Text(dummy),
                      Text(dummy),
                    ],
                  ),
                ),
                
                                  
                                  
                              ],
                            ), 
            
          ]
        )
      ],
    ),
    floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        color: Colors.purple[50],
        child: InTouchLongButton(
                                context, 
                                isSelected? "I'll Pass": "I'll be there!", 
                                null, 
                                isSelected? false: true, 
                                () {
                                  setState(() {
                                    isSelected = !isSelected;
                                  });
                                }),
      ),);
  }
}

String dummy = "nfgsngnalgnklnfksdlnflsndlfklnasd nfslkdnlkndklnfn woeifion igiosdjfj oifjfi jsi doanvasoiaiofu iounufvunvy89ruifuoiaeuiouweoqupiuaoeifaè0aèeiopgaopgueopug opumpu09cuu9gmuaoguureug08regy89ut9u4oi3tqopumgo9ugoiuaeougmpweg0u09a4t9g9aunr09g90wmt048tt8u09weug9aurg09uapm0r8g9rumg9we8rgmrg809eragr9e8g90a8gm9g890g8m4308tm0eu9 9we08wm809a 9wemwe90u9sumg9p0au904ygy98tm a u uwe 90g ua90 9wu9ug uau' ure9gu g4 u'94u9 grugu9 au90gr' 0r 'u9g 9u0u wru9g9ur' u u9 gu r0 g9uau'g9uueru0gu uu9u9 ug09rugug90a uu 9gu9r0ag uu uau 9u990rgufodijaihahgeu mu h  io ha ighog hawrp8u90u90usf u9u9 uau weuupweuio fwueguuu9 u909 gu yigousoigys n";