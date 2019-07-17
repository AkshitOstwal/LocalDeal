import 'package:firstapp/scoped-models/main.dart';

import './pages/auth.dart';
import './pages/products.dart';
import './pages/products_admin.dart';
import './pages/product.dart';

import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

// import 'package:flutter/rendering.dart';

void main() {
  // debugPaintSizeEnabled = true;
  // debugPaintBaselinesEnabled = true;
  // debugPaintPointersEnabled = true;
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    print("hey inside MyApp => build");
    final MainModel model =MainModel();
    return ScopedModel<MainModel>(
      model: model,
      child: MaterialApp(
        // debugShowMaterialGrid: true,
        theme: ThemeData(
            brightness: Brightness.light,
            primarySwatch: Colors.deepOrange,
            accentColor: Colors.deepPurple,
            buttonColor: Colors.deepPurple),
        // home: AuthPage(),
        routes: {
          '/': (BuildContext context) => AuthPage(),
          '/products': (BuildContext context) => ProductsPage(model),
          '/admin': (BuildContext context) => ProductAdminPage(),
        },
        onGenerateRoute: (RouteSettings settings) {
          final List<String> pathElements =
              settings.name.split('/'); //ex '/product/1'

          if (pathElements[0] != '') return null;

          if (pathElements[1] == 'product') {
            final int index = int.parse(pathElements[2]);

            return MaterialPageRoute<bool>(
              builder: (BuildContext context) => ProductPage(index),
            );
          }
          return null;
        },
        onUnknownRoute: (RouteSettings settings) {
          return MaterialPageRoute(
              builder: (BuildContext context) => ProductsPage(model));
        },
      ),
    );
  }
}
