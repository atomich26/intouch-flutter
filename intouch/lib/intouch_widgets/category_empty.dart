import 'package:flutter/material.dart';

Padding CategoryEmpty() { 
  return Padding(
    padding: const EdgeInsets.all(12.0),
      child: Container( // to modify height, go to Search/gridDelegate/childAspectRatio
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
            color: Colors.grey[200],
            ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children:<Widget> [
                Expanded(
                  flex: 3,
                  child: Container(
                    height: double.infinity,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10.0),
                        topRight: Radius.circular(10.0)),
                        color: Colors.white30
                  ),
              ),
          ),
        const Expanded(
          flex: 1,
          child: Center(
            child: SizedBox(width: 1.0)))
        ],
      )
    )
  );
}
