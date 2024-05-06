import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '/data/cart_items.dart';
import '/features/home/models/product_data_model.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial()) {
    on<CartInitialEvent>(cartInitialEvent);
    on<CartItemDeleteButtonClickedEvent>(cartItemDeleteButtonClickedEvent);
  }

  FutureOr<void> cartInitialEvent(
    CartInitialEvent event,
    Emitter<CartState> emit,
  ) {
    emit(CartLoadedSuccessState(cartItems: cartItems));
  }

  FutureOr<void> cartItemDeleteButtonClickedEvent(
    CartItemDeleteButtonClickedEvent event,
    Emitter<CartState> emit,
  ) {
    cartItems.removeWhere((element) => element.id == event.clickedProduct.id);
    emit(CartItemDeletedActionState());
    emit(CartLoadedSuccessState(cartItems: cartItems));
  }
}
