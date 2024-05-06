import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/provider/cart.dart';

class CartItems extends StatelessWidget {
  final String id;
  final String productId;
  final String title;
  final num price;
  final int quantity;

  const CartItems({super.key, 
    required this.id,
    required this.productId,
    required this.title,
    required this.price,
    required this.quantity,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(id),
      direction: DismissDirection.endToStart,
      background: Container(
        color: Theme.of(context).colorScheme.error,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        margin: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
        child: const Icon(
          Icons.delete,
          size: 40,
          color: Colors.white,
        ),
      ),
      confirmDismiss: (direction) {
        return showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text('Are you sure?'),
            content: const Text('Do you want to remove this item?'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: const Text('No'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: const Text('Yes'),
              ),
            ],
          ),
        );
      },
      onDismissed: (direction) {
        Provider.of<Cart>(context, listen: false).removeItem(productId);
      },
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25,
            backgroundColor: Theme.of(context).colorScheme.primary,
            child: FittedBox(
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: Text(
                  '\$$price',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
          title: Text(title),
          subtitle: Text('Total: \$${(price * quantity).toStringAsFixed(2)}'),
          trailing: Text('x $quantity'),
        ),
      ),
    );
  }
}
