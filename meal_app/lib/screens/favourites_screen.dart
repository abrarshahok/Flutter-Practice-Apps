import 'package:flutter/material.dart';
import 'package:meal_app/models/meal.dart';

import '../widgets/meal_item.dart';

class FavouritesScreen extends StatelessWidget {
  static const routeName = '/favourite-meal-screen';
  final List<Meal> favouriteMeals;
  const FavouritesScreen({required this.favouriteMeals});

  @override
  Widget build(BuildContext context) {
    if (favouriteMeals.isEmpty) {
      return const Center(
        child: Text('You have no favourites yet start adding some!'),
      );
    } else {
      return ListView.builder(
        itemCount: favouriteMeals.length,
        itemBuilder: ((ctx, index) {
          return MealItem(
            id: favouriteMeals[index].id,
            title: favouriteMeals[index].title,
            imageUrl: favouriteMeals[index].imageUrl,
            duration: favouriteMeals[index].duration,
            complexity: favouriteMeals[index].complexity,
            affordability: favouriteMeals[index].affordability,
          );
        }),
      );
    }
  }
}
