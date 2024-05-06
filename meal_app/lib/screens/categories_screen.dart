import 'package:flutter/material.dart';
import 'package:meal_app/widgets/categories_item.dart';
import '/data/dummy_data.dart';

class CategoriesScreen extends StatelessWidget {
  static const routeName = '/categories-screen';
  const CategoriesScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: const EdgeInsets.all(15),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
        childAspectRatio: 6 / 5,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
      children: DUMMY_CATEGORIES.map((cts) {
        return CategoriesItem(
          id: cts.id,
          title: cts.title,
          color: cts.color,
        );
      }).toList(),
    );
  }
}
