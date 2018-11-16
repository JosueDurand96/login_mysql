import 'package:flutter/material.dart';
import 'package:login_mysql/AdminPage.dart';
import 'editdata.dart';
import 'package:http/http.dart'as http;

class Detail extends StatefulWidget {
  List list;
  int index;
  Detail({this.index,this.list});

  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {

  void deleteData() {
    var url = "http://192.168.1.134/Login/deleteData.php";
    http.post(url, body: {
      'id': widget.list[widget.index]['id']
    });
  }

  void confirm(){
    AlertDialog alertDialog = new AlertDialog(
      content: new Text("Estas seguro que quieres eliminar '${widget.list[widget.index]['item_name']}'"),
      actions: <Widget>[
        new RaisedButton(
            child: new Text("ELIMINAR",style: new TextStyle(color: Colors.black),),
            color: Colors.redAccent,
            onPressed: (){
              deleteData();
              Navigator.of(context).push(
                new MaterialPageRoute(
                    builder: (BuildContext context)=>new AdminPage(), )
              );
            },),
        new RaisedButton(
            child: new Text("CANCELAR",style: new TextStyle(color: Colors.black),),
            color: Colors.greenAccent,
            onPressed: ()=>Navigator.pop(context),)
      ],
    );

    showDialog(context: context,child: alertDialog);
  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
     appBar: new AppBar(title: new Text("${widget.list[widget.index]['item_name']}")),
      body: new Container(
        height: 250.0,
        padding: const EdgeInsets.all(20.0),
        child: new Card(
          child: new Center(
            child: new Column(
              children: <Widget>[
                new Text(widget.list[widget.index]['item_name'],style: new TextStyle(fontSize: 20.0),),
                new Text("Codigo :  ${widget.list[widget.index]['item_code']}",style: new TextStyle(fontSize: 18.0),),
                new Text("Precio :  ${widget.list[widget.index]['price']}",style: new TextStyle(fontSize: 18.0),),
                new Text("Cantidad :  ${widget.list[widget.index]['stock']}",style: new TextStyle(fontSize: 18.0),),
                new Padding(padding: const EdgeInsets.only(top: 30.0),),

                new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new RaisedButton(
                      child: new Text("EDIT"),
                        color: Colors.green,
                        onPressed:()=>Navigator.of(context).push(
                          new MaterialPageRoute(
                              builder: (BuildContext context)=>new EditData(list: widget.list,index: widget.index,),
                          )
                        ),
                    ),
                    new RaisedButton(
                      child: new Text("DELETE"),
                      color: Colors.red,
                      onPressed:()=>confirm(),
                    ),
                  ],
                )
              ],
            ),
          ),
        ) ,
      ),
    );
  }
}
