import 'package:Lucid/Wallpaper/Scrrens/abstracT.dart';
import 'package:Lucid/Wallpaper/Scrrens/anime.dart';
import 'package:Lucid/Wallpaper/Scrrens/cats.dart';
import 'package:Lucid/Wallpaper/Scrrens/city.dart';
import 'package:Lucid/Wallpaper/Scrrens/food.dart';
import 'package:Lucid/Wallpaper/Scrrens/girls.dart';
import 'package:Lucid/Wallpaper/Scrrens/music.dart';
import 'package:Lucid/Wallpaper/Scrrens/nature.dart';
import 'package:Lucid/Wallpaper/Scrrens/space.dart';
import 'package:Lucid/Wallpaper/Scrrens/sports.dart';
import 'package:Lucid/Wallpaper/Scrrens/textures.dart';
import 'package:Lucid/Wallpaper/Scrrens/vector.dart';
import 'package:Lucid/Wallpaper/fullscreen_image.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';


const String testDevice="";


class WallScreen extends StatefulWidget {


 final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;
  WallScreen({this.analytics,this.observer});

  @override
  _WallScreenState createState() => _WallScreenState();
}

class _WallScreenState extends State<WallScreen> {
  
 
 

 

  static final MobileAdTargetingInfo targetInfo=new MobileAdTargetingInfo(
   testDevices: <String>[],
   keywords: <String>['wallpapers','walls','amoled'],
   birthday: new DateTime.now(),
   childDirected: true,
  );

  BannerAd _bannerAd;
  InterstitialAd _interstitialAd;

  
  StreamSubscription<QuerySnapshot> subscription;
  List<DocumentSnapshot> wallpapersList;
  final CollectionReference collectionReference=
  Firestore.instance.collection("wallpapers");

  BannerAd createBannerAd(){
    return new BannerAd(
      adUnitId:"ca-app-pub-9577074939496935/4551660707",
      size:AdSize.banner,
      targetingInfo:targetInfo,
      listener: (MobileAdEvent event){
        print("Banner Event: $event");
      }
    );
  }

  InterstitialAd createInterstitialAd(){
    return new InterstitialAd(
       adUnitId:"ca-app-pub-9577074939496935/9194555247",
      targetingInfo:targetInfo,
      listener: (MobileAdEvent event){
        print("Interstitial Event: $event");
      }
    );
  }

 Future<Null>_currentScreen()async{
    await widget.analytics.setCurrentScreen(
     screenName: 'Wall Screen',
     screenClassOverride: 'WallScreen'
    );
 }
  Future<Null>_sendAnalytics()async{
    await widget.analytics.logEvent(
      name: 'Tap to full Screen',
      parameters: <String,dynamic>{}
    );
  }


  @override
  void initState(){
    super.initState();
    
    FirebaseAdMob.instance.initialize(appId: "ca-app-pub-9577074939496935~8647760335");
    _bannerAd=createBannerAd()
    ..load()
    ..show();
    subscription=collectionReference.snapshots().listen((datasnapshot){
      setState(() {
              wallpapersList=datasnapshot.documents;
            });
    });

    _currentScreen();
    
    
  }

