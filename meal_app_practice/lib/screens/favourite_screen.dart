import 'package:flutter/material.dart';
import '/models/meal.dart';
import '/widgets/meal_item.dart';

class FavouritesScreen extends StatelessWidget {
  final List<Meal> favoriteMeal;

  const FavouritesScreen({required this.favoriteMeal});

  @override
  Widget build(BuildContext context) {
    if (favoriteMeal.isEmpty) {
      return Center(
        child: Text(
          'No favourites added yet!',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      );
    } else {
      return ListView.builder(
        itemCount: favoriteMeal.length,
        itemBuilder: (ctx, index) {
          return MealItem(
            id: favoriteMeal[index].id,
            title: favoriteMeal[index].title,
            imageUrl: favoriteMeal[index].imageUrl,
            duration: favoriteMeal[index].duration,
            complexity: favoriteMeal[index].complexity,
            affordability: favoriteMeal[index].affordability,
          );
        },
      );
    }
  }
}
