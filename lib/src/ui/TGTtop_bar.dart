import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TGTtop_bar extends StatelessWidget implements PreferredSizeWidget {

  TGTtop_bar({required Key key,
    required this.appBar,
    required this.title,
    this.center = true})
      : super(key: key);

  final AppBar appBar;
  final String title;
  final bool center;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      key:_scaffoldKey,
        title: Text("$title"),
        centerTitle: center,
        leading: IconButton(
           icon:Icon(Icons.arrow_left_rounded),
             onPressed: () => Navigator.of(context).pop(),
        ),
      actions: <Widget>[
        Container(
          child: IconButton(
          iconSize: 40,
           color: Colors.black,
           icon: Icon(Icons.menu),
            onPressed: () =>
              _scaffoldKey.currentState!.openEndDrawer(),
          ),
    ),
      ]
    );
  }
  @override
  Size get preferredSize => Size.fromHeight(appBar.preferredSize.height);
}

