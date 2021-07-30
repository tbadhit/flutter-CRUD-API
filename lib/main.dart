import 'package:flutter/material.dart';
import 'package:inventory_app/helper/sharedpref.dart';
import 'package:inventory_app/provider/item_provider.dart';
import 'package:inventory_app/ui/pages/home_page.dart';
import 'package:inventory_app/ui/pages/login_page.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPref _sharedPref = SharedPref();
  var loginPref = await _sharedPref.read('login_pref');
  runApp(MyApp(
    loginPref: loginPref,
  ));
}

class MyApp extends StatelessWidget {
  final loginPref;

  MyApp({this.loginPref});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ItemProvider(),
      child: MaterialApp(
          title: 'Inventory App',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.green,
          ),
          routes: {
            HomePage.id: (context) => HomePage(),
            LoginPage.id: (context) => LoginPage()
          },
          home: loginPref ? HomePage() : LoginPage()),
    );
  }
}
