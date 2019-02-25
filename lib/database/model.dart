
class User {
    String _firstname;
    String _surname;
    String _phone;
   
    int _id;


  User(this._firstname,this._surname,this._phone);

  String get phone=>_phone;
  String get firstname=>_firstname;
  String get surname=>_surname;
 

  int get id=>_id;

  Map<String,dynamic> toMap(){
    var map=new Map<String,dynamic>();

    if(_id!=null){
      map["id"]=_id;
    }
    map["phone"]=_phone;
    map["firstname"]=_firstname;
    map["surname"]=_surname;
    
    
    return map;
    

  }

  User.fromMap(Map<String,dynamic> map){


    this._phone=map["phone"];
    this._firstname=map["firstname"];
    this._surname=map["surname"];
    
    this._id=map["id"];
  }

 




}