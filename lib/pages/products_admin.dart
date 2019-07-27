import 'package:firstapp/scoped-models/main.dart';
import 'package:firstapp/widgets/ui_elements/logout_listtile.dart';

import './product_edit.dart';
import './product_list.dart';

import 'package:flutter/material.dart';

class ProductAdminPage extends StatelessWidget {
  final MainModel model;
  ProductAdminPage(this.model);
  Widget _buildSideDrawer(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            automaticallyImplyLeading: false,
            title: Text("चुनें"),
            elevation:
                Theme.of(context).platform == TargetPlatform.iOS ? 0.0 : 4.0,
          ),
          ListTile(
            leading: Icon(Icons.shop),
            title: Text("सभी उत्पाद"),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/');
            },
          ),
          Divider(
            height: 2,
            color: Colors.grey,
          ),
          LogoutListTile(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          drawer: _buildSideDrawer(context),
          appBar: AppBar(
            title: Text("उत्पाद का प्रबंधन करें"),
            elevation:
                Theme.of(context).platform == TargetPlatform.iOS ? 0.0 : 4.0,
            bottom: TabBar(
              tabs: <Widget>[
                Tab(
                  icon: Icon(Icons.create),
                  text: "उत्पाद बनाएँ",
                ),
                Tab(
                  icon: Icon(Icons.list),
                  text: "मेरा उत्पाद",
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              ProductEditPage(),
              ProductListPage(model),
            ],
          ),
        ),
      ),
    );
  }
}
