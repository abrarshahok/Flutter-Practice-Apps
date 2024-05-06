import 'package:flutter/material.dart';
import '../models/meal.dart';
import '/screens/favourite_screen.dart';
import '/screens/categories_screen.dart';

import '../widgets/custom_drawer.dart';

class TabBarScreen extends StatefulWidget {
  final List<Meal> favorite;
  const TabBarScreen({required this.favorite});

  @override
  State<TabBarScreen> createState() => _TabBarScreenState();
}

class _TabBarScreenState extends State<TabBarScreen> {
  List<Map<String, Object>> _pages = [];
  int _selectedPageIndex = 0;
  @override
  void initState() {
    _pages = [
      {
        'page': const CategoriesScreen(),
        'title': 'Categories',
      },
      {
        'page': FavouritesScreen(favoriteMeal: widget.favorite),
        'title': 'Favourites',
      },
    ];
    super.initState();
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_pages[_selectedPageIndex]['title'] as String),
        centerTitle: true,
        elevation: 0,
      ),
      drawer: const CustomDrawer(),
      body: _pages[_selectedPageIndex]['page'] as Widget,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.white,
        currentIndex: _selectedPageIndex,
        onTap: _selectPage,
        type: BottomNavigationBarType.shifting,
        items: [
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).colorScheme.primary,
            icon: const Icon(Icons.category),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).colorScheme.primary,
            icon: const Icon(Icons.favorite),
            label: 'Favourites',
          ),
        ],
      ),
    );
  }
}
