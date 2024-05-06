import 'package:flutter/material.dart';
import 'package:meal_app_practice/widgets/meal_item.dart';
import '/models/meal.dart';

class MealScreen extends StatefulWidget {
  static const routeName = '/meal-items';
  final List<Meal> availableMeal;
  const MealScreen({super.key, required this.availableMeal});

  @override
  State<MealScreen> createState() => _MealScreenState();
}

class _MealScreenState extends State<MealScreen> {
  late List<Meal> _mealItems;
  late String categoryTitle;
  bool loadInitData = false;
  @override
  void didChangeDependencies() {
    if (!loadInitData) {
      final categoryArgs =
          ModalRoute.of(context)?.settings.arguments as Map<String, String>;
      categoryTitle = categoryArgs['title'] as String;
      final categoryId = categoryArgs['id'] as String;
      _mealItems = widget.availableMeal.where((meal) {
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
        itemCount: _mealItems.length,
        itemBuilder: ((ctx, index) {
          return MealItem(
            id: _mealItems[index].id,
            title: _mealItems[index].title,
            imageUrl: _mealItems[index].imageUrl,
            duration: _mealItems[index].duration,
            complexity: _mealItems[index].complexity,
            affordability: _mealItems[index].affordability,
          );
        }),
      ),
    );
  }
}
