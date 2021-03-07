import 'package:flutter/material.dart';
import 'package:cardoo/essentials/my_colors.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool menu;
  MyAppBar({@required this.title, this.menu = false});
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 15,
      // centerTitle: true,
      actions: [
        menu
            ? IconButton(
                icon: Icon(Icons.settings),
                color: Colors.blue,
                onPressed: () {},
              )
            : SizedBox()
      ],

      backgroundColor: MyColors.lighterDarkBg,
      title: Text(
        title,
        style: TextStyle(
          color: Colors.blue,
          fontSize: 25,
          fontFamily: "montserrat_semibold",
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
