import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:togetor_app/Constants/constants.dart';
import 'package:togetor_app/Model/place.dart';
import 'package:togetor_app/Model/place_search.dart';


class PlaceService {
  final key = API_KEY;

  Future<List<PlaceSearch>> getAutocomplete(String search) async {
    var url = Uri.parse('https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$search&language=ko&components=country:kr&types=establishment&key=$key');

    var response = await http.get(url);
    var json = convert.jsonDecode(response.body);
    var jsonResults = json['predictions'] as List;
    return jsonResults.map((place) => PlaceSearch.fromJson(place)).toList();

  }

  Future<Place> getPlace(String placeId) async {
    var url = Uri.parse('https://maps.googleapis.com/maps/api/place/details/json?key=$key&place_id=$placeId&language=ko');

    var response = await http.get(url);
    var json = convert.jsonDecode(response.body);
    var jsonResults = json['result'] as Map<String, dynamic>;
    final Place place = Place.fromJson(jsonResults);
    return place;
  }


}
