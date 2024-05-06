import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/features/cart/widgets/cart_item_tile_widget.dart';

import '../bloc/cart_bloc.dart';

class Cart extends StatefulWidget {
  static const routeName = '/cart-screen';
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  final CartBloc cartBloc = CartBloc();
  @override
  void initState() {
    cartBloc.add(CartInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartBloc, CartState>(
      bloc: cartBloc,
      listenWhen: (previous, current) => current is CartActionState,
      buildWhen: (previous, current) => current is! CartActionState,
      listener: (context, state) {
        if (state is CartItemDeletedActionState) {
          ScaffoldMessenger.of(context).removeCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Item deleted from cart.'),
            ),
          );
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case CartLoadedSuccessState:
            final successState = state as CartLoadedSuccessState;
            return Scaffold(
              appBar: AppBar(
                title: const Text('Cart Screen'),
              ),
              body: ListView.builder(
                itemCount: successState.cartItems.length,
                itemBuilder: (context, index) => CartItemTileWidget(
                  cartBloc: cartBloc,
                  productDataModel: successState.cartItems[index],
                ),
              ),
            );

          default:
            return const SizedBox();
        }
      },
    );
  }
}
