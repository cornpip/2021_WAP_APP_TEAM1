import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TGTtop_bar extends StatefulWidget{

  var title = "together";
  final VoidCallback onPressed;

  TGTtop_bar({
    Key? key,
  required this.title,
  required this.onPressed,
  }) : super(key: key);

  @override
  _TGTtop_bar createState() => _TGTtop_bar();
}

class _TGTtop_bar extends State<TGTtop_bar> {
  var title;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override

  void initState(){
    super.initState();
  }

  Widget build(BuildContext context){
    return Scaffold(
      key:_scaffoldKey,
      endDrawer : Container(
        width:250,
        child : Drawer(
            child : ListView(
              padding : EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                  child:Text('Drawer'),
                  decoration: BoxDecoration(
                    color:Colors.blue,),
                ),
              ],
            )
        ),
      ),
    appBar: AppBar(
        title: Text('together'),
        centerTitle: true, elevation:0.0,
        leading: IconButton(
            icon:Icon(Icons.arrow_left_rounded),
            onPressed: (){
              print('gotoback(navigation위젯');
            }
        ),
      actions: <Widget>[
        Container(
          child: IconButton(
            iconSize: 40,
            color: Colors.black,
            icon: Icon(Icons.menu),
            onPressed: () {
              _scaffoldKey.currentState!.openEndDrawer();
            },
          ),
        )
      ]),
        // actions: [
        //   IconButton(
        //     icon: Icon(
        //       Icons.account_circle,
        //     ),
        //     onPressed: (){},
        //   ),
        // ],
    );
    }

}