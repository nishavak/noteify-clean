import 'package:flutter/material.dart';
import 'package:noteify/services/authentication.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthenticationService _auth = AuthenticationService();
  String email = '';
  String password = '';
  String error = '';
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          'NOTEIFY',
          style: TextStyle(
              color: Colors.black, fontSize: 25.0, fontWeight: FontWeight.w900),
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
                      "https://d2v1hpltdjq1rf.cloudfront.net/static/account/assets/images/ic-login.png"),
                ),
                SizedBox(height: 10.0),
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
                  validator: (val) => val.isEmpty ? 'Enter the email' : null,
                  onChanged: (val) {
                    setState(() {
                      email = val;
                    });
                  },
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  decoration: InputDecoration(
                      hintText: 'Password',
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
                      val.length < 6 ? 'Enter password 6+ chars long' : null,
                  obscureText: true,
                  onChanged: (val) {
                    setState(() {
                      password = val;
                    });
                  },
                ),
                SizedBox(height: 20.0),
                RaisedButton(
                  elevation: 5.0,
                  color: Colors.green,
                  textColor: Colors.white,
                  child: Text(
                    'Register',
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      dynamic result = await _auth.registerWithEmailAndPassword(
                          email, password);
                      if (result == null) {
                        setState(() {
                          error = 'Error registering user';
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
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                RaisedButton(
                  onPressed: () async {
                    dynamic result = await _auth.signInAnon();
                    if (result == null) {
                      setState(() {
                        error = 'Feature not working';
                      });
                    }
                  },
                  color: Colors.white,
                  elevation: 0.0,
                  child: Text(
                    'Try the app without registering',
                    style: TextStyle(
                        // decoration: TextDecoration.underline,
                        ),
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
