import 'dart:async';

import 'package:Lucid/Wallpaper/FullScreenImagePage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class Cats extends StatefulWidget {
  @override
  CatsState createState() => CatsState();
}

class CatsState extends State<Cats> {
  static final MobileAdTargetingInfo targetInfo = new MobileAdTargetingInfo(
    testDevices: <String>[],
    keywords: <String>['wallpapers', 'walls', 'amoled'],
    birthday: new DateTime.now(),
    childDirected: true,
  );

  BannerAd _bannerAd;
  InterstitialAd _interstitialAd;

  StreamSubscription<QuerySnapshot> subscription;
  List<DocumentSnapshot> wallpapersList;
  final CollectionReference collectionReference =
      Firestore.instance.collection("cats");

  BannerAd createBannerAd() {
    return new BannerAd(
        adUnitId: "ca-app-pub-9577074939496935/4551660707",
        size: AdSize.banner,
        targetingInfo: targetInfo,
        listener: (MobileAdEvent event) {
          print("Banner Event: $event");
        });
  }

  @override
  void initState() {
    super.initState();

    FirebaseAdMob.instance
        .initialize(appId: "ca-app-pub-9577074939496935~8647760335");
    _bannerAd = createBannerAd()
      ..load()
      ..show();
    subscription = collectionReference.snapshots().listen((datasnapshot) {
      setState(() {
        wallpapersList = datasnapshot.documents;
      });
    });
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    _interstitialAd?.dispose();
    subscription?.cancel();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          title: new Text("Cats"),
          centerTitle: true,
          backgroundColor: Colors.red[800],
          elevation: 10.0,
        ),
        body: wallpapersList != null
            ? new StaggeredGridView.countBuilder(
                padding: const EdgeInsets.all(8.0),
                crossAxisCount: 4,
                itemCount: wallpapersList.length,
                itemBuilder: (context, i) {
                  String imgpath = wallpapersList[i].data['url'];
                  return new Material(
                    elevation: 8.0,
                    borderRadius:
                        new BorderRadius.all(new Radius.circular(8.0)),
                    child: new InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) =>
                                    new FullScreenImagePage(imgpath)));
                      },
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
                staggeredTileBuilder: (i) =>
                    new StaggeredTile.count(2, i.isEven ? 2 : 3),
                mainAxisSpacing: 8.0,
                crossAxisSpacing: 8.0,
              )
            : new Center(
                child: new CircularProgressIndicator(),
              ));
  }
}
