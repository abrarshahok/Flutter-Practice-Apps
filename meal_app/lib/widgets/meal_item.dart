import 'package:flutter/material.dart';
import 'package:meal_app/screens/meal_detail_screen.dart';
import '/models/meal.dart';

class MealItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;
  final int duration;
  final Complexity complexity;
  final Affordability affordability;

  const MealItem({
    super.key,
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

  List<Widget> _customRow({required IconData icon, required String text}) {
    return [
      Icon(icon, color: Colors.amber),
      const SizedBox(width: 10),
      Text(text),
    ];
  }

  void _selectedMeal(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(
      MealDetailScreen.routeName,
      arguments: id,
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _selectedMeal(context),
      child: Card(
        elevation: 5,
        margin: const EdgeInsets.all(5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
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
                  child: Image.network(
                    imageUrl,
                    height: 250,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  right: 10,
                  bottom: 20,
                  child: Container(
                    width: 300,
                    color: Colors.black54,
                    padding: const EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 20,
                    ),
                    child: Text(
                      title,
                      softWrap: true,
                      overflow: TextOverflow.fade,
                      style: const TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: _customRow(
                      icon: Icons.schedule,
                      text: '$duration mins',
                    ),
                  ),
                  Row(
                    children: _customRow(
                      icon: Icons.work,
                      text: complexityText,
                    ),
                  ),
                  Row(
                    children: _customRow(
                      icon: Icons.attach_money,
                      text: affordabilityText,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
