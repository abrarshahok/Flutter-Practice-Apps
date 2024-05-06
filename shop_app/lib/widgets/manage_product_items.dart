import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/provider/product_provider.dart';
import 'package:shop_app/screens/edit_product_screen.dart';

class ManageProductItems extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;

  const ManageProductItems({super.key, 
    required this.id,
    required this.title,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
      ),
      title: Text(title),
      trailing: SizedBox(
        width: 100,
        child: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.edit),
              color: Theme.of(context).colorScheme.primary,
              onPressed: () {
                Navigator.of(context).pushNamed(
                  EditProductScreen.routeName,
                  arguments: id,
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              color: Theme.of(context).colorScheme.error,
              onPressed: () async {
                try {
                  await Provider.of<ProductProvider>(context, listen: false)
                      .removeProduct(id: id);
                  scaffoldMessenger.showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Item deleted Successfully',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                } catch (error) {
                  scaffoldMessenger.showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Item not deleted!',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
