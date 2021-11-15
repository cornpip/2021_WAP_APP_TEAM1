import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:together/add.dart';
import 'package:provider/provider.dart';
import 'package:together/src/Provider/counter_Provider.dart';

void main() async => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home : ChangeNotifierProvider(
        create:(BuildContext context)  => CountProvider(),
    child : add(),
    ),
    );
  }
}



