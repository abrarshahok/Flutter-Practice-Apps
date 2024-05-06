import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/features/home/widgets/product_tile_widget.dart';
import '/features/cart/screens/cart.dart';
import '../bloc/home_bloc.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    homeBloc.add(HomeInitialEvent());
    super.initState();
  }

  final HomeBloc homeBloc = HomeBloc();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: homeBloc,
      listenWhen: (previous, current) => current is HomeActionState,
      buildWhen: (previous, current) => current is! HomeActionState,
      listener: (context, state) {
        if (state is HomeNavigateToCartScreenActionState) {
          Navigator.pushNamed(context, Cart.routeName);
        } else if (state is HomeProductAddedToCartActionState) {
          ScaffoldMessenger.of(context).removeCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Item added to cart.'),
            ),
          );
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case HomeLoadingState:
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          case HomeLoadedSuccessState:
            final successState = state as HomeLoadedSuccessState;
            return Scaffold(
              appBar: AppBar(
                elevation: 5,
                shadowColor: Colors.black,
                title: const Text('Bloc Practice'),
                actions: [
                  IconButton(
                    onPressed: () {
                      homeBloc
                          .add(HomeNavigateToCartScreenButtonClickedEvent());
                    },
                    icon: const Icon(Icons.shopping_cart),
                  ),
                ],
              ),
              body: ListView.builder(
                itemCount: successState.products.length,
                itemBuilder: (context, index) => ProductTileWidget(
                  homeBloc: homeBloc,
                  productDataModel: successState.products[index],
                ),
              ),
            );
          case HomeErrorState:
            return const Scaffold(
              body: Center(
                child: Text('Error!'),
              ),
            );
          default:
            return const SizedBox();
        }
      },
    );
  }
}
