import 'package:flutter/material.dart';

class User {
  final String email;
  final String token;
  final String id;

  User({
    @required this.id,
    @required this.email,
    @required this.token,
  });
}
