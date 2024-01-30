import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class EventCard extends StatelessWidget {
  
  final BuildContext context;
  final String title;
  final String image;
  final DateTime date;
  final String city;
  
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
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
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
                    image,
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
                        title,
                        textScaler: const TextScaler.linear(1.5),
                        textAlign: TextAlign.start,),
                      Row(
                        children: <Widget> [
                          Row(
                            children: <Widget> [
                              const Icon(Icons.calendar_month),
                              Text(dateFormatter(date))
                            ],
                          ),
                          const Expanded(
                            child: SizedBox( width: double.infinity,) ),
                          Row(
                            children: <Widget> [
                              const Icon(Icons.location_pin),
                              Text(city)
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