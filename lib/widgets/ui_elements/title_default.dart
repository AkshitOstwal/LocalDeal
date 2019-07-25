import 'package:flutter/material.dart';

class TitleDefault extends StatelessWidget {
  final String title;

  TitleDefault(this.title);

  @override
  Widget build(BuildContext context) {
    final deviceWidht = MediaQuery.of(context).size.width;
    return Text(
      title,
      softWrap: true,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontFamily: 'Oswald',
        fontSize: deviceWidht > 350 ? 26 : 16,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
