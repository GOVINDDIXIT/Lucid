import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';


class Home extends StatefulWidget {


  @override
  HomeState createState() {
    return new HomeState();
  }
}

class HomeState extends State<Home> {
  String myText=null;
  StreamSubscription<DocumentSnapshot> subscription;

  final DocumentReference documentReference=Firestore.instance.document("myData/dummy");
  final FirebaseAuth _auth=FirebaseAuth.instance;
  final GoogleSignIn googleSignIn=new GoogleSignIn();

  Future<FirebaseUser>_signIn() async{
    GoogleSignInAccount googleSignInAccount=await googleSignIn.signIn();
    GoogleSignInAuthentication gsa =await googleSignInAccount.authentication;
    FirebaseUser user =await _auth.signInWithGoogle(
      idToken: gsa.idToken,accessToken: gsa.accessToken);
            print("User Name :${user.displayName}");
      return user; 
  }

  void _signOut(){
    googleSignIn.signOut();
    print("User is signed out");
  }

  void _add(){
    Map<String,String> data=<String,String>{
      "name":"Govind Dixit",
      "Description":"Flutter",
    };
    documentReference.setData(data).whenComplete((){
      print("Document Added");
    }).catchError((e)=>print(e));

  }
 
 void _update(){
   Map<String,String> data=<String,String>{
      "name":"Govind Dixit Updated",
      "Description":"Flutter Developer",
    };
    documentReference.updateData(data).whenComplete((){
      print("Document Updated");
    }).catchError((e)=>print(e));
 }

 void _delete(){
   documentReference.delete().whenComplete((){
     print("Deleted Successfully");
     setState(() {
            
          });
   }).catchError((e)=>print(e));

 }

 void _fetch(){
   documentReference.get().then((dataSnapshot){
     if(dataSnapshot.exists){
       setState(() {
                 myText= dataSnapshot.data['Description'];
              });
      
     }
   });

 }
 @override
 void initState(){
   super.initState();
   subscription=documentReference.snapshots().listen((datasnapshot){
    
          if(datasnapshot.exists){
       setState(() {
                 myText= datasnapshot.data['Description'];
              });

   }
   }  );
   
 }
@override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    subscription?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Wallpaper APP"),
      ),
      body: new Padding(
        padding: const EdgeInsets.all(20.0),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            new RaisedButton(
              onPressed: ()=>_signIn().then((FirebaseUser user) => print(user)).catchError((e)=>print(e)),
              
              child: new Text("Sign In"),
              color:Colors.green,
            ),
            new Padding(
              padding: const EdgeInsets.all(10.0),
            ),
            new RaisedButton(
              onPressed:_signOut,
              child: new Text("Sign Out"),
              color: Colors.red,
            ),
             new Padding(
              padding: const EdgeInsets.all(10.0),
            ),
            new RaisedButton(
              onPressed:_add,
              child: new Text("Create"),
              color: Colors.cyan,
            ),
             new Padding(
              padding: const EdgeInsets.all(10.0),
            ),
             new RaisedButton(
              onPressed:_update,
              child: new Text("Update"),
              color: Colors.lime,
            ),
             new Padding(
              padding: const EdgeInsets.all(10.0),
            ),
            new RaisedButton(
              onPressed:_delete,
              child: new Text("Delete"),
              color: Colors.orange,
            ),
             new Padding(
              padding: const EdgeInsets.all(10.0),
            ), 
            new RaisedButton(
              onPressed:_fetch,
              child: new Text("Fetch"),
              color: Colors.pink,
            ),
             new Padding(
              padding: const EdgeInsets.all(30.0),
            ),
            myText==null?new Container():new Text(myText,style: new TextStyle(fontSize: 20.0,fontStyle: FontStyle.normal,color: Colors.black))         
          ],
        ),
      ),
     
      
    );
  }
}