  @override
  void dispose(){
    _bannerAd?.dispose();
    _interstitialAd?.dispose();
      subscription?.cancel();
      super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Lucid"),
        centerTitle: true,
        backgroundColor: Colors.red[800],
        elevation: 10.0,
      ),
      drawer: new Drawer(
      
        child: new ListView(
          children: <Widget>[
            new UserAccountsDrawerHeader(
              accountName: new Text("Govind Dixit"),
              accountEmail: new Text("govinddixit93@gmail.com"),
              currentAccountPicture: new CircleAvatar(
                backgroundColor: Colors.amber,
                child: new Text("G"),
              ) ,
              
            
              otherAccountsPictures: <Widget>[
                 new CircleAvatar(
                backgroundColor: Colors.amber,
                child: new Text("A"),
                 )
              ],
            ),
           
              new ListTile(
                title: new Text("Abstract"),
                trailing: new Icon(Icons.arrow_forward_ios),
                onTap: (){
                  Navigator.of(context).pop();
                  Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context)=>
                    new abstracT()));
                  
                },
              ),
            new ListTile(
                title: new Text("Anime"),
                trailing: new Icon(Icons.arrow_forward_ios),
                onTap: (){
                  Navigator.of(context).pop();
                  Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context)=>
                    new anime()));
                  
                },
              ),
              
               new ListTile(
                title: new Text("Cats"),
                trailing: new Icon(Icons.arrow_forward_ios),
                onTap: (){
                  Navigator.of(context).pop();
                  Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context)=>
                    new cats()));
                  
                },
              ),
               new ListTile(
                title: new Text("City"),
                trailing: new Icon(Icons.arrow_forward_ios),
                onTap: (){
                  Navigator.of(context).pop();
                  Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context)=>
                    new city()));
                  
                },
              ),
              new ListTile(
                title: new Text("Food"),
                trailing: new Icon(Icons.arrow_forward_ios),
                onTap: (){
                  Navigator.of(context).pop();
                  Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context)=>
                    new food()));
                  
                },
              ),
               new ListTile(
                title: new Text("Girls"),
                trailing: new Icon(Icons.arrow_forward_ios),
                onTap: (){
                  Navigator.of(context).pop();
                  Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context)=>
                    new girls()));
                  
                },
              ),
              new ListTile(
                title: new Text("Music"),
                trailing: new Icon(Icons.arrow_forward_ios),
                onTap: (){
                  Navigator.of(context).pop();
                  Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context)=>
                    new music()));
                  
                },
              ),
              new ListTile(
                title: new Text("Nature"),
                trailing: new Icon(Icons.arrow_forward_ios),
                onTap: (){
                  Navigator.of(context).pop();
                  Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context)=>
                    new nature()));
                  
                },
              ),
              new ListTile(
                title: new Text("Space"),
                trailing: new Icon(Icons.arrow_forward_ios),
                onTap: (){
                  Navigator.of(context).pop();
                  Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context)=>
                    new space()));
                  
                },
              ),
               new ListTile(
                title: new Text("sports"),
                trailing: new Icon(Icons.arrow_forward_ios),
                onTap: (){
                  Navigator.of(context).pop();
                  Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context)=>
                    new sports()));
                  
                },
              ),
               new ListTile(
                title: new Text("Textures"),
                trailing: new Icon(Icons.arrow_forward_ios),
                onTap: (){
                  Navigator.of(context).pop();
                  Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context)=>
                    new textures()));
                  
                },
              ),
               new ListTile(
                title: new Text("Vector"),
                trailing: new Icon(Icons.arrow_forward_ios),
                onTap: (){
                  Navigator.of(context).pop();
                  Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context)=>
                    new vector()));
                  
                },
              ),
              
             

          ],
        ),
      ),
      body: wallpapersList!=null?new StaggeredGridView.countBuilder(
        padding: const EdgeInsets.all(8.0),
        crossAxisCount: 4,
        itemCount: wallpapersList.length,
        itemBuilder: (context,i){
          String imgpath=wallpapersList[i].data['url'];
          return new Material(
            elevation: 8.0,
            borderRadius: new BorderRadius.all(new  Radius.circular(8.0)
            ),
            child:new InkWell(
              onTap: (){
                _sendAnalytics();
                createInterstitialAd()..load()..show();
                Navigator.push(context, new MaterialPageRoute(
                builder: (context)=>
                new FullScreenImagePage(imgpath)
              ));},
              child: new Hero(
                tag: imgpath,
                child: new FadeInImage(
                  image: new NetworkImage(imgpath),
                  fit: BoxFit.cover,
                  placeholder: new AssetImage("assets/images.png"),
                ),
              ),
            ),
          );
        },
        staggeredTileBuilder: (i)=>new StaggeredTile.count(2, i.isEven?2:3),
        mainAxisSpacing: 8.0,
        crossAxisSpacing: 8.0,
      ):new Center(
        child: new CircularProgressIndicator(),)     
    );
  }
}