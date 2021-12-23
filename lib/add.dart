import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:together/src/Provider/counter_Provider.dart';
import 'package:together/src/ui/TGTtop_bar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:together/src/ui/tgtbutton.dart';

class add extends StatefulWidget {
  add({Key? key}) : super(key: key);
  @override
  _addState createState() => _addState();
}
class _addState extends State<add> {
  File? _contentImage;

  Future<File> saveImagePermanently(String imagePath) async {
    final directory = await getApplicationDocumentsDirectory();
    final _contentImage = File('${directory.path}/name');
    return File(imagePath).copy(_contentImage.path);
  }

  final TextEditingController _title = new TextEditingController();
  final TextEditingController _detail = new TextEditingController();
  final _valueList = ['FOOD', 'PRACTICE', 'GOODS', 'ETC'];
  var _selectedValue;
  //_place 추가하기
  late DateTime _limitedDate = new DateTime.now();
  late CountProvider _maxparticipant;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    _maxparticipant = Provider.of<CountProvider>(context);

    Future pickImage(ImageSource source) async {
      try {
        final _contentImage = await ImagePicker().pickImage(source: source);
        if (_contentImage == null) return;
        final imagePermanent = await saveImagePermanently(_contentImage.path);
        setState(() => this._contentImage = imagePermanent);
      } on PlatformException catch (e) {
        print('Failed to pick Image : $e');
      }
    }

    return Scaffold(
      key: _scaffoldKey,
      endDrawer: Container(
        width: 250,
        child: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                  child: Text('Drawer'),
                  decoration: BoxDecoration(
                    color: Colors.blue,),
                ),
              ],
            )
        ),
      ),
      appBar: TGTtop_bar(key: _scaffoldKey, appBar: AppBar(), title: "등록"),
      body: SafeArea(
          child: Column(
            children: <Widget>[
              _contentImage != null
                  ? Container(
                  width: 100, height: 100,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.fill,
                          image: FileImage(File(_contentImage!.path))
                      ),
                  ),
              )
                  : IconButton(
                icon : Icon(Icons.add_photo_alternate),
                color: Colors.grey,
                iconSize: 100,
                onPressed: () {
                  showDialog<void>(
                      context: context,
                      builder: (BuildContext context) {
                        return SimpleDialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          title: Text(
                            'Add picture', style: TextStyle(color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                          ),
                children: <Widget>[
                  SimpleDialogOption(
                    child: Text('사진 찍기',
                        style: TextStyle(color: Colors.black)),
                    onPressed : () => pickImage(ImageSource.camera),
                  ),


                  SimpleDialogOption(
                    child: Text('사진 가져오기',
                        style: TextStyle(color: Colors.black)),
                    onPressed: () => pickImage(ImageSource.gallery),
                  ),
                  SimpleDialogOption(
                    child: Text('취소',
                        style: TextStyle(color: Colors.grey)),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              );
            }
        ); },
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller : _title,
                  decoration: InputDecoration(
                      labelText: '제목을 입력해주세요',
                      border: OutlineInputBorder()
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _detail,
                  decoration: InputDecoration(
                      labelText: '상세내용을 입력해주세요',
                      border: OutlineInputBorder()),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: DropdownButton(
                    hint: Text('카테고리'),
                    value: _selectedValue,
                    items: _valueList.map((value) {
                      return DropdownMenuItem(
                          value: value, child: Text(value));
                    }).toList(),
                    onChanged: (value) {
                      print(value);
                      setState(() {
                        _selectedValue = value;
                      });
                    },
                  ),
                ),
              ),
              TextButton(
                child: Text('위치선택'),
                onPressed: (){},
              ),
              TextButton(
                child: Text('날짜선택'),
                onPressed: (){
                  Future<DateTime?> selectedDate = showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2021),
                      lastDate: DateTime(2025),
                    builder: (BuildContext context, Widget? child){
                        return Theme(
                          data: ThemeData.light(),
                          child: child!,
                        );
                    },
                  );
                  selectedDate.then((dateTime){
                    setState((){
                      _limitedDate = dateTime!;
                    });
                  });
                },
              ),
              Text('${_limitedDate.year}/${_limitedDate.month}/${_limitedDate.day}', style: TextStyle(fontSize: 20),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text('인원수'),
                  Text(Provider.of<CountProvider>(context).count.toString()),
                  IconButton(onPressed: () {
                    _maxparticipant.add();
                  },
                    icon: Icon(Icons.add),
                  ),
                  IconButton(onPressed: () {
                    _maxparticipant.remove();
                  },
                    icon: Icon(Icons.remove),
                  ),
                ],
              ),
              TGTButton(
                child: const Icon(
                  Icons.upload,
                  color: Colors.white,
                  size: 30.0,
                ),
                onPressed: () {
                  //setContent
                },
              )
            ],
          )
      ),
    );
  }
}

// void setContent() async {
//   String TGTContenturl = "http://118.223.255.68:4000/";
//   var TGTContentresponse = await http.get(TGTContenturl);
//   var TGTContentData = convert.jsonDecode(
//       convert.utf8.decode(TGTContentresponse.bodyBytes));
//   setState(
//         () {
//       _title = TGTContentData["title"];
//       _detail = TGTContentData["detail"];
//       _contentImage = TGTContentData["contentImage"];
//       _maxParticipant = TGTContentData["maxParticipant"];
//       _limitedDate = TGTContentData["limitedDate"];
//     },
//   );
// }

