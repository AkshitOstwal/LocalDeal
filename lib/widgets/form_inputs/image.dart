import 'dart:io';

import 'package:firstapp/models/product.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageInput extends StatefulWidget {
  final Function setImage;
  final Product product;

  ImageInput(this.setImage, this.product);

  @override
  State<StatefulWidget> createState() {
    return _ImageInputState();
  }
}

class _ImageInputState extends State<ImageInput> {
  File _imageFile;

  Future _getImage(BuildContext context, ImageSource source) async {
    print('getting image');
    File image = await ImagePicker.pickImage(source: source, maxWidth: 500);
    if(image == null){
      return null;
    }
    setState(() {
      print('file = image');
      _imageFile = image;
    });
    print('setting image');
    widget.setImage(image);
    Navigator.pop(context);
  }

  void _openImagePicker(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            padding: EdgeInsets.all(10),
            height: 150,
            child: Column(children: <Widget>[
              Text(
                'Pick an Image',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              FlatButton(
                textColor: Theme.of(context).primaryColor,
                child: Text('Use Camera'),
                onPressed: () {
                  _getImage(context, ImageSource.camera);
                },
              ),
              FlatButton(
                textColor: Theme.of(context).primaryColor,
                child: Text('Use Gallery'),
                onPressed: () {
                  _getImage(context, ImageSource.gallery);
                },
              )
            ]),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final buttonColor = Theme.of(context).primaryColor;
    Widget previewImage = Text('Please select an image.');
    if (_imageFile != null) {
      previewImage = Image.file(
        _imageFile,
        height: 300.0,
        width: MediaQuery.of(context).size.width,
        fit: BoxFit.cover,
        alignment: Alignment.center,
      );
    } else if (widget.product != null) {
      previewImage = Image.network(
        widget.product.image,
        height: 300.0,
        width: MediaQuery.of(context).size.width,
        fit: BoxFit.cover,
        alignment: Alignment.center,
      );
    }

    return Column(
      children: <Widget>[
        OutlineButton(
          onPressed: () {
            _openImagePicker(context);
          },
          borderSide: BorderSide(color: buttonColor, width: 1),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.camera_alt,
                color: buttonColor,
              ),
              SizedBox(
                width: 5.0,
              ),
              Text(
                'Add Image',
                style: TextStyle(color: buttonColor),
              )
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        previewImage,
      ],
    );
  }
}
