import 'package:flutter/material.dart';
import 'package:contacts_database_1/database/model.dart';
import 'package:contacts_database_1/database/database.dart';
import 'package:contacts_database_1/screens/edit.dart';
//import 'package:contacts_database_1/screens/savecontact.dart';
import 'package:contacts_database_1/screens/again_savecontacts.dart';



class MainScreen extends StatefulWidget{
  
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

var textfieldcontroller=new TextEditingController();
 Widget apptext=Text("Search");

  var database= Database_helper();

String raviname="Raviraj Kanchanpure";
String raviemail="badravi98@gmail.com";
String abhiname="Abhijit Baneerjee";
String abhiemail="Banerjee.ghostfreak@gmail.com";
String name="";
String email="";


  List itemList=new List();
  List itemval=new List();
  List ex=[];

  @override
  void initState() {
    super.initState();
    databased();
    setState(() {
      itemList=itemval;
    });
    

  }
  
  void databased() async{
  
  List users=await database.getallUsers();
  setState(() {

     users.forEach((items){
      itemval.add(User.fromMap(items));
        });
        itemList=itemval;
  });


  print("item:$itemval");
  
  }


  void saveAgainScreen() async{

     var route= await  Navigator.push(context, 
            MaterialPageRoute(builder: (context)=>saveAgain(fname: ' ',lname: ' ',phone: ' ',)));
      if(route['Phone']!=' '){

          await database.inserts(User(route['Firstname'],route['Lastname'],route['Phone']));
          setState(() {
           databased();
           itemList=itemval;
           itemval=[];
          });

      }
  }

  void editpageagain(User user,int position) async{


      var r=await Navigator.push(context, MaterialPageRoute(
                    builder: (context)=>editpage(firstname: user.firstname,
                    lastname: user.surname,
                    phone: user.phone,)));
        print("ffff"+r['l']);
     
     var item=User.fromMap({

        "phone":r['p'],
        "firstname":r['f'],
        "surname":r['l'],
        "id":user.id
     });
     await database.updateuser(item);
     setState(() {
      databased();
      itemList=itemval; 
      itemval=[];
     });

  }
  Future<bool> backPressed() async{
    var alert= AlertDialog(
      title: Text("Do you want to exit?"),
      actions: <Widget>[
        FlatButton(
          child: Text("Yes"),
          onPressed: (){
            Navigator.pop(context,true);
            Navigator.pop(context);
          }
        ),
        FlatButton(
          child: Text("No"),
          onPressed: (){
            Navigator.pop(context,false);
            },
        ),

      ]
    );

   return showDialog(context: context,builder: (context)=>alert);
  }


Widget listoflabels(){

   return ListTile(
     title: Text("yo"),

   );

 }
   void searchbartext(String text){

    if(text.isNotEmpty){
    
    for(int i=0;i<itemval.length;i++){
      
      if(itemval.elementAt(i).firstname.contains(text)){

        setState(() {
           ex.add(itemval[i]);
        });
       
      }
    }
    setState(() {
      itemList=ex;
      ex=[];
      
    });
  }
  }


 void deleteitem(User user,int index) async{


   var alert=AlertDialog(
     title: Text("Do you want to delete this item?"),
     actions: <Widget>[
       FlatButton(

         child: Text("yes",style: TextStyle(fontSize: 18.0),),
         onPressed: ()async{

           await database.deleteUser(user.id);
           Navigator.pop(context);

         },
        
       ),
       FlatButton(
         child: Text("no",style: TextStyle(fontSize: 18.0)),
         onPressed: (){
           Navigator.pop(context);
         },
       )
     ],
   );

   showDialog(context: context,builder:(context)=>alert);
    setState(() {
      itemList.removeAt(index);
        databased();
        itemList=[];
        });
 }
    
    

  @override
  Widget build(BuildContext context) {
    
    return WillPopScope(
      onWillPop: (){
        backPressed();
      },
          child: Scaffold(

        appBar: AppBar(
          title: 
                    ListTile(
                       leading: 
          IconButton(icon: Icon(Icons.search,color: Colors.white,size: 25.0,),onPressed: (){
              searchbartext(textfieldcontroller.text);//
              

          },),

                    trailing:IconButton(icon: Icon(Icons.clear,color: Colors.white,),onPressed: (){
                    textfieldcontroller.text="";
                  setState(() {            
                      itemList=itemval;

                    });
                   },),
                      title:TextField(
                controller: textfieldcontroller,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: "All contacts",
            hintStyle: TextStyle(color: Colors.white,fontSize: 20.0)
          ),
        )),
          centerTitle: true,

        ),

        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: (){
            setState(() {
              saveAgainScreen();
            });
            
          }
        ),
          body:ListView.builder(
          
          itemCount: itemList.length,
          itemBuilder: (context,int position){

             return Padding(
               padding: EdgeInsets.fromLTRB(15.0,15.0,15.0,0.0),
               child:ListTile(
               leading: CircleAvatar(
                 backgroundColor: Colors.blueAccent,
                 radius: 28.0,
                 child: Text("${itemList[position].firstname.toString().substring(0,2).toUpperCase()}"
                 ,style: TextStyle(fontSize: 18.0,color: Colors.white)),
               ),

                onLongPress: (){
                  deleteitem(itemList[position], position);
                },

               title: Text("${itemList[position].firstname} ${itemList[position].surname}",
               style: TextStyle(fontSize: 18.0),),
               onTap: ()async{
                 editpageagain(itemList[position], position);
               },
             ));

        },)

          )   );
  }
}