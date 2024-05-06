import 'package:flutter/material.dart';
import 'package:meal_app_practice/screens/categories_screen.dart';
import 'package:meal_app_practice/screens/filter_screen.dart';
import '/screens/meal_detail_screen.dart';
import '/screens/meal_screen.dart';
import 'data/dummy_data.dart';
import 'models/meal.dart';
import 'screens/tabbar_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Meal> _availableMeal = DUMMY_MEALS;
  List<Meal> favoriteMeal = [];

  Map<String, bool> _fiters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegeterian': false,
  };

  void setFilters(Map<String, bool> filterData) {
    setState(() {
      _fiters = filterData;
      _availableMeal = DUMMY_MEALS.where((meal) {
        if (_fiters['gluten']! && !meal.isGlutenFree) {
          return false;
        }
        if (_fiters['lactose']! && !meal.isLactoseFree) {
          return false;
        }
        if (_fiters['vegan']! && !meal.isVegan) {
          return false;
        }
        if (_fiters['vegeterian']! && !meal.isVegetarian) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  bool isFavourite(String id) {
    return favoriteMeal.any((meal) => meal.id == id);
  }

  void addToFavourite(String mealId) {
    final existingIndex = favoriteMeal.indexWhere((meal) => meal.id == mealId);
    if (existingIndex >= 0) {
      setState(() {
        favoriteMeal.removeAt(existingIndex);
      });
    } else {
      setState(() {
        favoriteMeal.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meal App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Raleway',
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.purple,
          accentColor: Colors.amber,
        ),
        textTheme: ThemeData.light().textTheme.copyWith(
              titleLarge: const TextStyle(
                color: Colors.white,
                fontSize: 25,
              ),
              titleMedium: const TextStyle(
                color: Colors.black,
                fontSize: 20,
              ),
              bodyLarge: const TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
              bodySmall: const TextStyle(
                color: Colors.black54,
                fontSize: 15,
              ),
            ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => TabBarScreen(favorite: favoriteMeal),
        MealScreen.routeName: (context) => MealScreen(
              availableMeal: _availableMeal,
            ),
        MealDetailScreen.routeName: (context) => MealDetailScreen(
              isFavourite: isFavourite,
              toggleFavourites: addToFavourite,
            ),
        FilterScreen.routeName: (context) => FilterScreen(
              currentFilters: _fiters,
              saveFilters: setFilters,
            ),
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) => const CategoriesScreen(),
        );
      },
    );
  }
}
