import 'package:flutter/material.dart';

import 'Kelimeler.dart';

class DetailedScreen extends StatefulWidget {
  Kelimeler kelime;

  DetailedScreen({required this.kelime});

  @override
  _DetailedScreenState createState() => _DetailedScreenState();
}

class _DetailedScreenState extends State<DetailedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(""),
      ),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children:  [
              Text(widget.kelime.ingilizce, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40, color: Colors.pinkAccent),),
              Text(widget.kelime.turkce, style: TextStyle(fontSize: 40,),),
            ]
        ),
      ),
    );
  }
}
