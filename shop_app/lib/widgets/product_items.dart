import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/provider/auth.dart';
import '/provider/cart.dart';
import '../provider/product.dart';
import '/screens/product_detail_screen.dart';

class ProductItems extends StatelessWidget {
  const ProductItems({super.key});

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);
    final authData = Provider.of<Auth>(context, listen: false);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          leading: Consumer<Product>(
            builder: (ctx, product, child) => IconButton(
              color: Theme.of(context).colorScheme.secondary,
              icon: Icon(
                product.isFavourite ? Icons.favorite : Icons.favorite_border,
              ),
              onPressed: () {
                product.toggleFavourite(
                  authToken: authData.token!,
                  userId: authData.userId!,
                );
              },
            ),
          ),
          title: Text(
            product.title,
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
            color: Theme.of(context).colorScheme.secondary,
            icon: const Icon(
              Icons.shopping_cart,
            ),
            onPressed: () {
              cart.addItems(
                productId: product.id,
                title: product.title,
                price: product.price,
              );
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('Item added to cart!'),
                  duration: const Duration(seconds: 2),
                  action: SnackBarAction(
                    label: 'UNDO',
                    onPressed: () {
                      cart.removeSingleItem(product.id);
                    },
                  ),
                ),
              );
            },
          ),
        ),
        child: GestureDetector(
          child: Hero(
            tag: product.id,
            child: FadeInImage(
              placeholder: const AssetImage(
                'assets/images/product-placeholder.png',
              ),
              image: NetworkImage(product.imageUrl),
              fit: BoxFit.cover,
            ),
          ),
          onTap: () {
            Navigator.of(context).pushNamed(
              ProductDetailScreen.routeName,
              arguments: product.id,
            );
          },
        ),
      ),
    );
  }
}
