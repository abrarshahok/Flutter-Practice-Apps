import 'package:flutter/material.dart';
import 'package:meal_app/screens/categories_meal_screen.dart';

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

  void _selectedCategory(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(
      CategoriesMealScreen.routeName,
      arguments: {
        'id': id,
        'title': title,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _selectedCategory(context),
      splashColor: Theme.of(context).colorScheme.primary,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              color,
              color.withOpacity(0.8),
            ],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Text(
          title,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
    );
  }
}
