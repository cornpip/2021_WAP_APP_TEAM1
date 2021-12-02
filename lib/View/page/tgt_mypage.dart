import 'package:flutter/material.dart';

class TGTMyPageWidget extends StatefulWidget {
  const TGTMyPageWidget({Key key}) : super(key: key);

  @override
  _TGTMyPageWidgetState createState() => _TGTMyPageWidgetState();
}

List<bool> _buttonsState = List.generate(2, (index) => false);

class _TGTMyPageWidgetState extends State<TGTMyPageWidget> {
  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 65,
        elevation: 0.0,
        title: Text(
          "마이페이지",
          style: TextStyle(color: Colors.black, fontSize: 25),
        ),
        leading: IconButton(
          iconSize: 30,
          color: Colors.black,
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      key: _scaffoldKey,
      body: Scaffold(
        body: Column(
          children: [
            Center(
              child: ToggleButtons(
                children: <Widget>[
                  Container(
                      height: (MediaQuery.of(context).size.height) * 0.07,
                      color:
                          _buttonsState[0] ? Color(0xff18A0FB) : Colors.white,
                      width: (MediaQuery.of(context).size.width - 36) / 2,
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          new Icon(
                            Icons.description,
                            size: 16.0,
                            color: _buttonsState[0]
                                ? Colors.white
                                : Color(0xff18A0FB),
                          ),
                          new SizedBox(
                            width: 4.0,
                          ),
                          new Text("등록한 컨텐츠",
                              style: TextStyle(
                                  color: _buttonsState[0]
                                      ? Colors.white
                                      : Color(0xff18A0FB),
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold)),
                        ],
                      )),
                  Container(
                      height: (MediaQuery.of(context).size.height) * 0.07,
                      color:
                          _buttonsState[1] ? Color(0xff18A0FB) : Colors.white,
                      width: (MediaQuery.of(context).size.width - 36) / 2,
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          new Icon(
                            Icons.height,
                            size: 16.0,
                            color: _buttonsState[1]
                                ? Colors.white
                                : Color(0xff18A0FB),
                          ),
                          new SizedBox(
                            width: 4.0,
                          ),
                          new Text("참여중인 컨텐츠",
                              style: TextStyle(
                                  color: _buttonsState[1]
                                      ? Colors.white
                                      : Color(0xff18A0FB),
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold))
                        ],
                      )),
                ],
                onPressed: (int index) => {
                  setState(() {
                    _buttonsState[index] = !_buttonsState[index];
                  })
                },
                isSelected: _buttonsState,
              ),
            ),
            Card(
              child: Container(
                height: 100,
                width: MediaQuery.of(context).size.width * 0.9,
                color: Colors.white,
                child: Row(
                  children: [
                    Center(
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Expanded(
                          child: Image.asset("asset/images/sample.jpg"),
                          flex: 2,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        alignment: Alignment.topLeft,
                        child: Column(
                          children: [
                            Expanded(
                              flex: 5,
                              child: ListTile(
                                title: Text("풋살할 사람"),
                                subtitle: Text("오늘 18시 풋살 하실 분 구합니다."),
                              ),
                            ),
                            Expanded(
                              flex: 5,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "1 / 12",
                                    style: TextStyle(
                                      color: const Color(0xff18A0FB),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      flex: 8,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
