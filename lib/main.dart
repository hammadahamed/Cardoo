import 'package:cardoo/cardList.dart';
import 'package:cardoo/essentials/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cardoo/screens/home.dart';
import 'package:splashscreen/splashscreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CardList>(
      create: (BuildContext context) => CardList(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Cardoo',
        theme: ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: SplashScreen(
          loaderColor: MyColors.lighterDarkBg,
          photoSize: 150,
          seconds: 3,
          backgroundColor: Colors.white,
          image: Image.asset("assets/cardoo.png"),
          navigateAfterSeconds: MyHomePage(),
        ),
      ),
    );
  }
}
