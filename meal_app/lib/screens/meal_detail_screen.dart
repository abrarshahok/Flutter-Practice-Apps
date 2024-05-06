import 'package:flutter/material.dart';
import 'package:meal_app/data/dummy_data.dart';
import 'package:meal_app/widgets/meal_detail.dart';

class MealDetailScreen extends StatelessWidget {
  static const routeName = '/meal-detail-screen';
  final Function addToFavourite;
  final Function isFavourite;
  const MealDetailScreen({
    required this.addToFavourite,
    required this.isFavourite,
  });

  @override
  Widget build(BuildContext context) {
    final mealId = ModalRoute.of(context)?.settings.arguments as String;
    final selectedMeal = DUMMY_MEALS.firstWhere((meal) => meal.id == mealId);
    return Scaffold(
      appBar: AppBar(
        title: Text(selectedMeal.title),
      ),
      body: MealDetail(
        imageUrl: selectedMeal.imageUrl,
        ingredients: selectedMeal.ingredients,
        steps: selectedMeal.steps,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => addToFavourite(mealId),
        child: isFavourite(mealId)
            ? const Icon(Icons.favorite)
            : const Icon(Icons.favorite_border_outlined),
      ),
    );
  }
}
