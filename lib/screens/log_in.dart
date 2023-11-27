import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:realm/realm.dart';
import 'package:sanjibautomobiles/components/user_fields.dart';
import 'package:sanjibautomobiles/utils/extensions.dart';

import '../providers/app_services.dart';
import '../utils/utils.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({super.key});

  @override
  _LogInPageState createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  bool _isLogin = true;

  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(25),
          margin: const EdgeInsets.only(top: 30),
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Text(_isLogin ? 'Log In' : 'Sign Up',
                          style: const TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold)),
                      UserFields(
                          controller: _emailController,
                          label: "Email",
                          hint: "Enter valid email like abc@gmail.com"),
                      UserFields(
                          controller: _passwordController,
                          label: "Password",
                          hint: "Enter secure password",
                          obscure: true),
                      const Padding(
                        padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                        child: Text(
                            "Please login or register with a user account.",
                            textAlign: TextAlign.center),
                      ),
                      10.verticalSpace(),
                      ElevatedButton(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                            child: Text(_isLogin ? "Log in" : "Sign up"),
                          ),
                          onPressed: () => _logInOrSignUpUser(context,
                              _emailController.text, _passwordController.text)),
                      10.verticalSpace(),
                      TextButton(
                          onPressed: () => setState(() => _isLogin = !_isLogin),
                          child: Text(
                            _isLogin
                                ? "New user? Sign up"
                                : 'Already have an account? Log in.',
                          )),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _logInOrSignUpUser(
      BuildContext context, String email, String password) async {
    final appServices = Provider.of<AppServices>(context, listen: false);
    try {
      if (_isLogin) {
        await appServices.logInUserEmailPassword(email, password);
      } else {
        await appServices.registerUserEmailPassword(email, password);
      }
      Navigator.pushNamed(context, '/');
    } on AppException catch (err) {
      Utils.showSnackBar(text: err.message, context: context);
    }
  }
}
