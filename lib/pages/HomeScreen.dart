import 'package:flutter/material.dart';


class HomeScreen extends StatefulWidget{
  @override
  _HomeScreenState createState() => new _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: Container(
          child: Align(
            alignment: Alignment.center,
            child: Text("Bienvenido",style: TextStyle(fontSize: 24,color: Colors.green,fontWeight: FontWeight.bold),)
          ),
        )
    );
  }
}