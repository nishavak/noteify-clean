import 'package:flutter/material.dart';
import 'package:noteify/loading.dart';
import 'package:noteify/services/authentication.dart';

class ForgotPassword extends StatefulWidget {
  final Function toggleView;
  ForgotPassword({this.toggleView});

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  bool loading = false;
  final AuthenticationService _auth = AuthenticationService();
  String email = '';
  String error = '';
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            appBar: AppBar(
              elevation: 0.0,
              centerTitle: true,
              backgroundColor: Colors.white,
              title: Text(
                'NOTEIFY',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 25.0,
                    fontWeight: FontWeight.w900),
              ),
            ),
            body: Container(
              height: double.infinity,
              color: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 300.0,
                        child: Image.network(
                            "https://theuniqueacademy.co.in/assets/images/test.png"),
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                            hintText: 'Email',
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 20.0),
                            border: InputBorder.none,
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            filled: true,
                            fillColor: Colors.grey[50]),
                        validator: (val) =>
                            val.isEmpty ? 'Enter the email' : null,
                        onChanged: (val) {
                          setState(() {
                            email = val;
                          });
                        },
                      ),
                      SizedBox(height: 20.0),
                      RaisedButton(
                        elevation: 5.0,
                        color: Colors.green,
                        textColor: Colors.white,
                        child: Text(
                          'Send reset request',
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.bold),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            setState(() {
                              loading = true;
                            });
                            dynamic result =
                                await _auth.sendPasswordResetEmail(email);
                            if (result == null) {
                              setState(() {
                                loading = false;
                                error = 'Error sending password reset email';
                              });
                            }
                          }
                        },
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Text(
                        error,
                        style: TextStyle(color: Colors.red, fontSize: 14.0),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      RaisedButton(
                        onPressed: () {
                          widget.toggleView('login');
                        },
                        color: Colors.white,
                        elevation: 12.0,
                        child: Text(
                          'Login',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16.0),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
