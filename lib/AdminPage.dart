import 'dart:convert';

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart'as http;
import 'detail.dart';
class AdminPage extends StatefulWidget {

  AdminPage({this.username});
  final String username;

  @override
  _AdminPage createState()=> new _AdminPage();


}

// ignore: type_argument_not_matching_bounds
class _AdminPage extends State<AdminPage> {
  Future<List> getData() async {
    final response = await http.get("http://192.168.1.134/Login/getdata.php");
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(title: new Text("MY STORE 2")),


        body: new FutureBuilder<List>(
          future: getData(),
          builder: (context, snapshot) {
            if (snapshot.hasError) print(snapshot.error);

            return snapshot.hasData
                ? new ItemList(list: snapshot.data,)
                : new Center(child: new CircularProgressIndicator(),);
          },
        )
    );
  }
}
  // ignore: missing_method_parameters, class_in_class, expected_class_member
  class ItemList extends StatelessWidget{
  List list;
  ItemList({this.list});
   @override
    Widget build (BuildContext context){
     return new  ListView.builder(
     itemCount: list==null?0:list.length,
       itemBuilder: (context,i){
       // return new Text(list[i]['item_name']); lista uno por uno los items

         return new Container(
           padding: const EdgeInsets.all(10.0),
                child: new GestureDetector(
                  onTap: ()=>Navigator.of(context).push(
                    new MaterialPageRoute(
                        builder: (BuildContext context)=> new Detail(list: list,index:i,))
                  ),
                  child: new Card(
                     child: new ListTile(
             title: new Text(list[i]['item_name']),
             leading: new Icon(Icons.widgets),
             subtitle: new Text("Stock : ${list[i]['stock']}"),
           ),
           ),
                ),
         );
       },
     );
}
}

