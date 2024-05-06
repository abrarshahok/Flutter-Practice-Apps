import 'package:flutter/material.dart';
import '/features/home/bloc/home_bloc.dart';
import '/features/home/models/product_data_model.dart';

class ProductTileWidget extends StatelessWidget {
  final HomeBloc homeBloc;
  final ProductDataModel productDataModel;
  const ProductTileWidget({
    super.key,
    required this.homeBloc,
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
                homeBloc.add(HomeProductAddToCartButtonClickedEvent(
                    clickedProduct: productDataModel));
              },
              icon: const Icon(
                Icons.shopping_cart,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
