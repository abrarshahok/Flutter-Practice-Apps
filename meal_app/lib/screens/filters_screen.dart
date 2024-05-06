import 'package:flutter/material.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = '/filters-screen';
  final Map<String, bool> currentFilters;
  final Function(Map<String, bool>) saveFilters;

  const FiltersScreen({
    required this.currentFilters,
    required this.saveFilters,
  });

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool _isGlutenFree = false;
  bool _isVegan = false;
  bool _isVegetarian = false;
  bool _isLactoseFree = false;

  @override
  void initState() {
    _isGlutenFree = widget.currentFilters['gluten']!;
    _isLactoseFree = widget.currentFilters['lactose']!;
    _isVegan = widget.currentFilters['vegan']!;
    _isVegetarian = widget.currentFilters['vegeterian']!;
    super.initState();
  }

  Widget buildCustomSwitchTile({
    required String title,
    required String subtitle,
    required bool value,
    required Function(bool) onChanged,
  }) {
    return SwitchListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      value: value,
      onChanged: onChanged,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Set Filters'),
        actions: [
          IconButton(
            onPressed: () {
              final selectedFilters = {
                'gluten': _isGlutenFree,
                'lactose': _isLactoseFree,
                'vegan': _isVegan,
                'vegeterian': _isVegetarian,
              };
              widget.saveFilters(selectedFilters);
            },
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      body: ListView(
        children: [
          const SizedBox(height: 20),
          buildCustomSwitchTile(
            title: 'Gluten Free',
            subtitle: 'only include gluten free meals',
            value: _isGlutenFree,
            onChanged: (val) {
              setState(() {
                _isGlutenFree = val;
              });
            },
          ),
          const SizedBox(height: 20),
          buildCustomSwitchTile(
            title: 'Lactose Free',
            subtitle: 'only include lactose free meals',
            value: _isLactoseFree,
            onChanged: (val) {
              setState(() {
                _isLactoseFree = val;
              });
            },
          ),
          const SizedBox(height: 20),
          buildCustomSwitchTile(
            title: 'Vegan',
            subtitle: 'only include Vegan meals',
            value: _isVegan,
            onChanged: (val) {
              setState(() {
                _isVegan = val;
              });
            },
          ),
          const SizedBox(height: 20),
          buildCustomSwitchTile(
            title: 'Vegeterian',
            subtitle: 'only include vegeterian meals',
            value: _isVegetarian,
            onChanged: (val) {
              setState(() {
                _isVegetarian = val;
              });
            },
          ),
        ],
      ),
    );
  }
}
