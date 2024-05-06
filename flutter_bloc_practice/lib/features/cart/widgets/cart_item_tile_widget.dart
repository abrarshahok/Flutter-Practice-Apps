import 'package:flutter/material.dart';
import '../bloc/cart_bloc.dart';
import '/features/home/models/product_data_model.dart';

class CartItemTileWidget extends StatelessWidget {
  final CartBloc cartBloc;
  final ProductDataModel productDataModel;
  const CartItemTileWidget({
    super.key,
    required this.cartBloc,
    required this.productDataModel,
  });
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  productDataModel.name,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Text(
                  '\$${productDataModel.price}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
            const Spacer(),
            IconButton(
              onPressed: () {
                cartBloc.add(CartItemDeleteButtonClickedEvent(
                  clickedProduct: productDataModel,
                ));
              },
              icon: const Icon(
                Icons.delete,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
