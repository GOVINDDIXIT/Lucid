import 'package:Lucid/Wallpaper/WallScreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';


void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  static FirebaseAnalytics analytics = new FirebaseAnalytics();
  static FirebaseAnalyticsObserver observer =
      new FirebaseAnalyticsObserver(analytics: analytics);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter',
      theme: new ThemeData(
        primarySwatch: Colors.red
      ),
      navigatorObservers: <NavigatorObserver>[observer],
      home: new WallScreen(analytics: analytics, observer: observer),
      //home: new HomePage(),
            
          
           // home: new WallScreen(),
          );
        }
      }
      class HomePage extends StatelessWidget {
        @override
        Widget build(BuildContext context) {
          return new Scaffold(
            appBar: new AppBar(
              title: new Text("Lucid"),
              
            ),
            
            body: new Container(
              child: new Center(
                child: new Text("Home Page"),
              ),
            ),
            
          );
        }
      }