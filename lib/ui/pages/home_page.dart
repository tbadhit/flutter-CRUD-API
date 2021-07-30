import 'package:flutter/material.dart';
import 'package:inventory_app/helper/sharedpref.dart';
import 'package:inventory_app/model/response_barang.dart';
import 'package:inventory_app/ui/pages/form_page.dart';
import 'package:inventory_app/ui/pages/login_page.dart';
import 'package:inventory_app/ui/pages/search_page.dart';
import 'package:inventory_app/ui/widget/grid_item.dart';

class HomePage extends StatelessWidget {
  static const String id = "HOME_PAGE";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inventory App'),
        actions: [
          IconButton(
              onPressed: () {
                // Action
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SearchPage()));
              },
              icon: Icon(Icons.search)),
          IconButton(
              onPressed: () async {
                SharedPref _sharedPref = SharedPref();
                await _sharedPref.remove('login_pref');
                Navigator.pushReplacementNamed(context, LoginPage.id);
              },
              icon: Icon(Icons.lock_open))
        ],
      ),
      body: GridItem(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Action
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => FormPage(
                        item: Barang(),
                        title: "Add Data",
                      )));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
