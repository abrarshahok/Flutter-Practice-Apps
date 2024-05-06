import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/provider/cart.dart';
import '/provider/order.dart';
import '/widgets/cart_items.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart-screen';

  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    final cartItems = cart.items.values.toList();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Cart'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Card(
            margin: const EdgeInsets.all(10),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total',
                    style: TextStyle(fontSize: 20),
                  ),
                  const Spacer(),
                  Chip(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    label: Text(
                      '\$${cart.totalAmount.toStringAsFixed(2)}',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  OrderButton(cart: cart),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: cart.itemCount,
              itemBuilder: (ctx, index) {
                return CartItems(
                  id: cartItems[index].id,
                  productId: cart.items.keys.toList()[index],
                  title: cartItems[index].title,
                  price: cartItems[index].price,
                  quantity: cartItems[index].quantity,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class OrderButton extends StatefulWidget {
  final Cart cart;
  const OrderButton({super.key, required this.cart});

  @override
  State<OrderButton> createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    final cartItems = cart.items.values.toList();
    return _isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : TextButton(
            onPressed: (widget.cart.totalAmount <= 0 || _isLoading)
                ? null
                : () async {
                    setState(() {
                      _isLoading = true;
                    });
                    await Provider.of<Order>(context, listen: false).addOrder(
                      cartItems: cartItems,
                      total: cart.totalAmount,
                    );

                    setState(() {
                      _isLoading = false;
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Order Successfully added!',
                            textAlign: TextAlign.center,
                          ),
                        ),
                      );
                    });

                    cart.clearCart();
                  },
            child: const Text('ORDER NOW'),
          );
  }
}
