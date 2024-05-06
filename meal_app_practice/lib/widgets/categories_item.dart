import 'package:flutter/material.dart';
import 'package:meal_app_practice/screens/meal_screen.dart';

class CategoriesItem extends StatelessWidget {
  final String id;
  final String title;
  final Color color;
  const CategoriesItem({
    super.key,
    required this.id,
    required this.title,
    required this.color,
  });

  void selectCategory(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(
      MealScreen.routeName,
      arguments: {
        'id': id,
        'title': title,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => selectCategory(context),
      borderRadius: BorderRadius.circular(15),
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(
            colors: [
              color,
              color.withOpacity(0.8),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
      ),
    );
  }
}
