import 'package:flutter/material.dart';
import 'package:meal_app_practice/screens/filter_screen.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  Widget cutomListTile({
    required BuildContext ctx,
    required String title,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return ListTile(
      tileColor: Theme.of(ctx).colorScheme.secondary,
      leading: Icon(icon),
      title: Text(title),
      textColor: Colors.white,
      onTap: onTap,
      iconColor: Colors.white,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            height: 160,
            width: double.infinity,
            color: Theme.of(context).colorScheme.primary,
            child: Center(
              child: Text(
                'Cooking Up!',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
          ),
          const Divider(color: Colors.white, height: 2),
          cutomListTile(
            ctx: context,
            title: 'Meals',
            icon: Icons.restaurant_menu,
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
          const Divider(color: Colors.white, height: 2),
          cutomListTile(
            ctx: context,
            title: 'Filters',
            icon: Icons.settings,
            onTap: () {
              Navigator.of(context).pushNamed(FilterScreen.routeName);
            },
          ),
        ],
      ),
    );
  }
}
