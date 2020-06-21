import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:login_app/pages/HomeScreen.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Wrap(
        children: <Widget>[
          Padding(padding: EdgeInsets.fromLTRB(50, 150, 0, 0),
            child: Text("Hello",style: TextStyle(fontSize: 60,fontWeight: FontWeight.bold),),
          ),
          Padding(padding: EdgeInsets.fromLTRB(50, 0, 0, 0),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Wrap(
                children: <Widget>[
                  Text("There",style: TextStyle(fontSize: 60,fontWeight: FontWeight.bold),),
                  Padding(padding: EdgeInsets.fromLTRB(5, 40, 0, 0),
                    child: Image.network("https://www.vippng.com/png/full/105-1052513_carpet-clipart-oval-rug-circulo-color-azul-y.png",fit: BoxFit.contain,width: 20,),
                  )
                ],
              ),
            ),
          ),
          Padding(padding: EdgeInsets.fromLTRB(50, 60, 0, 0),
            child: RichText(text: TextSpan(
              children: [
                TextSpan(text: "EMAIL",style: TextStyle(
                  fontSize: 15.0,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                )),
              ]
            )),

          ),
          Padding(
            padding: EdgeInsets.fromLTRB(50.0, 0, 50.0, 0.0),
            child: TextField(
              controller: _emailController,
              style: TextStyle(
                fontSize: 15.0,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(padding: EdgeInsets.fromLTRB(50, 20, 0, 0),
            child: RichText(text: TextSpan(
                children: [
                  TextSpan(text: "PASSWORD",style: TextStyle(
                    fontSize: 15.0,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  )),

                ]
            )),

          ),
          Padding(
            padding: EdgeInsets.fromLTRB(50.0, 0, 50.0, 0.0),
            child: TextField(
              controller: _passwordController,
              style: TextStyle(
                fontSize: 15.0,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(50, 10, 50, 0),
            child: Align(
              alignment: Alignment.centerRight,
              child: Text("Forgot password?",style: TextStyle(fontSize: 15.0,color: Colors.green,fontWeight: FontWeight.bold),),
            ),
          ),
          Center(
            child: Container(
              margin: EdgeInsets.fromLTRB(0, 40, 0, 0),
              width: 280,
              height: 50.0,
              child: RaisedButton(
                  child: Text("LOGIN", style: TextStyle(color: Colors.white, fontSize: 14.0,fontWeight: FontWeight.bold)),
                  color: Colors.green,
                  onPressed: (){
                    requestLoginAPI(context, _emailController.text, _passwordController.text);
                    print("Hola");
                  },
                  shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0))
              ),
            ),
          ),
          Center(
            child: Container(
              margin: EdgeInsets.fromLTRB(0, 10, 0, 30),
              width: 280,
              height: 50.0,
              decoration: new BoxDecoration(
                border: new Border.all(color: Colors.black, width: 2.0),
                borderRadius: new BorderRadius.circular(30.0),
              ),

              child: RaisedButton(
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Wrap(
                      children: <Widget>[
                        Center(
                          child: Wrap(
                            children: <Widget>[
                              Padding(padding: EdgeInsets.fromLTRB(5, 0, 10, 10),
                                child: Image.network("https://image.flaticon.com/icons/png/512/59/59439.png",fit: BoxFit.contain,width: 20,),
                              ),
                              Text("Log in with Facebook", style: TextStyle(color: Colors.black, fontSize: 14.0,fontWeight: FontWeight.bold)),
                            ],
                          ),
                        )

                      ],
                    ),
                  ),
                  color: Colors.white,
                  hoverColor: Colors.black,
                  onPressed: (){
                    print('Hola');
                  },
                  shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0))
              ),
            ),
          ),
          Center(
            child: Wrap(
              children: <Widget>[
                Text("New in Spotify?",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
                Text("Register",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color: Colors.green),),
              ],
            ),
          ),



        ],

      ),

    );
  }
}

Future requestLoginAPI(BuildContext context, String email, String password)async   {
  final url = 'https://00d9a6a3bfea.ngrok.io/api/v1/login/';
  print(email);
  print(password);


  Map<String, String> body = {
    'username': email,
    'password': password,
  };

  final response = await http.post(
    url,
    body: body,
  );

  print(response.statusCode);

  if (response.statusCode == 200) {
    final responseJson = json.decode(response.body);
    print(responseJson);
    print("correcto");

    Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()),);

    return null;
  } else {
    final responseJson = json.decode(response.body);
    print(responseJson);
    print("Error");
    showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: Text("Email o Password invalid"),
            content: Text("check your credentials"),
          );
        }
    );

    return null;
  }

}

