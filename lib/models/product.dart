import 'package:flutter/material.dart';

class Product {
  final String title;
  final String description;
  final double price;
  final String image;
  final String imagePath;
  final bool isFavorite;
  final String userEmail;
  final String userId;
  final String id;

  Product({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.image,
    @required this.imagePath,
    @required this.userEmail,
    @required this.userId,
    this.isFavorite = false,
  });
}
