// import 'package:flutter/material.dart';

class CardDetails {
  var cardName;
  var cardDescription;
  var cardNumber;
  var expiry1;
  var expiry2;
  var code;

  CardDetails(
      {this.cardName,
      this.cardDescription,
      this.cardNumber,
      this.expiry1,
      this.expiry2,
      this.code});

  CardDetails.toObj(Map map)
      : cardName = map["cardName"],
        cardDescription = map["cardDescription"],
        cardNumber = map["cardNumber"],
        expiry1 = map["expiry1"],
        expiry2 = map["expiry2"],
        code = map["code"];

  Map toMap() => {
        "cardName": cardName,
        "cardDescription": cardDescription,
        "cardNumber": cardNumber,
        "expiry1": expiry1,
        "expiry2": expiry2,
        "code": code,
      };

  // final Map<dynamic, dynamic> cardDetails = {
  //   "cardName": "",
  //   "cardDescription": "",
  //   "cardNumber": 0,
  //   "expiry": "",
  //   "code": 0,
  // };

  // Map getList() {
  //   cardDetails["cardName"] = cardName;
  //   cardDetails["cardDescription"] = cardDescription;
  //   cardDetails["cardNumber"] = cardNumber;
  //   cardDetails["expiry"] = expiry1 + "/" + expiry2;
  //   cardDetails["code"] = code;
  //   return cardDetails;
  // }
}
