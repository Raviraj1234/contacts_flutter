
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:contacts_database_1/database/model.dart';
import 'package:path/path.dart';
import './model.dart';

class Database_helper{

  static String usertable="CONTACTS";
  static String firstname="firstname";
  static String phone="phone";
  static String surname="surname";
  static String userid="id";



  static final Database_helper _instance=new Database_helper.getInstance();
  Database_helper.getInstance();
  factory Database_helper()=>_instance;//single tone object creatred;

  static Database _db;

  Future<Database> get db async{
    if(_db!=null){
      return _db;
    }
    else{

      return _db=await initdb();
    }
  }







  Future<Database> initdb() async{
    var directory=await getApplicationDocumentsDirectory();
    String path=directory.path+"cotact.db";

    var ourDb=await openDatabase(path,version: 1,onCreate: create);
    return ourDb;

  }

  void create(Database db,int newVersion) async{

   await  db.execute(
    "CREATE TABLE $usertable($userid INTEGER PRIMARY KEY,$firstname TEXT,$surname TEXT,$phone TEXT)");

  }

  Future<int> inserts(User user) async{

    Database dbclient=await db;
    var res= await dbclient.insert("$usertable",  user.toMap());
    return res;
  }

  Future<List> getallUsers() async{

    Database dbclient=await db;
    var res= await dbclient.rawQuery("SELECT * FROM $usertable");
    return res.toList();

  }

  Future<int> updateuser(User user) async{

    Database dbclient=await db;
    var result=await dbclient.update("$usertable", user.toMap(),where: "id=?",whereArgs: [user.id]);
    return result;
  }

  Future<int> deleteUser(int id) async{

    Database dbclient=await db;
    var result=await dbclient.delete("$usertable",where: "id=?",whereArgs: [id]);
    return result;

  }

  Future<User> getUser(int isd)async{

    Database dbclient=await db;
    var result=await dbclient.rawQuery("SELECT * FROM $usertable WHERE id=$isd");
    return User.fromMap(result.first);
  }

  Future<int> deleteall() async{

    Database dbclient=await db;
    var res=await dbclient.rawQuery("DELETE FROM $usertable");
   
  
    

  }

  Future closed() async{

    Database dbclient=await db;
    return dbclient.close();
    
  }

  }



  