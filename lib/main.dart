import 'package:flutter/material.dart';
import 'package:contacts_database_1/screens/mainscreen.dart';
import 'package:contacts_database_1/database/database.dart';
import 'package:contacts_database_1/database/model.dart';



void main() async{

  var database=Database_helper();
  runApp(MaterialApp(
    title: "Contacts",
    home: MainScreen(),
    debugShowCheckedModeBanner: false,
  ));

// await database.inserts(User("Papu","ji","9081828383"));
// await database.inserts(User("Ram","ji","9081828383"));
// await database.inserts(User("Shyam","ji","9081828383"));
// await database.inserts(User("Lala","ji","9081828383"));

//print(database.deleteall());
print(await database.getallUsers());


}






