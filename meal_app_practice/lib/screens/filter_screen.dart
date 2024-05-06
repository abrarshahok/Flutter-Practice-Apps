import 'package:flutter/material.dart';

class FilterScreen extends StatefulWidget {
  static const routeName = '/filter-screen';
  final Map<String, bool> currentFilters;
  final Function saveFilters;

  const FilterScreen({
    required this.currentFilters,
    required this.saveFilters,
  });
  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  bool _isGlutenFree = false;
  bool _isLactoseFree = false;
  bool _isVegan = false;
  bool _isVegetarian = false;

  @override
  void initState() {
    _isGlutenFree = widget.currentFilters['gluten']!;
    _isLactoseFree = widget.currentFilters['lactose']!;
    _isVegan = widget.currentFilters['vegan']!;
    _isVegetarian = widget.currentFilters['vegeterian']!;
    super.initState();
  }

  Widget cutomListTile({
    required bool value,
    required String title,
    required String subTitle,
    required Function(bool) changedValue,
  }) {
    return SwitchListTile(
      value: value,
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium,
      ),
      subtitle: Text(
        subTitle,
        style: Theme.of(context).textTheme.bodySmall,
      ),
      onChanged: changedValue,
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
              final choosedFilters = {
                'gluten': _isGlutenFree,
                'lactose': _isLactoseFree,
                'vegan': _isVegan,
                'vegeterian': _isVegetarian,
              };
              widget.saveFilters(choosedFilters);
            },
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      body: ListView(
        children: [
          cutomListTile(
            value: _isGlutenFree,
            title: 'Gluten Free',
            subTitle: 'only include gluten free meals',
            changedValue: (val) {
              setState(() {
                _isGlutenFree = val;
              });
            },
          ),
          const SizedBox(height: 10),
          cutomListTile(
            value: _isLactoseFree,
            title: 'Lactose Free',
            subTitle: 'only include lactose free meals',
            changedValue: (val) {
              setState(() {
                _isLactoseFree = val;
              });
            },
          ),
          const SizedBox(height: 10),
          cutomListTile(
            value: _isVegan,
            title: 'Vegan',
            subTitle: 'only include vegan meals',
            changedValue: (val) {
              setState(() {
                _isVegan = val;
              });
            },
          ),
          const SizedBox(height: 10),
          cutomListTile(
            value: _isVegetarian,
            title: 'Vegeterian',
            subTitle: 'only include vegeterian meals',
            changedValue: (val) {
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
