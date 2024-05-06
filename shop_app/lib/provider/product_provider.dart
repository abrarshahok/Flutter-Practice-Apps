import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/http_exceptions.dart';
import 'product.dart';

class ProductProvider with ChangeNotifier {
  // ignore: prefer_final_fields
  List<Product> _productItems = [
    // Product(
    //   id: 'p1',
    //   title: 'Red Shirt',
    //   description: 'A red shirt - it is pretty red!',
    //   price: 29.99,
    //   imageUrl:
    //       'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    // ),
    // Product(
    //   id: 'p2',
    //   title: 'Trousers',
    //   description: 'A nice pair of trousers.',
    //   price: 59.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    // ),
    // Product(
    //   id: 'p3',
    //   title: 'Yellow Scarf',
    //   description: 'Warm and cozy - exactly what you need for the winter.',
    //   price: 19.99,
    //   imageUrl:
    //       'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    // ),
    // Product(
    //   id: 'p4',
    //   title: 'A Pan',
    //   description: 'Prepare any meal you want.',
    //   price: 49.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    // ),
  ];

  final String authToken;
  final String userId;
  ProductProvider(this.authToken, this.userId, this._productItems);

  List<Product> get items {
    return [..._productItems];
  }

  List<Product> get favItems {
    return _productItems.where((product) => product.isFavourite).toList();
  }

  Product findById(String id) {
    return _productItems.firstWhere((product) => product.id == id);
  }

  Future<void> fetchProducts([bool filterByUser = false]) async {
    final String filterString =
        filterByUser ? 'orderBy="userId"&equalTo="$userId"' : '';
    final url =
        'https://shop-app-20-default-rtdb.firebaseio.com/products.json?auth=$authToken&$filterString';

    try {
      final response = await http.get(Uri.parse(url));
      final checkData = json.decode(response.body);
      if (checkData == null) {
        return;
      }
      final favUrl = Uri.parse(
        "https://shop-app-20-default-rtdb.firebaseio.com/userFavourites/$userId.json?auth=$authToken",
      );
      final favResponse = await http.get(favUrl);
      final favData = json.decode(favResponse.body);
      final fetchedProducts = checkData as Map<String, dynamic>;
      final List<Product> loadedProucts = [];
      fetchedProducts.forEach((productId, productData) {
        loadedProucts.add(
          Product(
            id: productId,
            title: productData['title'],
            description: productData['description'],
            price: productData['price'],
            imageUrl: productData['imageUrl'],
            isFavourite: favData == null ? false : favData[productId] ?? false,
          ),
        );
      });
      _productItems = loadedProucts;
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> addProduct({required Product product}) async {
    final url =
        "https://shop-app-20-default-rtdb.firebaseio.com/products.json?auth=$authToken";

    try {
      final response = await http.post(
        Uri.parse(url),
        body: json.encode(
          {
            'title': product.title,
            'description': product.description,
            'imageUrl': product.imageUrl,
            'price': product.price,
            'userId': userId,
          },
        ),
      );
      final updatedProduct = Product(
        id: json.decode(response.body)['name'],
        title: product.title,
        imageUrl: product.imageUrl,
        description: product.description,
        price: product.price,
        isFavourite: product.isFavourite,
      );
      _productItems.add(updatedProduct);

      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> updateProduct(
      {required String id, required Product newProduct}) async {
    final currentIndex = _productItems.indexWhere(
      (existingProduct) => existingProduct.id == id,
    );
    if (currentIndex >= 0) {
      final url =
          "https://shop-app-20-default-rtdb.firebaseio.com/products/$id.json?auth=$authToken";
      try {
        await http.patch(
          Uri.parse(url),
          body: json.encode({
            'title': newProduct.title,
            'imageUrl': newProduct.imageUrl,
            'description': newProduct.description,
            'price': newProduct.price.toString(),
          }),
        );
        _productItems[currentIndex] = newProduct;
        notifyListeners();
      } catch (error) {
        rethrow;
      }
    }
  }

  Future<void> removeProduct({required String id}) async {
    final url =
        "https://shop-app-20-default-rtdb.firebaseio.com/products/$id.json?auth=$authToken";
    final productIndex = _productItems.indexWhere(
      (product) => product.id == id,
    );
    Product? existingProduct = _productItems[productIndex];
    _productItems.removeAt(productIndex);
    notifyListeners();
    final response = await http.delete(Uri.parse(url));
    if (response.statusCode >= 400) {
      _productItems.insert(productIndex, existingProduct);
      notifyListeners();
      throw const HttpException('Could not delete product.');
    }
    existingProduct = null;
  }
}
