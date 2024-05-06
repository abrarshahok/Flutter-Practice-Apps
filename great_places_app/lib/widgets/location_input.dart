import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:great_places_app/models/place.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationInput extends StatefulWidget {
  final Function onSelectPlace;
  const LocationInput(this.onSelectPlace);
  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  PlaceLocation? currentLocation;
  LatLng? currentPosition;
  String? currentAddress;
  void getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    final locationData = await Geolocator.getCurrentPosition();
    setState(() {
      currentLocation = PlaceLocation(
        longitude: locationData.longitude,
        latitude: locationData.latitude,
      );
      currentPosition = LatLng(
        currentLocation!.latitude,
        currentLocation!.longitude,
      );
    });
  }

  void setMarker(LatLng location) {
    setState(() {
      currentPosition = location;
      widget.onSelectPlace(location.latitude, location.longitude);
    });
  }

  @override
  void initState() {
    getCurrentLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 500,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Colors.grey,
            ),
          ),
          child: currentLocation == null
              ? const Text('No Location selected')
              : GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: LatLng(
                      currentLocation!.latitude,
                      currentLocation!.longitude,
                    ),
                  ),
                  onTap: setMarker,
                  markers: {
                    Marker(
                      markerId: const MarkerId('m1'),
                      position: currentPosition ?? const LatLng(0.0, 0.0),
                    ),
                  },
                ),
        ),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceAround,
        //   children: [
        //     TextButton.icon(
        //       onPressed: getCurrentLocation,
        //       icon: const Icon(Icons.location_on_rounded),
        //       label: Text(
        //         'Current Location',
        //         style: TextStyle(
        //           color: Theme.of(context).colorScheme.primary,
        //         ),
        //       ),
        //     ),
        //     TextButton.icon(
        //       onPressed: () {},
        //       icon: const Icon(Icons.map_rounded),
        //       label: Text(
        //         'Select on Map',
        //         style: TextStyle(
        //           color: Theme.of(context).colorScheme.primary,
        //         ),
        //       ),
        //     ),
        //   ],
        // ),
      ],
    );
  }
}
