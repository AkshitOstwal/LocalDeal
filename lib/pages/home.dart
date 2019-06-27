import 'package:flutter/material.dart';

import '../product_manager.dart';

class HomePage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    
    return  Scaffold(
        appBar: AppBar(
          title: Text('EasyList'),
        ),
        body: ProductManager(),
      );
  }
}
