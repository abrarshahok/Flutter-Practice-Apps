import 'package:flutter/material.dart';
import '/models/meal.dart';
import '../widgets/main_drawer.dart';
import '/screens/favourites_screen.dart';
import '/screens/categories_screen.dart';

class TabsScreen extends StatefulWidget {
  final List<Meal> favouriteMeals;

  const TabsScreen({required this.favouriteMeals});
  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  List<Map<String, Object>> _pages = [];

  int _currentPageIndex = 0;
  @override
  void initState() {
    _pages = [
      {
        'title': 'Categories',
        'page': const CategoriesScreen(),
      },
      {
        'title': 'Favourites',
        'page': FavouritesScreen(favouriteMeals: widget.favouriteMeals),
      },
    ];
    super.initState();
  }

  void _changePageIndex(int index) {
    setState(() {
      _currentPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_pages[_currentPageIndex]['title'] as String),
        centerTitle: true,
      ),
      drawer: MainDrawer(),
      body: _pages[_currentPageIndex]['page'] as Widget,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _changePageIndex,
        currentIndex: _currentPageIndex,
        backgroundColor: Theme.of(context).colorScheme.primary,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favourites',
          ),
        ],
      ),
    );
  }
}
