import 'dart:io';
import 'package:flutter/foundation.dart';
import '/helpers/db_helper.dart';
import '/models/place.dart';

class GreatPlaces with ChangeNotifier {
  final myTable = 'user_places';
  List<Place> _places = [];
  List<Place> get places {
    return [..._places];
  }

  void addPlace(
      String pickedTitle, File pickedImage, PlaceLocation pickedLocation) {
    final newPlace = Place(
      id: DateTime.now().toString(),
      title: pickedTitle,
      location: pickedLocation,
      image: pickedImage,
    );
    _places.add(newPlace);
    notifyListeners();
    DBHelper.insert(
      table: myTable,
      data: {
        'id': newPlace.id,
        'title': newPlace.title,
        'image': newPlace.image.path,
        'loc_lat': newPlace.location!.latitude,
        'loc_lng': newPlace.location!.longitude,
        'address': newPlace.location!.address,
      },
    );
  }

  Future<void> fetchPlacesData() async {
    final placesData = await DBHelper.getData(table: myTable);
    _places = placesData
        .map((place) => Place(
              id: place['id'],
              title: place['title'],
              image: File(place['image']),
              location: PlaceLocation(
                longitude: place['loc_lng'],
                latitude: place['loc_lat'],
                address: place['address'],
              ),
            ))
        .toList();
    notifyListeners();
  }
}
