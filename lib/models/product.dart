import 'package:flutter/material.dart';

class Product {
  final String title;
  final String description;
  final double price;
  final String image;
  final bool isFavorite;
  final String userEmail;
  final String userId;

  Product({
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.image,
    @required this.userEmail,
    @required this.userId,
    this.isFavorite = false,
  });
}
