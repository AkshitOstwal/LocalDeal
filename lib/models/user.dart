import 'package:flutter/material.dart';

class User {
  final String email;
  final String password;
  final String id;

  User({
    @required this.id,
    @required this.email,
    @required this.password,
  });
}
