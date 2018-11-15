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
      title: 'Login PHP My Admin',
      home: new MyHomePage(),
      routes: <String,WidgetBuilder>{
        '/AdminPage': (BuildContext context)=> new AdminPage(username: username,),
        '/MemberPage': (BuildContext context)=> new MemberPage(username: username,),
        '/MyHomePage': (BuildContext context)=> new MyHomePage(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  TextEditingController user=new TextEditingController();
  TextEditingController pass=new TextEditingController();

  String msg='';
  String _baseUrl = 'http://192.168.1.134/Login/login.php?';

  Future<dynamic>getJson(Uri uri) async{
    http.Response response = await http.post(uri);
    //llamamos el objetivo json de dart   y decodificar
    return json.decode(response.body);
  }

  //agregamos el objeto Media
//  Future<List> _login()async{
//    // se concatena la url base , el endpoint (lo restante de la url) y los parametros
//    var uri = new Uri.http( _baseUrl , '/Login/login.php', {
//      'username' : user.text,'password':pass.text
//    });
//    print(uri);
//
//    //retornar una list de obetos Media
//    return getJson(uri).then(((data) =>
//    //accedemos el json que esta  dentro del json  movies y creamos un objeto  Media
//    data['admin'].map<Admin>((item) => new Admin(item)).toList()
//
//    ));
//
//
//  }


  Future<List> _login() async {
    final response = await http.post(_baseUrl, body: {
      "username": user.text,
      "password": pass.text,
    });

    print(response);
    var datauser = json.decode(response.body);

    if(datauser.length==0){
      setState(() {
        msg="Login Fail";
      });
    }else{
      if(datauser[0]['level']=='admin'){
        Navigator.pushReplacementNamed(context, '/AdminPage');
      }else if(datauser[0]['level']=='member'){
        Navigator.pushReplacementNamed(context, '/MemberPage');
      }

      setState(() {
        username= datauser[0]['username'];
      });

    }

    return datauser;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login"),),
      body: Container(
        child: Center(
          child: Column(
            children: <Widget>[
              Text("Username",style: TextStyle(fontSize: 18.0),),
              TextField(
                controller: user,
                decoration: InputDecoration(
                    hintText: 'Username'
                ),
              ),
              Text("Password",style: TextStyle(fontSize: 18.0),),
              TextField(
                controller: pass,
                obscureText: true,
                decoration: InputDecoration(
                    hintText: 'Password'
                ),
              ),

              RaisedButton(
                child: Text("Login"),
                onPressed: (){
                  _login();
                },
              ),

              Text(msg,style: TextStyle(fontSize: 20.0,color: Colors.red),)


            ],
          ),
        ),
      ),
    );
  }
}