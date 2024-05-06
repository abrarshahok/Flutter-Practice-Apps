import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/provider/product_provider.dart';
import '/widgets/app_drawer.dart';
import '/screens/cart_screen.dart';
import '/widgets/badge.dart';
import '/provider/cart.dart';
import '../widgets/product_grid.dart';

enum FilterOptions { favorite, all }

class ProductOverviewScreen extends StatefulWidget {
  static const routeName = '/product-overview-screen';

  const ProductOverviewScreen({super.key});
  @override
  State<ProductOverviewScreen> createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  bool _isFavourite = false;
  bool _isInit = true;
  bool _isLoading = false;
  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<ProductProvider>(context).fetchProducts().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MyShop'),
        centerTitle: true,
        actions: [
          PopupMenuButton(
            onSelected: (FilterOptions selectedValue) {
              setState(() {
                if (selectedValue == FilterOptions.favorite) {
                  _isFavourite = true;
                } else if (selectedValue == FilterOptions.all) {
                  _isFavourite = false;
                }
              });
            },
            itemBuilder: (context) => const [
              PopupMenuItem(
                value: FilterOptions.favorite,
                child: Text('Show Favourites'),
              ),
              PopupMenuItem(
                value: FilterOptions.all,
                child: Text('Show All'),
              ),
            ],
          ),
          Consumer<Cart>(
            builder: (context, cartData, cartbtn) => BadgeWidget(
              value: cartData.itemCount.toString(),
              child: cartbtn!,
            ),
            child: IconButton(
              icon: const Icon(Icons.shopping_cart),
              onPressed: () {
                // Provider.of<Cart>(context, listen: false).fetchData();
                Navigator.of(context).pushNamed(CartScreen.routeName);
              },
            ),
          ),
        ],
      ),
      drawer: const AppDrawer(),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.purple,
              ),
            )
          : ProductsGrid(showFavourites: _isFavourite),
    );
  }
}
