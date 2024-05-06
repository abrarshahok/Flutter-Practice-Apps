import 'package:flutter/material.dart';
import 'package:meal_app/widgets/meal_item.dart';
import '../models/meal.dart';

class CategoriesMealScreen extends StatefulWidget {
  static const routeName = '/categories-meal-screen';
  final List<Meal> availableMeals;
  const CategoriesMealScreen({super.key, required this.availableMeals});

  @override
  State<CategoriesMealScreen> createState() => _CategoriesMealScreenState();
}

class _CategoriesMealScreenState extends State<CategoriesMealScreen> {
  late List<Meal> categoryMeal;
  late String categoryTitle;
  bool loadInitData = false;

  //update meals
  @override
  void didChangeDependencies() {
    if (!loadInitData) {
      final categoryArgs =
          ModalRoute.of(context)?.settings.arguments as Map<String, String>;
      final categoryId = categoryArgs['id'] as String;
      categoryTitle = categoryArgs['title'] as String;
      categoryMeal = widget.availableMeals.where((meal) {
        return meal.categories.contains(categoryId);
      }).toList();
      loadInitData = true;
    }
    super.didChangeDependencies();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
      ),
      body: ListView.builder(
        itemCount: categoryMeal.length,
        itemBuilder: ((ctx, index) {
          return MealItem(
            id: categoryMeal[index].id,
            title: categoryMeal[index].title,
            imageUrl: categoryMeal[index].imageUrl,
            duration: categoryMeal[index].duration,
            complexity: categoryMeal[index].complexity,
            affordability: categoryMeal[index].affordability,
          );
        }),
      ),
    );
  }
}
