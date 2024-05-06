import 'dart:io';
import 'package:flutter/material.dart';
import '/models/place.dart';
import '/providers/great_places.dart';
import '/widgets/location_input.dart';
import 'package:provider/provider.dart';
import '/widgets/image_input.dart';

class AddPlacesScreen extends StatefulWidget {
  static const routeName = '/add-place';
  const AddPlacesScreen({super.key});

  @override
  State<AddPlacesScreen> createState() => _AddPlacesScreenState();
}

class _AddPlacesScreenState extends State<AddPlacesScreen> {
  TextEditingController titleController = TextEditingController();
  File? pickedImage;
  PlaceLocation? location;
  void selectImage(File image) {
    pickedImage = image;
  }

  void selectPlace(double lat, double lng) {
    location = PlaceLocation(longitude: lng, latitude: lat);
  }

  void savePlace() {
    if (titleController.text.isEmpty ||
        pickedImage == null ||
        location == null) {
      return;
    }
    Provider.of<GreatPlaces>(context, listen: false).addPlace(
      titleController.text,
      pickedImage!,
      location!,
    );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add a New Place'),
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    TextField(
                      decoration: const InputDecoration(labelText: 'Title'),
                      controller: titleController,
                    ),
                    const SizedBox(height: 10),
                    ImageInput(selectImage),
                    const SizedBox(height: 10),
                    LocationInput(selectPlace),
                  ],
                ),
              ),
            ),
          ),
          ElevatedButton.icon(
            onPressed: savePlace,
            icon: const Icon(Icons.add),
            label: const Text('Add Place'),
            style: ElevatedButton.styleFrom(
              elevation: 0,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              backgroundColor: Theme.of(context).colorScheme.secondary,
              shape: const BeveledRectangleBorder(),
            ),
          ),
        ],
      ),
    );
  }
}
