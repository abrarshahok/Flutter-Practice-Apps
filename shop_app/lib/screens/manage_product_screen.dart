import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/screens/edit_product_screen.dart';
import '/widgets/manage_product_items.dart';
import '/provider/product_provider.dart';

class ManageProductScreen extends StatelessWidget {
  static const routeName = '/manage-product-screen';

  const ManageProductScreen({super.key});

  Future<void> _refreshProducts(BuildContext ctx) async {
    await Provider.of<ProductProvider>(ctx, listen: false).fetchProducts(true);
  }

  @override
  Widget build(BuildContext context) {
    // final productData = Provider.of<ProductProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Products'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(EditProductScreen.routeName);
            },
          ),
        ],
      ),
      body: FutureBuilder(
          future: _refreshProducts(context),
          builder: (ctx, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return RefreshIndicator(
                onRefresh: () => _refreshProducts(context),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Consumer<ProductProvider>(
                    builder: (ctx, productData, _) {
                      return ListView.builder(
                        itemCount: productData.items.length,
                        itemBuilder: (ctx, index) {
                          return Column(
                            children: [
                              ManageProductItems(
                                id: productData.items[index].id,
                                title: productData.items[index].title,
                                imageUrl: productData.items[index].imageUrl,
                              ),
                              const Divider(),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ),
              );
            }
          }),
    );
  }
}
