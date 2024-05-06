import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/provider/product_provider.dart';
import '/widgets/product_items.dart';

class ProductsGrid extends StatefulWidget {
  final bool showFavourites;
  const ProductsGrid({super.key, required this.showFavourites});

  @override
  State<ProductsGrid> createState() => _ProductsGridState();
}

class _ProductsGridState extends State<ProductsGrid> {
  Future? futureProducts;
  Future fetchFutureProducts() {
    return Provider.of<ProductProvider>(context, listen: false).fetchProducts();
  }

  @override
  void initState() {
    futureProducts = fetchFutureProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<ProductProvider>(context);
    final loadedProducts =
        widget.showFavourites ? productsData.favItems : productsData.items;
    return FutureBuilder(
      future: futureProducts,
      builder: (ctxt, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          if (snapshot.error != null) {
            return const Center(
              child: Text('An error occured!'),
            );
          }
          return GridView.builder(
            padding: const EdgeInsets.all(15),
            itemCount: loadedProducts.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 3 / 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemBuilder: (ctx, index) {
              return ChangeNotifierProvider.value(
                value: loadedProducts[index],
                child: const ProductItems(),
              );
            },
          );
        }
      },
    );
  }
}
