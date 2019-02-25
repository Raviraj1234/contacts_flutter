
import 'package:flutter/material.dart';
import 'package:contacts_database_1/database/database.dart';
import 'package:contacts_database_1/screens/savecontact.dart';
import 'package:url_launcher/url_launcher.dart';



class editpage extends StatefulWidget {

  String firstname,lastname,phone;
  int identity;
  String name;
  int ff;
  editpage({Key key,this.firstname,this.lastname,this.phone,this.identity,this.ff}):super(key:key);

  
  @override
  _editpageState createState() => _editpageState();
}

class _editpageState extends State<editpage> {
  var database=new Database_helper();
String updated_p;
String updated_f;
String updated_l;
@override
  void initState() {
   
    super.initState();
   updated_p=widget.phone;
   updated_f=widget.firstname;
   updated_l=widget.lastname;


  }
void alertState() async{
  
 
  
  //var s=await MaterialPageRoute(builder:(context)=> secondScreen());

            Map route= await Navigator.of(context).push(
              MaterialPageRoute(builder:(context)=>secondScreen(
                phone:updated_p ,fname: updated_f,lname: updated_l)));

              print("phone:"+widget.phone);
              print("firstname"+widget.firstname);
              print("lastname"+widget.lastname);

              if(route['Phone']!=null && route.containsKey('Phone')){
                setState(() {
                  print(route['First']);
                updated_p=route['Phone'].toString();
                updated_f=route['Firstname'].toString();
                updated_l=route['Lastname'].toString();
                });
                
              }
}

 

  @override
  Widget build(BuildContext context) {

    return WillPopScope(
       onWillPop: (){
          returnpage();
       },
        child: new Scaffold(

    appBar: AppBar(
        backgroundColor: Colors.orange.shade800,

        actions: <Widget>[
          IconButton(icon: Icon(Icons.call),onPressed: (){
            launch("tel://9433145227");
          },),
          IconButton(
            icon: Icon(Icons.star_border,color: Colors.white,),
          ),
          IconButton(
            icon: Icon(Icons.edit,color: Colors.white),
            onPressed: ()async {

                  setState(() {
                 alertState();
                  });

              })
          
        ],
    ),


    body: (
        Stack(
          children: <Widget>[
            
        Container(
          child:ListView(
            scrollDirection: Axis.vertical,
            children: <Widget>[
                SizedBox(
          width: 600.0,
          height: 500.0,
             child: Card(
                                        
              child: Container(

              decoration: BoxDecoration(
                
                color: Colors.orange.shade800,
                image: DecorationImage(
                  image:AssetImage('images/logo.png')
                )

              ),
            ),
          ),
        ) ,
  SizedBox(
    width: 600.0,
    height:100.0,
    child: Card(
        child: ListTile(
          leading: Container(
            padding: EdgeInsets.only(bottom: 30.0),
            child: IconButton(icon: Icon(Icons.call,size: 28.0,color: Colors.orange.shade800,),onPressed: ()=>launch("tel://$updated_p")),
          ),
         
         
          title:
            Container(
              padding: EdgeInsets.fromLTRB(30.0, 10.0, 0.0, 0.0),
              child:Text("$updated_p",style: TextStyle(fontSize: 20.0))),
               
          subtitle: Container(
            padding: EdgeInsets.fromLTRB(40.0,0.0,0.0, 30.0),
            child:Text("Mobile",style: TextStyle(fontSize: 15.0),)),
            trailing:Container(
              padding: EdgeInsets.only(bottom:20.0),
              child:IconButton(icon:Icon(Icons.message,color: Colors.orange.shade800,size: 28.0,),onPressed: (){
              launch("sms://$updated_p");
            },)), 
  
        ),
    ),
  )
        
            ],
          )
    ) ,

    Container(
        padding: EdgeInsets.fromLTRB(30.0, 450, 0.0, 0.0),
        child:  Text("$updated_f " "$updated_l",style:TextStyle(fontSize:25.0,color: Colors.white))   ,
    )
   

          ],
        )

    ),
    ),
     );
  

}
bool returnpage(){
   return Navigator.pop(context,{
     "f":updated_f,
     "l":updated_l,
     "p":updated_p
     
   });
   

 }

}
