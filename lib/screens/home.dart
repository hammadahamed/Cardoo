import 'dart:ui';

import 'package:cardoo/cardList.dart';
import 'package:cardoo/modals/Card_model.dart';
import 'package:flutter/material.dart';
import 'package:cardoo/essentials/app_bar.dart';
import 'package:cardoo/essentials/my_colors.dart';
import 'package:cardoo/screens/add_card.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String noCardMessage =
      "You don't have cards yet ! \n Click + button below to add one";

  Widget noCardWidget() {
    return Center(
        child: Text(
      noCardMessage,
      textAlign: TextAlign.center,
      style: TextStyle(color: MyColors.greyWhiteLetter, fontSize: 18),
    ));
  }

  @override
  void initState() {
    Provider.of<CardList>(context, listen: false).load();
    // });
    // ..load();
    // setState(() {});
    super.initState();
  }

  // @override
  // void dispose() {
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    // Provider.of<CardList>(context, listen: false).load();

    var hyt = MediaQuery.of(context).size.height;
    var wyd = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        appBar: MyAppBar(
          title: "Cardoo",
          menu: true,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddCard())),
          child: Icon(
            Icons.add,
            color: MyColors.darkBg,
            size: 35,
          ),
          backgroundColor: Colors.blue,
        ),
        body: Consumer<CardList>(
          builder: (context, cardListObject, _) {
            // Provider.of<CardList>(context, listen: false).load();
            return Container(
                height: hyt,
                width: wyd,
                color: MyColors.darkBg,
                padding: EdgeInsets.all(5),
                child: cardListObject.cardList.length == 0
                    ? noCardWidget()
                    : ListView.builder(
                        itemCount: cardListObject.cardList.length,
                        itemBuilder: (context, index) => CardModel(
                            card: cardListObject.cardList[index], index: index),
                      ));
          },
        ),
      ),
    );
  }
}
