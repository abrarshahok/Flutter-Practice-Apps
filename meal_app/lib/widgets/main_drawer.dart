import 'package:flutter/material.dart';
import '/screens/filters_screen.dart';

class MainDrawer extends StatelessWidget {
  Widget buildListTile({
    required BuildContext ctx,
    required String title,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return ListTile(
      onTap: onTap,
      tileColor: Theme.of(ctx).colorScheme.secondary,
      leading: Icon(
        icon,
        size: 35,
        color: Colors.white,
      ),
      title: Text(
        title,
        style: Theme.of(ctx).textTheme.titleLarge,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            height: 220,
            width: double.infinity,
            color: Theme.of(context).colorScheme.primary,
            child: const Center(
              child: Text(
                'Cooking Up!',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          // const Divider(height: 2),
          // buildListTile(
          //   ctx: context,
          //   title: 'Meals',
          //   icon: Icons.restaurant_menu,
          //   onTap: () {
          //     Navigator.of(context).pushReplacementNamed('/');
          //   },
          // ),
          const Divider(height: 2),
          buildListTile(
            ctx: context,
            title: 'Set Filters',
            icon: Icons.settings,
            onTap: () {
              Navigator.of(context).pushNamed(FiltersScreen.routeName);
            },
          ),
        ],
      ),
    );
  }
}
