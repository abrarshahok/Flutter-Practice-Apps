import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;

class ImageInput extends StatefulWidget {
  final Function onImagePicked;
  const ImageInput(this.onImagePicked, {super.key});

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _loadedImage;

  Future<void> _addImage() async {
    final pickedImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 600,
    );
    if (pickedImage == null) {
      return;
    }
    setState(() {
      _loadedImage = File(pickedImage.path);
    });
  }

  Future<void> _clickImage() async {
    final pickedImage = await ImagePicker().pickImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );
    if (pickedImage == null) {
      return;
    }
    setState(() {
      _loadedImage = File(pickedImage.path);
    });
    final appDir = await syspaths.getApplicationDocumentsDirectory();
    final imageName = path.basename(pickedImage.path);
    final imageFile = File(pickedImage.path);
    final savedImage = File('${appDir.path}/$imageName');
    await savedImage.writeAsBytes(await imageFile.readAsBytes());
    widget.onImagePicked(savedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 120,
          width: 150,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Colors.grey,
            ),
          ),
          alignment: Alignment.center,
          child: _loadedImage != null
              ? Image.file(
                  _loadedImage!,
                  fit: BoxFit.cover,
                )
              : const Text('No Image!'),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            children: [
              TextButton.icon(
                icon: const Icon(
                  Icons.image,
                ),
                onPressed: _addImage,
                label: Text(
                  'Add Image',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
              TextButton.icon(
                icon: const Icon(
                  Icons.camera_alt_outlined,
                ),
                onPressed: _clickImage,
                label: Text(
                  'Click Image',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
