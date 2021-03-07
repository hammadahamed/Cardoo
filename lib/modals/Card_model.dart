import 'dart:ui';

import 'package:cardoo/cardList.dart';
import 'package:cardoo/modals/card_detail_modal.dart';
import 'package:flutter/material.dart';
import 'package:cardoo/essentials/my_colors.dart';
import 'package:provider/provider.dart';
import 'package:clipboard/clipboard.dart';
import 'package:cardoo/screens/add_card.dart';

enum menuOptions {
  copy,
  edit,
  delete,
}

class CardModel extends StatelessWidget {
  final CardDetails card;
  final index;
  CardModel({
    this.card,
    this.index,
  });

  Widget customTextFormField() {
    return Container(
      // color: Colors.green,
      width: 50,
      child: TextFormField(
        maxLength: 4,
        textDirection: TextDirection.rtl,
      ),
    );
  }

  Widget titleText({String text}) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 16,
        fontFamily: 'montserrat_semibold',
        // fontWeight: FontWeight.bold,
        color: MyColors.greyWhiteLetter,
      ),
    );
  }

  Widget bigGap() {
    return SizedBox(
      height: 15,
    );
  }

  Widget smallGap() {
    return SizedBox(
      height: 5,
    );
  }

  Widget dataText({String text}) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 16,
        color: MyColors.greyWhiteLetter,
      ),
    );
  }

  IconButton menuButton({Icon icon}) {
    return IconButton(
      icon: icon,
      onPressed: () {},
      color: MyColors.greyWhiteLetter,
    );
  }

  Text menuText(String text) {
    return Text(
      text,
      style: TextStyle(
        color: MyColors.greyWhiteLetter,
      ),
    );
  }

  List<PopupMenuItem> myPopUpItems() {
    return [
      PopupMenuItem(
        value: menuOptions.copy,
        child: Row(
          children: [
            menuButton(icon: Icon(Icons.copy_rounded)),
            menuText("Copy Number"),
          ],
        ),
      ),
      PopupMenuItem(
        value: menuOptions.edit,
        child: Row(
          children: [
            menuButton(icon: Icon(Icons.edit)),
            menuText("Edit"),
          ],
        ),
      ),
      PopupMenuItem(
        value: menuOptions.delete,
        child: Row(
          children: [
            menuButton(icon: Icon(Icons.delete)),
            menuText("Delete"),
          ],
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: () {
        final sBar = SnackBar(
            duration: Duration(seconds: 1),
            backgroundColor: Colors.white,
            content: Text(
              card.cardDescription,
              style: TextStyle(
                color: Colors.black,
              ),
            ));
        Scaffold.of(context).showSnackBar(sBar);
      },
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          height: 250,
          width: 350,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [MyColors.lighterDarkBg1, MyColors.lighterDarkBg],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                tileMode: TileMode.clamp,
              ),
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black,
                  blurRadius: 15,
                )
              ]),
          // Children widget to be placed here
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            color: Colors.transparent,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // the title  -->  CARD
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  children: [
                    Container(
                      width: 300,
                      child: Text(
                        card.cardName == null
                            ? '-'
                            : card.cardName.toUpperCase(),
                        overflow: TextOverflow.ellipsis,
                        // softWrap: true,
                        style: TextStyle(
                          color: MyColors.lighterDarkBg2,
                          fontSize: 30,
                          fontFamily: 'montserrat_bold',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    //  ------------------------------------    OPTIONS   ----------------------------------------------
                    PopupMenuButton(
                      onSelected: (item) {
                        print(item);
                        // ---------------->  COPY
                        if (item == menuOptions.copy) {
                          FlutterClipboard.copy(card.cardNumber).then((value) {
                            final sBar = SnackBar(
                                duration: Duration(milliseconds: 500),
                                backgroundColor: Colors.white,
                                content: Text(
                                  " Copied  \" " +
                                      card.cardNumber +
                                      " \"  to ClipBoard",
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ));
                            Scaffold.of(context).showSnackBar(sBar);
                          });
                        }

                        // ---------------->  DELETE
                        if (item == menuOptions.delete) {
                          Provider.of<CardList>(context, listen: false)
                              .removeCardAt(index);
                        }

                        // ---------------->  EDIT
                        if (item == menuOptions.edit) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AddCard(
                                        index: index,
                                        card: card,
                                        isEdit: true,
                                      )));
                        }
                      },
                      icon: Icon(Icons.keyboard_arrow_down,
                          color: MyColors.greyWhiteLetter),
                      color: MyColors.lighterDarkBg,
                      itemBuilder: (context) => myPopUpItems(),
                    ),
                  ],
                ),
                bigGap(),
                // smallGap(),
                titleText(text: "CARD NUMBER"),
                smallGap(),
                dataText(text: card.cardNumber == null ? '-' : card.cardNumber),
                bigGap(),
                titleText(text: "EXPIRY"),
                smallGap(),
                dataText(
                    text: card.expiry1 == null
                        ? "-"
                        : card.expiry1 + " / " + card.expiry2),
                bigGap(),
                titleText(text: "CCV / CVV NUMBER"),
                smallGap(),
                dataText(text: card.code == null ? "-" : card.code),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
