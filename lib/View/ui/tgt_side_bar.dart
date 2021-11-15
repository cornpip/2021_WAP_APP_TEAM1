import 'package:flutter/material.dart';
import '../page/tgt_mypage.dart';
// import '../page/tgt_mypage_widget.dart';

class TGTSideBar extends StatefulWidget {
  const TGTSideBar({Key? key}) : super(key: key);

  @override
  _TGTSideBarState createState() => _TGTSideBarState();
}

class _TGTSideBarState extends State<TGTSideBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      child: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              child: Text("프로필"),
              decoration: BoxDecoration(color: Colors.blueGrey),
            ),
            ListTile(
              title: Text("마이페이지로 가기"),
              onTap: () {
                //아래처럼 하면 사이드바가 사라지지 않은 상태에서 Mypage가 위에 덮어짐.
                //사이드바가 사라지면서 이동할 수 있는 것도 찾아보기.
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => TGTMyPageWidget()));
              },
            ),
            Divider(
              thickness: 1,
            ),
            ListTile(
              // 여기서부터 임시
              title: Text("알림"),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => TGTMyPageWidget()));
              },
            ),
            Divider(
              thickness: 1,
            ),
            ListTile(
              title: Text("환경설정"),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => TGTMyPageWidget()));
              },
            ),
            Divider(
              thickness: 1,
            ),
            ListTile(
              title: Text("지도로 보기"),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => TGTMyPageWidget()));
              },
            ),
            Divider(
              thickness: 1,
            ),
          ],
        ),
      ),
    );
  }
}