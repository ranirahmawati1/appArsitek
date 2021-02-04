import 'package:flutter/material.dart';

class LCard extends StatefulWidget{
  @override
  _LCardState createState() => _LCardState();
}

class _LCardState extends State<LCard>{
  @override
  Widget build(BuildContext context){
    return SingleChildScrollView(
      child: Container(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: <Widget>[
                Card(
                  elevation: 16,
                  child: ListTile(
                    leading: Icon(Icons.album),
                    title: Text('Arsitek App'),
                    subtitle: Text('Kelompok 5'),
                  )
                )
              ]
            )
          )
        )
      )
    );
  }
}