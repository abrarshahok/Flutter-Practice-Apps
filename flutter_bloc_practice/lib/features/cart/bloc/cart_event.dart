part of 'cart_bloc.dart';

@immutable
abstract class CartEvent {}

class CartInitialEvent extends CartEvent {}

class CartItemDeleteButtonClickedEvent extends CartEvent {
  final ProductDataModel clickedProduct;
  CartItemDeleteButtonClickedEvent({required this.clickedProduct});
}
