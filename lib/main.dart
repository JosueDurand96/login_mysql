import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:login_mysql/model/admin.dart';
import 'AdminPage.dart';
import 'MemberPage.dart';

void main() => runApp(MyApp());

String username='';

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Canchas Deportivas',
      theme: ThemeData(fontFamily: 'Roboto'),
      home: new MyHomePage(),
      routes: <String,WidgetBuilder>{
        '/AdminPage': (BuildContext context)=> new AdminPage(username: username,),
        '/MemberPage': (BuildContext context)=> new MemberPage(username: username,),
        '/MyHomePage': (BuildContext context)=> new MyHomePage(),
      },
    );
  }
}
bool _autovalidate = false;
bool _formWasEdited = false;





class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  TextEditingController user = new TextEditingController();
  TextEditingController pass = new TextEditingController();

  String msg = '';
  String _baseUrl = 'http://192.168.1.134/Login/login.php?';

  Future<dynamic> getJson(Uri uri) async {
    http.Response response = await http.post(uri);
    //llamamos el objetivo json de dart   y decodificar
    return json.decode(response.body);
  }


  Future<List> _login() async {
    final response = await http.post(_baseUrl, body: {
      "username": user.text,
      "password": pass.text,
    });

    print(response);
    var datauser = json.decode(response.body);

    if (datauser.length == 0) {
      setState(() {
        msg = "Login Fail";
      });
    } else {
      if (datauser[0]['level'] == 'admin') {
        Navigator.pushReplacementNamed(context, '/AdminPage');
      } else if (datauser[0]['level'] == 'member') {
        Navigator.pushReplacementNamed(context, '/MemberPage');
      }

      setState(() {
        username = datauser[0]['username'];
      });
    }

    return datauser;
  }


  @override
  Widget build(BuildContext context) {
  return new Scaffold(
  body: Center(
  child: Column(
  mainAxisAlignment: MainAxisAlignment.center,
  children: <Widget>[
  new Stack(
  alignment: Alignment.center,
  children:<Widget>[
  new Container(
  height: 60.0,
  width: 60.0,
  decoration: new BoxDecoration(
  borderRadius: new BorderRadius.circular(50.0),
  color: Color(0xFF18D191)
  ),
  child: new Icon(Icons.directions_walk,color: Colors.white,),
  ),
  new Container(
  margin: new EdgeInsets.only(right: 50.0,top:50.0),

  height: 60.0,
  width: 60.0,
  decoration: new BoxDecoration(
  borderRadius: new BorderRadius.circular(50.0),
  color: Color(0xFFFC6A7F),
  ),
  child: new Icon(Icons.directions_walk,color: Colors.white,),
  ),
  new Container(
  margin: new EdgeInsets.only(left: 30.0,top:50.0),

  height: 60.0,
  width: 60.0,
  decoration: new BoxDecoration(
  borderRadius: new BorderRadius.circular(50.0),
  color: Color(0xFFFFCE56)
  ),
  child: new Icon(Icons.monetization_on,color: Colors.white,),
  )

  ],
  ),
  new Row(

  mainAxisAlignment: MainAxisAlignment.center,
  children: <Widget>[
  Padding(
  padding: const EdgeInsets.only(top:8.0,bottom: 80.0),
  child: new Text("Pichanga Admin",style: new TextStyle(fontSize: 40.0),
  )
  )
  ],),
  //TODO: TEXTBOX
  new TextField(
    controller: user,
    decoration: new InputDecoration(
     labelText: "Correo",fillColor: Colors.red,icon: const Padding(
        padding: const EdgeInsets.only(top:15.0),
        child: const Icon(Icons.person))),
  ),

  new TextField(
    key: widget.key,
    autofocus: false,
    obscureText: true,
    maxLength: 8,
    controller: pass,
    decoration: const InputDecoration(

  labelText: "Password",fillColor: Colors.red,icon: const Padding(
        padding: const EdgeInsets.only(top: 15.0),
        
        child: const Icon(Icons.lock))),


  ),
      new RaisedButton(
        padding: EdgeInsets.only(top:0,bottom: 0),
            child: Material(
              borderRadius: BorderRadius.circular(100.0),
              shadowColor: Colors.green,
              elevation: 1000.0,
              child: MaterialButton(
                minWidth: 200.0,
                height: 60.0,
                onPressed: () {
                  _login();
                },
                color: Color(0xFF18D191),

                child: Text('Iniciar Sesión', style: TextStyle(fontSize: 20.0,color: Colors.white)),
              ),
            ),
          ),


  new Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: <Widget>[
    new RaisedButton(
      padding: EdgeInsets.only(top: 0),
      child: Material(
        borderRadius: BorderRadius.circular(100.0),
        shadowColor: Colors.green,
        elevation: 5.0,
        child: MaterialButton(
          minWidth: 200.0,
          height: 60.0,
          onPressed: () {
            _login();
          },
          color: Color(0xFF4364A1),
          child: Text('Facebook', style: TextStyle(fontSize: 20.0,color: Colors.white)),
        ),
      ),
        ),   // 0xFF4364A1 0xFFDF513B
    new RaisedButton(
      padding: EdgeInsets.only(top: 0),
      child: Material(
        borderRadius: BorderRadius.circular(100.0),
        shadowColor: Colors.green,
        elevation: 5.0,
       // margin:  EdgeInsets.only(top:30.0,left: 30.0,bottom: 30.0,right: 30.0),
        child: MaterialButton(
          minWidth: 200.0,
          height: 60.0,
          onPressed: () {
            _login();
          },
          color: Color(0xFFDF513B),
          padding: EdgeInsets.only(left: 1.2, top:1.2, right:1.2, bottom:1),
          child: Text('Gmail', style: TextStyle(fontSize: 20.0,color: Colors.white)),
        ),
      ),),
    Text(msg,style: TextStyle(fontSize: 20.0,color: Colors.red),)
  ],
  ),
  ],
  ),
  ),
  );
  }
  }

