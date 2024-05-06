import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/helpers/custom_route.dart';
import '/provider/auth.dart';
import '/provider/cart.dart';
import '/provider/order.dart';
import '/provider/product_provider.dart';
import '/screens/auth-screen.dart';
import '/screens/cart_screen.dart';
import '/screens/edit_product_screen.dart';
import '/screens/order_screen.dart';
import '/screens/manage_product_screen.dart';
import '/screens/product_detail_screen.dart';
import '/screens/product_overview_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, ProductProvider>(
          create: (context) => ProductProvider('', '', []),
          update: (context, authData, previousProducts) => ProductProvider(
            authData.token != null ? authData.token! : '',
            authData.userId != null ? authData.userId! : '',
            previousProducts!.items,
          ),
        ),
        ChangeNotifierProxyProvider<Auth, Order>(
          create: (context) => Order('', '', []),
          update: (context, authData, previousOrder) => Order(
            authData.token != null ? authData.token! : '',
            authData.userId != null ? authData.userId! : '',
            previousOrder!.orders,
          ),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Cart(),
        ),
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Shop App',
          theme: ThemeData(
            fontFamily: 'Lato',
            colorScheme: ColorScheme.fromSwatch(
              primarySwatch: Colors.purple,
              accentColor: Colors.deepOrange,
            ),
            pageTransitionsTheme: PageTransitionsTheme(
              builders: {
                TargetPlatform.android: CustomPageTransitionBuilder(),
                TargetPlatform.iOS: CustomPageTransitionBuilder(),
              },
            ),
          ),
          home: auth.isAuth
              ? const ProductOverviewScreen()
              : FutureBuilder(
                  future: auth.autoLogin(),
                  builder: ((context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Scaffold(
                        body: Center(child: CircularProgressIndicator()),
                      );
                    } else {
                      return const AuthScreen();
                    }
                  }),
                ),
          routes: {
            ProductOverviewScreen.routeName: (context) =>
                const ProductOverviewScreen(),
            ProductDetailScreen.routeName: (context) =>
                const ProductDetailScreen(),
            CartScreen.routeName: (context) => const CartScreen(),
            OrderScreen.routeName: (context) => const OrderScreen(),
            ManageProductScreen.routeName: (context) =>
                const ManageProductScreen(),
            EditProductScreen.routeName: (context) => const EditProductScreen(),
          },
        ),
      ),
    );
  }
}
