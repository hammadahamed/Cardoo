import 'package:cardoo/cardList.dart';
import 'package:cardoo/essentials/app_bar.dart';
import 'package:cardoo/essentials/my_colors.dart';
import 'package:cardoo/modals/card_detail_modal.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddCard extends StatefulWidget {
  final int index;
  final bool isEdit;
  final CardDetails card;

  AddCard({this.index = 0, this.isEdit = false, this.card});
  @override
  State<StatefulWidget> createState() {
    return AddCardState();
  }
}

class AddCardState extends State<AddCard> {
  String textFieldError = "This field cant be empty";

  CardDetails _cardDetails = CardDetails();

  InputDecoration customInputDecoration({label}) => InputDecoration(
      labelText: label,
      labelStyle: TextStyle(color: Colors.blue),
      filled: true,
      fillColor: MyColors.lighterDarkBg2,
      focusColor: Colors.white);

  final formKey = GlobalKey<FormState>();

  Widget bigGap() {
    return SizedBox(
      height: 15,
    );
  }

  addCardFunction(form) {
    Provider.of<CardList>(context, listen: false).addCard(_cardDetails);
    Provider.of<CardList>(context, listen: false)
        .save()
        .then((_) => Provider.of<CardList>(context, listen: false).load());

    // ..save();
    form.reset();
    Navigator.pop(context);
  }

  updateCardFunction(form) {
    Provider.of<CardList>(context, listen: false)
        .save()
        .then((_) => Provider.of<CardList>(context, listen: false).load());

    // ..save();
    form.reset();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    int index = widget.index;
    bool isEdit = widget.isEdit;
    CardDetails currentCardInstance = widget.card;
    var currentCard;
    if (Provider.of<CardList>(context, listen: false).cardList.length > 0) {
      currentCard =
          Provider.of<CardList>(context, listen: false).cardList[index];
    }

    return SafeArea(
      child: Scaffold(
        appBar: MyAppBar(
          title: "Add Card",
        ),
        backgroundColor: MyColors.darkBg,
        body: Center(
          child: Container(
            width: 400,
            padding: EdgeInsets.all(30),
            child: Form(
                key: formKey,
                child: ListView(
                  children: [
                    // -------------------------- CARD NAME --------------------------

                    TextFormField(
                        // ignore: missing_return
                        validator: (value) {
                          if (value.isEmpty) {
                            return textFieldError;
                          }
                        },
                        onSaved: (value) {
                          isEdit
                              ? currentCard.cardName = value
                              : _cardDetails.cardName = value;
                        },
                        initialValue:
                            isEdit ? currentCardInstance.cardName : "",
                        style: TextStyle(color: Colors.white),
                        enableSuggestions: true,
                        decoration: customInputDecoration(label: "Bank Name")),
                    bigGap(),
                    // -------------------------- CARD DESCRIPTION --------------------------

                    TextFormField(
                      // ignore: missing_return
                      validator: (value) {
                        if (value.isEmpty) {
                          return textFieldError;
                        }
                      },
                      onSaved: (value) {
                        isEdit
                            ? currentCard.cardDescription = value
                            : _cardDetails.cardDescription = value;
                      },
                      initialValue:
                          isEdit ? currentCardInstance.cardDescription : "",
                      style: TextStyle(color: Colors.white),
                      enableSuggestions: true,
                      decoration:
                          customInputDecoration(label: "Card Description"),
                    ),
                    bigGap(),
                    // -------------------------- CARD NUMBER --------------------------
                    TextFormField(
                      // ignore: missing_return
                      validator: (value) {
                        if (value.isEmpty) {
                          return textFieldError;
                        }
                      },
                      onSaved: (value) {
                        isEdit
                            ? currentCard.cardNumber = value
                            : _cardDetails.cardNumber = value;
                      },
                      initialValue:
                          isEdit ? currentCardInstance.cardNumber : "",
                      style: TextStyle(color: Colors.white),
                      enableSuggestions: true,
                      keyboardType: TextInputType.number,
                      decoration: customInputDecoration(label: "Card Number"),
                    ),
                    bigGap(),
                    // -------------------------- EXPIRY DATE --------------------------
                    Container(
                      height: 100,
                      padding: EdgeInsets.all(20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 70,
                            width: 70,
                            child: TextFormField(
                              // ignore: missing_return
                              validator: (value) {
                                if (value.isEmpty) {
                                  return textFieldError;
                                }
                              },
                              onSaved: (value) {
                                isEdit
                                    ? currentCard.expiry1 = value
                                    : _cardDetails.expiry1 = value;
                              },
                              initialValue:
                                  isEdit ? currentCardInstance.expiry1 : "",
                              style: TextStyle(color: Colors.white),
                              keyboardType: TextInputType.number,
                              decoration: customInputDecoration(label: "MM"),
                            ),
                          ),
                          Text(
                            "   /   ",
                            style: TextStyle(
                                color: MyColors.lighterDarkBg2,
                                fontWeight: FontWeight.w800,
                                fontSize: 30),
                          ),
                          Container(
                            height: 70,
                            width: 70,
                            // color: Colors.red,
                            child: TextFormField(
                              // ignore: missing_return
                              validator: (value) {
                                if (value.isEmpty) {
                                  return textFieldError;
                                }
                              },
                              onSaved: (value) {
                                isEdit
                                    ? currentCard.expiry2 = value
                                    : _cardDetails.expiry2 = value;
                              },
                              initialValue:
                                  isEdit ? currentCardInstance.expiry2 : "",
                              style: TextStyle(color: Colors.white),
                              keyboardType: TextInputType.number,
                              decoration: customInputDecoration(label: "YY"),
                            ),
                          ),
                        ],
                      ),
                    ),
                    bigGap(),
                    // -------------------------- CVV / CCV NUMBER --------------------------

                    TextFormField(
                      // ignore: missing_return
                      validator: (value) {
                        if (value.isEmpty) {
                          return textFieldError;
                        }
                      },
                      onSaved: (value) {
                        isEdit
                            ? currentCard.code = value
                            : _cardDetails.code = value;
                      },
                      initialValue: isEdit ? currentCardInstance.code : "",
                      style: TextStyle(color: Colors.white),
                      enableSuggestions: true,
                      keyboardType: TextInputType.number,
                      decoration: customInputDecoration(label: "CCV / CVV"),
                    ),
                    bigGap(),
                    ButtonBar(alignment: MainAxisAlignment.center, children: [
                      RaisedButton(
                        color: Colors.blue,
                        // onPressed: isEdit
                        //     ? () {
                        //         var form = formKey.currentState;
                        //         updateCardFunction(form);
                        //       }
                        //     : () {
                        //         var form = formKey.currentState;
                        //         addCardFunction(form);
                        //       },
                        onPressed: () {
                          var form = formKey.currentState;
                          if (form.validate()) {
                            form.save();
                            isEdit
                                ? updateCardFunction(form)
                                : addCardFunction(form);
                          }
                        },
                        child: Text(
                          isEdit ? "SAVE" : "ADD",
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        ),
                      ),
                    ])
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