//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(title: Text("Canchas Deportivas"),),
//
//      body: Container(
//        child: Center(
//          child: Column(
//            children: <Widget>[
//              Text("Username",style: TextStyle(fontSize: 18.0),),
//              TextField(
//                controller: user,
//                decoration: InputDecoration(
//                    hintText: 'Username'
//                ),
//              ),
//              Text("Password",style: TextStyle(fontSize: 18.0),),
//              TextField(
//                controller: pass,
//                obscureText: true,
//                decoration: InputDecoration(
//                    hintText: 'Password'
//                ),
//              ),
//              new RaisedButton(
//
//               child: new Container(
//                 //padding: const EdgeInsets.only(left: 20.0,right: 10.0,top:10.0,bottom: 80.0),
//                 padding: const EdgeInsets.all(10.0),
//                 margin:  EdgeInsets.only(top:30.0,left: 30.0,bottom: 30.0,right: 30.0),
//                 alignment: Alignment.center,
//                 height: 60.0,
//                 decoration: new BoxDecoration(color: Colors.cyan,borderRadius: new BorderRadius.circular(10.0)),
//                 child: new Text("Iniciar Sesión",style: new TextStyle(fontSize: 27.0,color: Colors.white),),
//               ),
//                onPressed: (){
//                  _login();
//
//                },
//              ),
//              new RaisedButton(
//                child: new Container(
//                  padding: const EdgeInsets.all(10.0),
//                  margin:  EdgeInsets.only(top:30.0,left: 30.0,bottom: 30.0,right: 30.0),
//
//                  alignment: Alignment.center,
//                  height: 60.0,
//                  decoration: new BoxDecoration(color: Color(0xFF4364A1),borderRadius: new BorderRadius.circular(10.0)),
//                  child: new Text("Sign In With Facebook",style: new TextStyle(fontSize: 22.0,color: Colors.white),),
//                ),
//
//              ),
//
//              Text(msg,style: TextStyle(fontSize: 20.0,color: Colors.red),)
//
//
//            ],
//          ),
//        ),
//      ),
//    );
//  }
