import 'package:flutter/material.dart';
import 'package:meal_app_practice/screens/meal_detail_screen.dart';
import '../models/meal.dart';

class MealItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;
  final int duration;
  final Complexity complexity;
  final Affordability affordability;

  const MealItem({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.duration,
    required this.complexity,
    required this.affordability,
  });

  String get complexityText {
    if (complexity == Complexity.Simple) {
      return 'Simple';
    } else if (complexity == Complexity.Hard) {
      return 'Hard';
    } else if (complexity == Complexity.Challenging) {
      return 'Challenging';
    }
    return 'Unknown';
  }

  String get affordabilityText {
    if (affordability == Affordability.Affordable) {
      return 'Affordable';
    } else if (affordability == Affordability.Pricey) {
      return 'Pricey';
    } else if (affordability == Affordability.Luxurious) {
      return 'Luxurious';
    }
    return 'Unknown';
  }

  void _choosedMeal(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(
      MealDetailScreen.routeName,
      arguments: id,
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _choosedMeal(context),
      child: Card(
        elevation: 5,
        margin: const EdgeInsets.all(15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
          side: BorderSide.none,
        ),
        child: Column(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                  child: Image.network(imageUrl),
                ),
                Positioned(
                  bottom: 20,
                  right: 10,
                  child: Container(
                    width: 300,
                    color: Colors.black54,
                    padding: const EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 20,
                    ),
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                      ),
                      softWrap: true,
                      overflow: TextOverflow.fade,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.schedule,
                        color: Colors.amber,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        '$duration min',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.work,
                        color: Colors.amber,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        complexityText,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.price_change,
                        color: Colors.amber,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        affordabilityText,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ], // Close the "children" list for the Column widget
        ),
      ),
    );
  }
}
