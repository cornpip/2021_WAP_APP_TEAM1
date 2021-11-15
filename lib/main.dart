import 'package:flutter/material.dart';
import 'view/tgt_mypage_widget.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TopBar(),
    );
  }
}

class TopBar extends StatefulWidget {
  TopBar({Key? key}) : super(key: key);

  @override
  _TopBarState createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: Container(
        width: 250,
        child: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                child: Text("프로필?"),
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
                title: Text("지도로 위치 찍기"),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => TGTMyPageWidget()));
                },
              ),
              Divider(
                thickness: 1,
              ),
              ListTile(
                title: Text("설정"),
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
      ),
      appBar: AppBar(
          backgroundColor: Colors.white,
          toolbarHeight: 80,
          title: Text(
            "Togetor",
            style: TextStyle(
                fontFamily: 'Worksans', color: Colors.black, fontSize: 35),
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
    );
  }
}

// class MapSample extends StatefulWidget {
//   @override
//   State<MapSample> createState() => MapSampleState();
// }
//
// class MapSampleState extends State<MapSample> {
//   Completer<GoogleMapController> _controller = Completer();
//
//   static final CameraPosition _kGooglePlex = CameraPosition(
//     target: LatLng(37.42796133580664, -122.085749655962),
//     zoom: 14.4746,
//   );
//
//   static final CameraPosition _kLake = CameraPosition(
//       bearing: 192.8334901395799,
//       target: LatLng(37.43296265331129, -122.08832357078792),
//       tilt: 59.440717697143555,
//       zoom: 19.151926040649414);
//
//   @override
//   Widget build(BuildContext context) {
//     return new Scaffold(
//       body: GoogleMap(
//         mapType: MapType.hybrid,
//         initialCameraPosition: _kGooglePlex,
//         onMapCreated: (GoogleMapController controller) {
//           _controller.complete(controller);
//         },
//       ),
//       floatingActionButton: FloatingActionButton.extended(
//         onPressed: _goToTheLake,
//         label: Text('To the lake!'),
//         icon: Icon(Icons.directions_boat),
//       ),
//     );
//   }
