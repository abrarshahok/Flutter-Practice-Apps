import 'package:flutter/material.dart';
import '/data/dummy_data.dart';
import '/widgets/meal_detail.dart';

class MealDetailScreen extends StatefulWidget {
  static const routeName = '/meal-detail-screen';
  final Function isFavourite;
  final Function toggleFavourites;

  const MealDetailScreen({
    required this.isFavourite,
    required this.toggleFavourites,
  });
  @override
  State<MealDetailScreen> createState() => _MealDetailScreenState();
}

class _MealDetailScreenState extends State<MealDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final mealId = ModalRoute.of(context)?.settings.arguments as String;
    final selectedMeal = DUMMY_MEALS.firstWhere((meal) => meal.id == mealId);
    final mealTitle = selectedMeal.title;
    final imageUrl = selectedMeal.imageUrl;
    final ingredients = selectedMeal.ingredients;
    final steps = selectedMeal.steps;

    return Scaffold(
      appBar: AppBar(
        title: Text(mealTitle),
      ),
      body: MealDetail(
        id: mealId,
        title: mealTitle,
        imageUrl: imageUrl,
        ingredients: ingredients,
        steps: steps,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => widget.toggleFavourites(mealId),
        child: widget.isFavourite(mealId)
            ? const Icon(Icons.favorite)
            : const Icon(Icons.favorite_border),
      ),
    );
  }
}
