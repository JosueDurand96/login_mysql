


class Admin {
  String id;
  String username;
  String password;
  String level;

  //usamos el metodo creado en la clase util.dart
 // String getPosterUrl() => getMediumPictureUrl(image);
  //String gettitle()=>gettitle(title);
//ejemplo de u arraya en json

//  List<dynamic>genreIds;


  factory Admin(Map jsonMap) {
    return new Admin.deserialize(jsonMap);
  }
  //vamos a capturar los valores del json
  //deserialize = es tranformar un json en un objeto
  //serializar = es tomar las propiedad los valores y transformar en un archivo json o xml
  Admin.deserialize(Map json) :
        id = json["id"].toString(),
        username = json["username"].toString(),
        password = json["password"].toString(),
        level = json["level"].toString();

// genreIds = json["genreIds"].toList();
}