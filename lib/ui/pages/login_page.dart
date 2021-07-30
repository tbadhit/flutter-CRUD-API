import 'package:flutter/material.dart';
import 'package:inventory_app/helper/sharedpref.dart';
import 'package:inventory_app/model/response_login.dart';
import 'package:inventory_app/service/auth_services.dart';
import 'package:inventory_app/style/text_input.dart';
import 'package:inventory_app/ui/pages/home_page.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginPage extends StatefulWidget {
  static const String id = "LOGIN_PAGE";
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  late String email;
  late String password;
  bool showSpinner = false;
  AuthServices _auth = AuthServices();
  SharedPref _sharedPref = SharedPref();

  String? validator(String? value) {
    if (value!.isEmpty) {
      return "Please enter field";
    }
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Container(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Flexible(
                    child: Container(
                      height: 200.0,
                      child: Image.asset(
                        'images/ima-putih.png',
                        color: Colors.green,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    style: TextStyle(color: Colors.black),
                    textAlign: TextAlign.center,
                    decoration: loginTextInputDecoration('Enter your email..'),
                    validator: validator,
                    onChanged: (newValue) {
                      email = newValue;
                    },
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  TextFormField(
                    obscureText: true,
                    style: TextStyle(color: Colors.black),
                    textAlign: TextAlign.center,
                    decoration:
                        loginTextInputDecoration('Enter your password..'),
                    validator: validator,
                    onChanged: (newValue) {
                      password = newValue;
                    },
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Material(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(30),
                      elevation: 5.0,
                      child: MaterialButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              showSpinner = true;
                            });

                            ResponseLogin statusLogin =
                                await _auth.login(email, password);

                            if (statusLogin.sukses) {
                              await _sharedPref.save('login_pref', true);
                              Navigator.pushReplacementNamed(
                                  context, HomePage.id);
                            } else {
                              setState(() {
                                showSpinner = false;
                              });
                            }
                          }
                        },
                        minWidth: 200.0,
                        height: 42,
                        child: Text(
                          'Log In',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
