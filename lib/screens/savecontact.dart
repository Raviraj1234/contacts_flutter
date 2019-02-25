import 'package:flutter/material.dart';
import 'package:contacts_database_1/database/database.dart';
import 'package:contacts_database_1/screens/edit.dart';

//scondScreen()
class secondScreen extends StatefulWidget {
 
  String lname;
  String fname;
  String phone;

  secondScreen({Key key,this.fname,this.lname,this.phone}):super(key:key);
 
  @override
  _secondScreenState createState() => _secondScreenState();
}

class _secondScreenState extends State<secondScreen> {
  var database=new Database_helper();
     
     var firstnamecontroller =new TextEditingController();
    var surnamecontroller=new TextEditingController();
    var addresscontroller=new TextEditingController();
    var phonecontroller=TextEditingController();
    

@override
  void initState() {

    super.initState();    

       phonecontroller.text="${widget.phone}";
       surnamecontroller.text="${widget.lname}";
       firstnamecontroller.text="${widget.fname}";
      print(widget.fname);
      print(widget.lname);
      print(widget.phone);

  }

  void databasedcontacts() async{

    if(phonecontroller.text!=' '){


      if(firstnamecontroller.text==null){
        firstnamecontroller.text=' ';
      }
       if(surnamecontroller.text==null){
        surnamecontroller.text=' ';
      }

  Navigator.pop(context,{
    "Firstname":firstnamecontroller.text,
    "Lastname":surnamecontroller.text,
    "Phone":phonecontroller.text
  });
  }

  }



  @override
  Widget build(BuildContext context) {
         return Scaffold(
        
         appBar: new AppBar(
          leading: IconButton(icon: Icon(Icons.arrow_back_ios),
          onPressed: ()=>Navigator.pop(context),color: Colors.black54,),
          title: Text("Create Contact",style:TextStyle(color:Colors.black,fontWeight: FontWeight.w700)),
          backgroundColor: Colors.white54,
          actions: <Widget>[

            FlatButton(
              child: Text("SAVE",style: TextStyle(color: Colors.black,fontSize: 16.0)),
              onPressed: (){
               
                
              databasedcontacts();
                
              },
            )
          ],
        ),
         
        
        body: ListView(
          scrollDirection: Axis.vertical,
        children: <Widget>[
          Column(
            children: <Widget>[
                 Container(
              width: 190.0,
              height: 190.0,

                child: ClipOval(
                  child: Image.asset('images/dog.jpg',fit: BoxFit.fill),
                ),

                decoration: BoxDecoration(
                  
                  border: Border.all(
                    color: Colors.blueAccent,
                    width: 5.0
                  ),
                  shape: BoxShape.circle
                ),

            ),

             
               Container(
                 padding: EdgeInsets.only(top:20.0),
                 child:Column(

                   children: <Widget>[
                     Padding(
                       padding: EdgeInsets.only(right:30.0),
                       child:ListTile(
                   title: TextField(
                     controller:firstnamecontroller,
                     
                     decoration: InputDecoration(                     
                       
                       icon: Icon(Icons.person,color: Colors.indigoAccent),
                       labelText: "FirstName",
                       labelStyle: TextStyle(fontSize: 17.0,color: Colors.indigoAccent.withOpacity(0.7)),
                       hintText: "FirstName",
                       fillColor: Colors.purpleAccent,
                       
                     ),
                   ),


                 ),),
                     Padding(
                   padding: EdgeInsets.only(left:30.0),
                   child: ListTile(
                     
                                  title: TextField(
                                    
                                    controller: surnamecontroller,
                     
                                      decoration: InputDecoration(
                                    
                                   labelText: "Surname",
                                 labelStyle: TextStyle(fontSize: 17.0,color: Colors.indigo.withOpacity(0.7)),
                                hintText: "Surname"

                     ),
                   ),

                 )
                 ),

                 Padding(
                   padding: EdgeInsets.only(right:30.0),
                   child: ListTile(
                                  title: TextField(
                                    controller: phonecontroller,
                                    keyboardType: TextInputType.numberWithOptions(decimal: false),
                     
                                      decoration: InputDecoration(
                                    icon: Icon(Icons.phone,color: Colors.indigoAccent,),
                                   labelText: "Phone",
                                 labelStyle: TextStyle(fontSize: 17.0,color: Colors.indigo.withOpacity(0.7)),
                                hintText: "Phone"

                     ),
                   ),

                 )
                 ),

                 Padding(
                   padding: EdgeInsets.only(right: 30.0),
                   child:      
                       ListTile(
                   title: TextField(
                     controller:addresscontroller,
                     
                     decoration: InputDecoration(
                       icon: Icon(Icons.location_city,color: Colors.indigoAccent,),
                       labelText: "Address",
                       labelStyle: TextStyle(fontSize: 17.0,color: Colors.indigoAccent.withOpacity(0.7)),
                       hintText: "Address"

                     ),
                   ),

                 ) )],
                 )
               ),
              

            ],
          )

         

  

        ],),
        
      
    );
  }
}