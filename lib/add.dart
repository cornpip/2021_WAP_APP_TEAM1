import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:together/TGTtop_bar.dart';

class add extends StatefulWidget {
  add({Key? key}) : super(key: key);
  @override
  _addState createState() => _addState();
}
 class _addState extends State<add> {
  File? image;

  Future<File> saveImagePermanently(String imagePath) async {
    final directory = await getApplicationDocumentsDirectory();
    final image = File('${directory.path}/name');

    return File(imagePath).copy(image.path);
  }

  final _valueList = ['FOOD', 'PRACTICE', 'GOODS', 'ETC'];
  var _selectedValue;
  @override
  Widget build(BuildContext context) {
    Future pickImage(ImageSource source) async {
      try {
        final image = await ImagePicker().pickImage(source: source);
        if (image == null) return;
        final imagePermanent = await saveImagePermanently(image.path);
        setState(() => this.image = imagePermanent);
      } on PlatformException catch (e) {
        print('Failed to pick Image : $e');
      }
    }

    return Scaffold(
      appBar: TGTtop_bar
      body: SafeArea(
          child: Column(
            children: <Widget>[
              image != null
                  ? Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: FileImage(image!)
                      )
                   )

              )
                  : RaisedButton(onPressed: () =>
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
                              onPressed: () => pickImage(ImageSource.camera),
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
                  ),
                  child: Icon(Icons.add_photo_alternate, color: Colors.grey,
                      size: 100)),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child:TextFormField(
                  decoration: InputDecoration(
                      labelText: '제목을 입력해주세요',
                      border: OutlineInputBorder()),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child:TextFormField(
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
                    value : _selectedValue,
                    items: _valueList.map((value){
                          return DropdownMenuItem(
                            value : value, child: Text(value));
                        }).toList(),
                    onChanged: (value){
                      print(value);
                      setState(() {
                        _selectedValue = value;
                      });
                    },
                  ),
                ),
              ),
              Padding(
                padding:const EdgeInsets.all(8.0),
                child: TextButton(
                  onPressed: (){

                  },
                  child: Text("위치 선택"),
                ),
              ),

            ],
          )


      ),

    );

  }



}