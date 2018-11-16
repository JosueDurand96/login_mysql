import 'package:flutter/material.dart';
import 'editdata.dart';
class Detail extends StatefulWidget {
  List list;
  int index;
  Detail({this.index,this.list});

  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
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
                      onPressed:(){},
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
