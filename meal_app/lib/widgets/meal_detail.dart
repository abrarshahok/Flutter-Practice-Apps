import 'package:flutter/material.dart';

class MealDetail extends StatelessWidget {
  final String imageUrl;
  final List<String> ingredients;
  final List<String> steps;

  const MealDetail({
    super.key,
    required this.imageUrl,
    required this.ingredients,
    required this.steps,
  });

  Widget setSectionTitle({required BuildContext ctx, required String title}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        title,
        style: Theme.of(ctx).textTheme.titleMedium,
      ),
    );
  }

  Widget sectionDecoration({required Widget child}) {
    return Container(
      height: 180,
      width: 350,
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey),
      ),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 300,
            width: double.infinity,
            child: Image.network(imageUrl, fit: BoxFit.cover),
          ),
          setSectionTitle(ctx: context, title: 'Ingredients'),
          sectionDecoration(
            child: ListView.builder(
              itemCount: ingredients.length,
              itemBuilder: (ctx, index) {
                return Card(
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 10,
                    ),
                    child: Text(
                      ingredients[index],
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                );
              },
            ),
          ),
          setSectionTitle(ctx: context, title: 'Steps'),
          sectionDecoration(
            child: ListView.builder(
              itemCount: steps.length,
              itemBuilder: ((ctx, index) {
                return Column(
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        child: Text(
                          '\#${index + 1}',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                      title: Text(
                        steps[index],
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                    const Divider(color: Colors.grey),
                  ],
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
