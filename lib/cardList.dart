import 'dart:convert';
import 'package:cardoo/modals/card_detail_modal.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CardList extends ChangeNotifier {
  List cardList = [];
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  addCard(CardDetails card) async {
    cardList.add(card);
    notifyListeners();
  }

  //on load , Maps -> Objects
  load() async {
    SharedPreferences prefs = await _prefs;
    // initializeCardList();
    var list = prefs.getStringList("cardList");

    var temp = list.map((val) => CardDetails.toObj(jsonDecode(val))).toList();
    cardList = temp;
    // setState(() {});
    print("----------  load()  ------------");
    print(cardList);
    print("----------  load()  ------------");
    notifyListeners();
  }

  // on save, objects -> maps
  save() async {
    SharedPreferences prefs = await _prefs;
    var temp = cardList.map((val) => jsonEncode(val.toMap())).toList();
    prefs.setStringList("cardList", temp);
    print("----------  save()  ------------");
    print(temp);
    print("----------  save()  ------------");
  }

  removeCardAt(int i) async {
    cardList.removeAt(i);
    save().then((_) {
      load();
    });
  }
}
