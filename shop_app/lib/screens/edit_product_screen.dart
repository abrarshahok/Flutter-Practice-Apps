import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/provider/product.dart';
import 'package:shop_app/provider/product_provider.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = '/edit-product-screen';

  const EditProductScreen({super.key});
  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _imageUrlFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();
  // ignore: prefer_final_fields
  var _editedProduct = Product(
    id: '',
    title: '',
    imageUrl: '',
    description: '',
    price: 0,
  );

  var _initProducts = {
    'title': '',
    'description': '',
    'price': '',
  };

  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImageUrl);
    super.initState();
  }

  bool _isLoading = false;
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit) {
      final productId = ModalRoute.of(context)?.settings.arguments;
      if (productId != null) {
        _editedProduct = Provider.of<ProductProvider>(context, listen: false)
            .findById(productId.toString());
        _initProducts = {
          'title': _editedProduct.title,
          'description': _editedProduct.description,
          'price': _editedProduct.price.toString(),
        };
        _imageUrlController.text = _editedProduct.imageUrl;
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlController.dispose();
    _imageUrlFocusNode.dispose();
    _imageUrlFocusNode.removeListener(_updateImageUrl);
    super.dispose();
  }

  void _updateImageUrl() {
    if (!_imageUrlFocusNode.hasFocus) {
      // Remove Image Preview
      if (_imageUrlController.text.isEmpty) {
        setState(() {});
      }
      // Check Url Starting
      if ((!_imageUrlController.text.startsWith('http') &&
              !_imageUrlController.text.startsWith('https')) ||
          // Check Url Ending
          ((!_imageUrlController.text.endsWith('.png') &&
              !_imageUrlController.text.endsWith('.jpg') &&
              !_imageUrlController.text.endsWith('.jpeg')))) {
        return;
      }

      setState(() {});
    }
  }

  void _saveForm() {
    bool isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    _formKey.currentState?.save();
    setState(() {
      _isLoading = true;
    });
    if (_editedProduct.id.isNotEmpty) {
      Provider.of<ProductProvider>(context, listen: false).updateProduct(
        id: _editedProduct.id,
        newProduct: _editedProduct,
      );
      setState(() {
        _isLoading = false;
      });
      Navigator.of(context).pop();
    } else {
      Provider.of<ProductProvider>(context, listen: false)
          .addProduct(product: _editedProduct)
          .catchError((error) {
        // ignore: prefer_void_to_null
        return showDialog<Null>(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text('An error occured!'),
            content: const Text('Something went wrong.'),
            actions: [
              ElevatedButton(
                onPressed: () => Navigator.of(ctx).pop(),
                child: const Text('Okay!'),
              ),
            ],
          ),
        );
      }).then((_) {
        setState(() {
          _isLoading = false;
        });
        Navigator.of(context).pop();
      });
    }
  }

  void _updateProductDetails({
    required Product existingProduct,
    String title = '',
    String description = '',
    String imageUrl = '',
    double price = 0.0,
  }) {
    _editedProduct = Product(
      id: _editedProduct.id,
      title: title.isNotEmpty ? title : existingProduct.title,
      imageUrl: imageUrl.isNotEmpty ? imageUrl : existingProduct.imageUrl,
      description:
          description.isNotEmpty ? description : existingProduct.description,
      price: price != 0.0 ? price : existingProduct.price,
      isFavourite: _editedProduct.isFavourite,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Product'),
        actions: [
          IconButton(
            onPressed: _saveForm,
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.purple,
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(15),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    TextFormField(
                      initialValue: _initProducts['title'],
                      decoration: const InputDecoration(labelText: 'Title'),
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_priceFocusNode);
                      },
                      validator: (value) {
                        return value!.isEmpty ? 'Please enter a title.' : null;
                      },
                      onSaved: (title) {
                        _updateProductDetails(
                            existingProduct: _editedProduct, title: title!);
                      },
                    ),
                    TextFormField(
                      initialValue: _initProducts['price'],
                      decoration: const InputDecoration(labelText: 'Price'),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      focusNode: _priceFocusNode,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context)
                            .requestFocus(_descriptionFocusNode);
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a price.';
                        }
                        if (double.tryParse(value) == null) {
                          return 'Please enter a valid number!';
                        }
                        if (double.parse(value) <= 0) {
                          return 'Please enter number greater than zero.';
                        }
                        return null;
                      },
                      onSaved: (price) {
                        _updateProductDetails(
                          existingProduct: _editedProduct,
                          price: double.parse(price!),
                        );
                      },
                    ),
                    TextFormField(
                      initialValue: _initProducts['description'],
                      decoration:
                          const InputDecoration(labelText: 'Description'),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.multiline,
                      focusNode: _descriptionFocusNode,
                      maxLines: 3,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a description.';
                        }
                        if (value.length < 10) {
                          return 'Should be atleast 10 characters long.';
                        }
                        return null;
                      },
                      onSaved: (description) {
                        _updateProductDetails(
                          existingProduct: _editedProduct,
                          description: description!,
                        );
                      },
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          height: 100,
                          width: 100,
                          margin: const EdgeInsets.only(top: 8, right: 10),
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 1,
                              color: Colors.grey,
                            ),
                          ),
                          child: _imageUrlController.text.isEmpty
                              ? const Center(child: Text('Enter a URL!'))
                              : FittedBox(
                                  child: Image.network(
                                    _imageUrlController.text,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                        ),
                        Expanded(
                          child: TextFormField(
                            initialValue: _initProducts['imageUrl'],
                            decoration:
                                const InputDecoration(labelText: 'Image URL'),
                            textInputAction: TextInputAction.done,
                            controller: _imageUrlController,
                            keyboardType: TextInputType.url,
                            focusNode: _imageUrlFocusNode,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter a Image URL.';
                              }
                              if (!value.startsWith('http') &&
                                  !value.startsWith('https')) {
                                return 'Please enter valid URL';
                              }
                              if (!value.endsWith('.png') &&
                                  !value.endsWith('.jpg') &&
                                  !value.endsWith('.jpeg')) {
                                return 'Please enter valid image URL';
                              }

                              return null;
                            },
                            onEditingComplete: () => setState(() {}),
                            onSaved: (imageUrl) {
                              _updateProductDetails(
                                existingProduct: _editedProduct,
                                imageUrl: imageUrl!,
                              );
                            },
                            onFieldSubmitted: (_) {
                              _saveForm();
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
