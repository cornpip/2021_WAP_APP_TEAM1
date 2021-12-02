import 'package:flutter/material.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:togetor_app/Model/place.dart';
import 'package:togetor_app/Service/application_bloc.dart';
import 'package:togetor_app/Service/place_service.dart';
import 'package:togetor_app/View/ui/tgt_button.dart';

class MapScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ApplicationBloc(),
      child: MaterialApp(
        home: MapSample(),
      ),
    );
  }
}

class MapSample extends StatefulWidget {
  const MapSample({Key key}) : super(key: key);

  @override
  _MapSampleState createState() => _MapSampleState();
}

class _MapSampleState extends State<MapSample> {
  Completer<GoogleMapController> _mapController = Completer();
  StreamSubscription locationSubscription;
  Place place;
  final placeService = PlaceService();
  final Set<Marker> _markers = Set();

  @override
  void initState() {
    final applicationBloc =
        Provider.of<ApplicationBloc>(context, listen: false);

    locationSubscription =
        applicationBloc.selectedLocation.stream.listen((place) {
      if (place != null) {
        _goToPlace(place);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    final applicationBloc =
        Provider.of<ApplicationBloc>(context, listen: false);
    applicationBloc.dispose();
    locationSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final applicationBloc = Provider.of<ApplicationBloc>(context);
    return Scaffold(
      body: (applicationBloc.currentLocation == null)
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search Location',
                      suffixIcon: Icon(Icons.search),
                    ),
                    onChanged: (value) => applicationBloc.searchPlaces(value),
                  ),
                ),
                Stack(
                  children: [
                    Container(
                      height: (MediaQuery.of(context).size.height) * 0.6,
                      child: GoogleMap(
                        myLocationEnabled: true,
                        initialCameraPosition: CameraPosition(
                            target: LatLng(
                                applicationBloc.currentLocation.latitude,
                                applicationBloc.currentLocation.longitude),
                            zoom: 14),
                        onMapCreated: (GoogleMapController controller) {
                          _mapController.complete(controller);
                        },
                        markers: _markers,
                      ),
                    ),
                    if (applicationBloc.searchResults != null &&
                        applicationBloc.searchResults.length != 0)
                      Container(
                        height: (MediaQuery.of(context).size.height) * 0.6,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.6),
                            backgroundBlendMode: BlendMode.darken),
                      ),
                    if (applicationBloc.searchResults != null &&
                        applicationBloc.searchResults.length != 0)
                      Container(
                        height: (MediaQuery.of(context).size.height) * 0.6,
                        child: ListView.builder(
                          itemCount: applicationBloc.searchResults.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(
                                applicationBloc
                                    .searchResults[index].description,
                                style: TextStyle(color: Colors.white),
                              ),
                              onTap: () async {
                                place = await PlaceService().getPlace(
                                    applicationBloc
                                        .searchResults[index].placeId);
                                moveToLocation();
                                applicationBloc.searchResults = null;
                              },
                            );
                          },
                        ),
                      )
                  ],
                ),
                Container(
                  child: (place == null)
                      ? Column(
                          children: <Widget>[
                            Card(
                              child: ListTile(
                                title: Text('주소'),
                              ),
                            ),
                            Card(
                              child: ListTile(
                                title: Text('상세주소'),
                              ),
                            ),
                          ],
                        )
                      : Column(
                          children: <Widget>[
                            Card(
                              child: ListTile(
                                title: Text('${place.name}'),
                              ),
                            ),
                            Card(
                              child: ListTile(
                                title: Text('${place.formattedAddress}'),
                              ),
                            ),
                          ],
                        ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: (MediaQuery.of(context).size.height) * 0.02,
                      horizontal: (MediaQuery.of(context).size.width) * 0.3),
                  child: TextButton(
                    child: Text('설정'),
                    style: TextButton.styleFrom(
                      primary: Colors.white,
                      backgroundColor: Colors.blueAccent,
                      onSurface: Colors.grey,
                    ),
                    onPressed: () {
                      // 위치 값들 넘기자(마커로 찍은 위치를 넘겨야한다)
                    },
                  ),
                ),
              ],
            ),
    );
  }

  Future<void> _goToPlace(Place place) async {
    final GoogleMapController controller = await _mapController.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target:
            LatLng(place.geometry.location.lat, place.geometry.location.lng),
        zoom: 14.0)));
  }

  void moveToLocation() async {
    if (_markers.length > 0) {
      setState(() {
        _markers.clear();
      });
    }

    GoogleMapController controller = await _mapController.future;
    controller.animateCamera(
      CameraUpdate.newLatLng(
        LatLng(place.lat, place.lng),
      ),
    );

    setState(() {
      _markers.add(
        Marker(
          markerId: MarkerId(place.placeId),
          position: LatLng(place.lat, place.lng),
          infoWindow: InfoWindow(
            title: place.name,
            snippet: place.formattedAddress,
          ),
        ),
      );
    });
  }

  Widget _showPlaceInfo() {
    if (place == null) {
      return Container();
    }
    return Container(
      child: Column(
        children: <Widget>[
          Card(
            child: ListTile(
              title: Text('${place.name}'),
            ),
          ),
          Card(
            child: ListTile(
              title: Text('${place.formattedAddress}'),
            ),
          ),
        ],
      ),
    );
  }
}
