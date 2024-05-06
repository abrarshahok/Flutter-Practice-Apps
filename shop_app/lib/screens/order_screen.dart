import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/widgets/order_items.dart';
import '/provider/order.dart';

class OrderScreen extends StatefulWidget {
  static const routeName = '/order-screen';

  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  Future? _future;

  Future _fetchFutureOrders() {
    return Provider.of<Order>(context, listen: false).fetchOrders();
  }

  @override
  void initState() {
    _future = _fetchFutureOrders();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final orderData = Provider.of<Order>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Orders'),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (snapshot.error != null) {
              return const Center(
                child: Text('An error occured'),
              );
            } else {
              return Consumer<Order>(
                builder: (ctx, orderData, _) => ListView.builder(
                  itemCount: orderData.orders.length,
                  itemBuilder: (ctx, index) {
                    return OrderItems(
                      order: orderData.orders[index],
                    );
                  },
                ),
              );
            }
          }
        },
      ),
    );
  }
}
