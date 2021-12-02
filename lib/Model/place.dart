import 'package:togetor_app/Model/geometry.dart';

class Place {
  final String placeId;
  final Geometry geometry;
  final String name;
  final String vicinity;
  final formattedAddress;
  final double lat;
  final double lng;
  
  Place({this.geometry, this.name, this.vicinity, this.formattedAddress, this.lng, this.lat,this.placeId});
  
  factory Place.fromJson(Map<String, dynamic> parsedJson){
    return Place(
      placeId: parsedJson['place_id'],
      geometry: Geometry.fromJson(parsedJson['geometry']),
      name: parsedJson['name'],
      vicinity: parsedJson['vicinity'],
      formattedAddress: parsedJson['formatted_address'],
      lat: parsedJson['geometry']['location']['lat'],
      lng: parsedJson['geometry']['location']['lng']
    );
  }


}