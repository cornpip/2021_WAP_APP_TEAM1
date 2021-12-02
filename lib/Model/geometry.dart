import 'package:togetor_app/Model/location.dart';

class Geometry { //현재 위치
  final Location location;

  Geometry({this.location});

  factory Geometry.fromJson(Map<dynamic, dynamic> parsedJson){
    return Geometry(
      location: Location.fromJson(parsedJson['location'])
    );
  }
}