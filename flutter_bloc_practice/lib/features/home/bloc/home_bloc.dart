import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc_practice/data/cart_items.dart';
import 'package:flutter_bloc_practice/features/home/models/product_data_model.dart';
import 'package:meta/meta.dart';

import '../../../data/grocery_data.dart';
part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeInitialEvent>(homeInitialEvent);
    on<HomeNavigateToCartScreenButtonClickedEvent>(
      homeNavigateToCartScreenButtonClickeEvent,
    );
    on<HomeProductAddToCartButtonClickedEvent>(
      homeProductAddToCartButtonClickedEvent,
    );
  }

  FutureOr<void> homeInitialEvent(
    HomeInitialEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeLoadingState());
    await Future.delayed(const Duration(seconds: 3));
    final loadedProductList = GroceryData.groceryProducts
        .map((pr) => ProductDataModel(
              id: pr['id'],
              name: pr['name'],
              price: pr['price'],
            ))
        .toList();
    emit(HomeLoadedSuccessState(products: loadedProductList));
  }

  FutureOr<void> homeProductAddToCartButtonClickedEvent(
    HomeProductAddToCartButtonClickedEvent event,
    Emitter<HomeState> emit,
  ) {
    cartItems.add(event.clickedProduct);
    emit(HomeProductAddedToCartActionState());
  }

  FutureOr<void> homeNavigateToCartScreenButtonClickeEvent(
    HomeNavigateToCartScreenButtonClickedEvent event,
    Emitter<HomeState> emit,
  ) {
    emit(HomeNavigateToCartScreenActionState());
  }
}
