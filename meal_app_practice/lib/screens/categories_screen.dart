import 'package:flutter/material.dart';
import '/widgets/categories_item.dart';
import '/data/dummy_data.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});
  static const routeName = '/categories-screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView(
        padding: const EdgeInsets.all(15),
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 6 / 5,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        children: DUMMY_CATEGORIES
            .map(
              (cts) => CategoriesItem(
                id: cts.id,
                title: cts.title,
                color: cts.color,
              ),
            )
            .toList(),
      ),
    );
  }
}
