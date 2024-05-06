import 'package:flutter/material.dart';

class MealDetail extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;
  final List<String> ingredients;
  final List<String> steps;

  const MealDetail({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.ingredients,
    required this.steps,
  });

  Widget customText({
    required BuildContext ctx,
    required String title,
  }) {
    return Text(
      title,
      style: Theme.of(ctx).textTheme.titleMedium,
    );
  }

  Widget customSection({required Widget child}) {
    return Container(
      height: 200,
      width: 400,
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: Colors.grey,
        ),
      ),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ClipRRect(
            child: Image.network(imageUrl),
          ),
          const SizedBox(height: 20),
          customText(
            ctx: context,
            title: 'Ingredients',
          ),
          const SizedBox(height: 20),
          customSection(
            child: ListView.builder(
              itemCount: ingredients.length,
              itemBuilder: ((ctx, index) {
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  color: Colors.white,
                  elevation: 5,
                  margin:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      ingredients[index],
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                );
              }),
            ),
          ),
          const SizedBox(height: 20),
          customText(
            ctx: context,
            title: 'Steps',
          ),
          const SizedBox(height: 20),
          customSection(
            child: ListView.builder(
              itemCount: steps.length,
              itemBuilder: (ctx, index) {
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  elevation: 5,
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Theme.of(context).colorScheme.secondary,
                      child: Text(
                        '${index + 1}',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                    title: Text(
                      steps[index],
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
