import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/provider/auth.dart';
import '/screens/product_overview_screen.dart';
import '/screens/manage_product_screen.dart';
import '/screens/order_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: const Text('Hello There!'),
            automaticallyImplyLeading: false,
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.shop, size: 25),
            title: const Text(
              'Shop',
              style: TextStyle(fontSize: 18),
            ),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(
                ProductOverviewScreen.routeName,
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.payment, size: 25),
            title: const Text(
              'Orders',
              style: TextStyle(fontSize: 18),
            ),
            onTap: () {
              Navigator.of(context).pushNamed(
                OrderScreen.routeName,
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.edit, size: 25),
            title: const Text(
              'Manage Products',
              style: TextStyle(fontSize: 18),
            ),
            onTap: () {
              Navigator.of(context).pushNamed(ManageProductScreen.routeName);
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout, size: 25),
            title: const Text(
              'Logout',
              style: TextStyle(fontSize: 18),
            ),
            onTap: () {
              Provider.of<Auth>(context, listen: false).logout();
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
          const Divider(),
        ],
      ),
    );
  }
}
