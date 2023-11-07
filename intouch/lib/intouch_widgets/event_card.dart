import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class EventCard extends StatelessWidget {
  
  BuildContext context;
  String title;
  String image;
  DateTime date;
  String city;
  
  EventCard({
    super.key,
    required this.context,
    required this.title,
    required this.image,
    required this.date,
    required this.city});


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
        child: Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            side: BorderSide(
              color: Colors.black,
              width: 2.0,
            )
          ),
          child: Column(
            children: <Widget> [
              Expanded(
                flex: 3,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: Image.asset(
                    '${image}',
                    fit: BoxFit.cover,
                    height: double.maxFinite,
                    width: double.maxFinite,),
                )),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget> [
                      Text(
                        '${title}',
                        textScaleFactor: 1.5,
                        textAlign: TextAlign.start,),
                      Row(
                        children: <Widget> [
                          Row(
                            children: <Widget> [
                              Icon(Icons.calendar_month),
                              Text(dateFormatter(date))
                            ],
                          ),
                          Expanded(
                            child: SizedBox( width: double.infinity,) ),
                          Row(
                            children: <Widget> [
                              Icon(Icons.location_pin),
                              Text('${city}')
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                )
              )
            ]
          ),
        ),
      ),
    );
  }
}

String dateFormatter (DateTime date){
  return DateFormat.yMMMd().format(date);
}