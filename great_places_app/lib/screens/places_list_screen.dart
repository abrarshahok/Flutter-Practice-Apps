import 'package:flutter/material.dart';
import '/providers/great_places.dart';
import '/screens/add_places_screen.dart';
import 'package:provider/provider.dart';

class PlacesListScreen extends StatelessWidget {
  const PlacesListScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Places'),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(
                AddPlacesScreen.routeName,
              );
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: FutureBuilder(
        future:
            Provider.of<GreatPlaces>(context, listen: false).fetchPlacesData(),
        builder: (context, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Consumer<GreatPlaces>(
                child: const Center(
                  child: Text('No places added yet, please add some!'),
                ),
                builder: (context, greatPlace, text) =>
                    greatPlace.places.isEmpty
                        ? text!
                        : ListView.builder(
                            itemCount: greatPlace.places.length,
                            itemBuilder: (context, index) => Card(
                              margin: const EdgeInsets.all(10),
                              elevation: 5,
                              child: ListTile(
                                leading: CircleAvatar(
                                  backgroundImage: FileImage(
                                    greatPlace.places[index].image,
                                  ),
                                ),
                                title: Text(
                                  greatPlace.places[index].title,
                                ),
                                subtitle: Text(
                                  greatPlace.places[index].location!.address,
                                ),
                                onTap: () {},
                              ),
                            ),
                          ),
              ),
      ),
    );
  }
}
