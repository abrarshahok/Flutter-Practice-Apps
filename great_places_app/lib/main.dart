import 'package:flutter/material.dart';
import '/screens/add_places_screen.dart';
import '/providers/great_places.dart';
import 'package:provider/provider.dart';
import '/screens/places_list_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => GreatPlaces(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Great Places',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Colors.indigo,
            accentColor: Colors.amber,
          ),
        ),
        home: const PlacesListScreen(),
        routes: {
          AddPlacesScreen.routeName: (context) => const AddPlacesScreen(),
        },
      ),
    );
  }
}
