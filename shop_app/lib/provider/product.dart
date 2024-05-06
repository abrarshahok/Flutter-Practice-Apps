import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final double price;
  bool isFavourite;

  Product({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.description,
    required this.price,
    this.isFavourite = false,
  });

  void _setFavValue(bool newVal) {
    isFavourite = newVal;
    notifyListeners();
  }

  Future<void> toggleFavourite({
    required String authToken,
    required String userId,
  }) async {
    bool oldStatus = isFavourite;
    final url = Uri.parse(
      "https://shop-app-20-default-rtdb.firebaseio.com/userFavourites/$userId/$id.json?auth=$authToken",
    );
    isFavourite = !isFavourite;
    notifyListeners();
    try {
      final response = await http.put(
        url,
        body: json.encode(isFavourite),
      );
      if (response.statusCode >= 400) {
        _setFavValue(oldStatus);
      }
    } catch (_) {
      _setFavValue(oldStatus);
    }
  }
}
