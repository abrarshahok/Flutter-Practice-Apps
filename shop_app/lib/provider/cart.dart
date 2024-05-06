import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CartItem {
  final String id;
  final String title;
  final double price;
  final int quantity;

  CartItem({
    required this.id,
    required this.title,
    required this.price,
    required this.quantity,
  });
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _cartItems = {};
  Map<String, CartItem> get items {
    return {..._cartItems};
  }

  int get itemCount => _cartItems.length;

  double get totalAmount {
    double amount = 0.0;
    _cartItems.forEach((key, cartItem) {
      amount += cartItem.price * cartItem.quantity;
    });
    return amount;
  }

  // Future<void> fetchData() async {
  //   try {
  //     const url = 'https://shop-app-20-default-rtdb.firebaseio.com/cart.json';
  //     final response = await http.get(Uri.parse(url));
  //     final extractedData = json.decode(response.body) as Map<String, dynamic>?;
  //     if (extractedData == null) {
  //       return;
  //     }
  //     _cartItems.clear();
  //     extractedData.forEach((productId, cartData) {
  //       _cartItems[productId] = CartItem(
  //         id: productId,
  //         title: cartData['cartItems']['title'],
  //         price: cartData['cartItems']['price'],
  //         quantity: cartData['cartItems']['quantity'],
  //       );
  //     });
  //     notifyListeners();
  //   } catch (error) {
  //     rethrow;
  //   }
  // }

  Future<void> addItems({
    required String productId,
    required String title,
    required double price,
  }) async {
    try {
      if (_cartItems.containsKey(productId)) {
        final cartId = _cartItems[productId]!.id;
        final url =
            'https://shop-app-20-default-rtdb.firebaseio.com/cart/$cartId.json';
        int existingQuantity = _cartItems[productId]!.quantity;
        await http.patch(
          Uri.parse(url),
          body: json.encode(
            {
              'cartItems': {
                'title': title,
                'price': price,
                'quantity': existingQuantity + 1,
              }
            },
          ),
        );
        _cartItems.update(
          productId,
          (cartProduct) => CartItem(
            id: cartProduct.id,
            title: cartProduct.title,
            price: cartProduct.price,
            quantity: cartProduct.quantity + 1,
          ),
        );
      } else {
        const url = 'https://shop-app-20-default-rtdb.firebaseio.com/cart.json';
        final response = await http.post(
          Uri.parse(url),
          body: json.encode(
            {
              'cartItems': {
                'title': title,
                'price': price,
                'quantity': 1,
              }
            },
          ),
        );
        _cartItems.putIfAbsent(
          productId,
          () => CartItem(
            id: json.decode(response.body)['name'].toString(),
            title: title,
            price: price,
            quantity: 1,
          ),
        );
      }
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  void removeSingleItem(String id) {
    if (!_cartItems.containsKey(id)) {
      return;
    }
    if (_cartItems[id]!.quantity > 1) {
      _cartItems.update(
        id,
        (product) => CartItem(
          id: product.id,
          title: product.title,
          price: product.price,
          quantity: product.quantity - 1,
        ),
      );
    } else {
      _cartItems.remove(id);
    }
    notifyListeners();
  }

  void removeItem(String id) {
    _cartItems.remove(id);
    notifyListeners();
  }

  void clearCart() {
    _cartItems = {};
    notifyListeners();
  }
}
