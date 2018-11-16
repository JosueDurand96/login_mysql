import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:login_mysql/AdminPage.dart';
import 'package:login_mysql/main.dart';
class EditData extends StatefulWidget {
  final List list;
  final int index;

  EditData({this.list,this.index});

  @override
  _EditDataState createState() => _EditDataState();
}

class _EditDataState extends State<EditData> {


  TextEditingController controllerCode;
  TextEditingController controllerName;
  TextEditingController controllerPrice;
  TextEditingController controllerStock;

  void editData(){
    var url="http://192.168.1.134/Login/editdata.php";
    http.post(url,body:{
      "id":widget.list[widget.index]['id'],
      "itemcode":controllerCode.text,
      "itemname":controllerName.text,
      "price": controllerPrice.text,
      "stock": controllerStock.text
    });
  }

  @override
  void initState() {
    controllerCode= new TextEditingController(text: widget.list[widget.index]['item_code']);
    controllerName= new TextEditingController(text: widget.list[widget.index]['item_name']);
    controllerPrice= new TextEditingController(text: widget.list[widget.index]['price']);
    controllerStock= new TextEditingController(text: widget.list[widget.index]['stock']);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text("Actualizar Producto"),),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: <Widget>[
            new Column(
              children: <Widget>[
                new TextField(
                  controller: controllerCode,
                  decoration: new InputDecoration(
                    hintText: "Código", labelText: "Código",),
                ),
                new TextField(
                  controller: controllerName,
                  decoration: new InputDecoration(
                    hintText: "Nombre Producto", labelText: "Nombre Producto",),
                ),
                new TextField(
                  controller: controllerPrice,
                  decoration: new InputDecoration(
                    hintText: "Precio", labelText: "Precio",),
                ),
                new TextField(
                  controller: controllerStock,
                  decoration: new InputDecoration(hintText: "Cantidad", labelText: "Cantidad",),
                ),
                new Padding(padding: const EdgeInsets.all(10.0)),
                new RaisedButton(
                  child: new Text("Actualizar Producto"),
                  color: Colors.blueAccent,
                  onPressed: (){
                    editData();
                    Navigator.of(context).pugish(
                      new MaterialPageRoute(
                          builder: (BuildContext context)=>new AdminPage()
                      ),
                    );
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
