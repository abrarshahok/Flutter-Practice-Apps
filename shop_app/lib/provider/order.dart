import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '/provider/cart.dart';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem({
    required this.id,
    required this.amount,
    required this.products,
    required this.dateTime,
  });
}

class Order with ChangeNotifier {
  final String authToken;
  final String userId;
  Order(this.authToken, this.userId, this._orders);

  List<OrderItem> _orders = [];
  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> fetchOrders() async {
    final url =
        "https://shop-app-20-default-rtdb.firebaseio.com/orders/$userId.json?auth=$authToken";
    final response = await http.get(Uri.parse(url));
    final checkData = json.decode(response.body);
    if (checkData == null) {
      return;
    }
    Map<String, dynamic> fetchedData = checkData;
    List<OrderItem> loadedItems = [];
    fetchedData.forEach((orderId, orderData) {
      loadedItems.add(
        OrderItem(
          id: orderId,
          amount: orderData['amount'],
          dateTime: DateTime.parse(orderData['dateTime']),
          products: (orderData['products'] as List<dynamic>)
              .map((cartProducts) => CartItem(
                    id: cartProducts['id'],
                    title: cartProducts['title'],
                    price: cartProducts['price'],
                    quantity: cartProducts['quantity'],
                  ))
              .toList(),
        ),
      );
    });
    _orders = loadedItems.reversed.toList();
    notifyListeners();
  }

  Future<void> addOrder({
    required List<CartItem> cartItems,
    required double total,
  }) async {
    final url =
        "https://shop-app-20-default-rtdb.firebaseio.com/orders/$userId.json?auth=$authToken";
    final currentDateTime = DateTime.now();
    try {
      final response = await http.post(
        Uri.parse(url),
        body: json.encode(
          {
            'amount': total,
            'dateTime': currentDateTime.toIso8601String(),
            'products': cartItems
                .map((cartProduct) => {
                      'id': cartProduct.id,
                      'title': cartProduct.title,
                      'price': cartProduct.price,
                      'quantity': cartProduct.quantity,
                    })
                .toList(),
          },
        ),
      );
      _orders.insert(
        0,
        OrderItem(
          id: json.decode(response.body)['name'],
          amount: total,
          products: cartItems,
          dateTime: currentDateTime,
        ),
      );
      
      notifyListeners();
    } catch (_) {
      rethrow;
    }
  }
}
