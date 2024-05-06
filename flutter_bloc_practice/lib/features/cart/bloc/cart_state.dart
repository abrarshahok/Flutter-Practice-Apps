part of 'cart_bloc.dart';

@immutable
abstract class CartState {}

class CartActionState extends CartState {}

class CartInitial extends CartState {}

class CartLoadedSuccessState extends CartState {
  final List<ProductDataModel> cartItems;

  CartLoadedSuccessState({required this.cartItems});
}

class CartItemDeletedActionState extends CartActionState {}
