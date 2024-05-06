import 'package:flutter/material.dart';
import '/data/dummy_data.dart';
import '/models/meal.dart';
import '/screens/categories_meal_screen.dart';
import '/screens/filters_screen.dart';
import '/screens/meal_detail_screen.dart';
import '/screens/tabs_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Meal> _availableMeals = DUMMY_MEALS;
  List<Meal> _favouriteMeals = [];

  void _toggleFavourites(String mealId) {
    final existingIndex = _favouriteMeals.indexWhere(
      (meal) => meal.id == mealId,
    );
    if (existingIndex >= 0) {
      setState(() {
        _favouriteMeals.removeAt(existingIndex);
      });
    } else {
      setState(() {
        _favouriteMeals.add(
          DUMMY_MEALS.firstWhere((meal) => meal.id == mealId),
        );
      });
    }
  }

  bool _isFavourite(String mealId) {
    return _favouriteMeals.any((meal) => meal.id == mealId);
  }

  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegeterian': false,
  };

  void _setFilters(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData;
      _availableMeals = DUMMY_MEALS.where((meal) {
        if (_filters['gluten']! && !meal.isGlutenFree) {
          return false;
        }
        if (_filters['lactose']! && !meal.isLactoseFree) {
          return false;
        }
        if (_filters['vegan']! && !meal.isVegan) {
          return false;
        }
        if (_filters['vegeterian']! && !meal.isVegetarian) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Meal App',
      theme: ThemeData(
        fontFamily: 'Raleway',
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.deepPurple,
          accentColor: Colors.amber[600],
        ),
        textTheme: ThemeData.light().textTheme.copyWith(
              titleLarge: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              titleMedium: const TextStyle(
                fontFamily: 'RobotoCondensed',
                color: Colors.black,
                fontSize: 25,
              ),
              bodyLarge: const TextStyle(
                color: Colors.white,
                fontSize: 17,
              ),
              bodyMedium: const TextStyle(
                color: Colors.black,
                fontSize: 15,
              ),
            ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => TabsScreen(favouriteMeals: _favouriteMeals),
        CategoriesMealScreen.routeName: (context) => CategoriesMealScreen(
              availableMeals: _availableMeals,
            ),
        MealDetailScreen.routeName: (context) => MealDetailScreen(
              addToFavourite: _toggleFavourites,
              isFavourite: _isFavourite,
            ),
        FiltersScreen.routeName: (context) => FiltersScreen(
              currentFilters: _filters,
              saveFilters: _setFilters,
            ),
      },
    );
  }
}
