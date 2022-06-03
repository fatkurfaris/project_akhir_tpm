import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '/models/home.dart';
import 'package:project_resep/models/firstpage.dart';

import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // String username = "";
  // String password = "";
  bool isLoginSuccess = false;
  TextEditingController user = new TextEditingController();
  TextEditingController pass = new TextEditingController();

  String msg = '';

  String username = '';

  Future _login() async {
    final response = await http.post(
        Uri.parse("http://192.168.100.127/login_flutter/login.php"),
        body: {
          "username": user.text,
          "password": pass.text,
        });

    var datauser = json.decode(response.body);

    if (datauser.length == 0) {
      setState(() {
        msg = "Login Failed";
        isLoginSuccess = false;
      });
    } else {
      if (datauser[0]['level'] == 'admin') {
        setState(() {
          msg = "Login Member Success";
          isLoginSuccess = true;
        });
        Navigator.pushReplacementNamed(context, '/HomePage');
      } else if (datauser[0]['level'] == 'member') {
        setState(() {
          msg = "Login Member Success";
          isLoginSuccess = true;
        });
        Navigator.pushReplacementNamed(context, '/HomePage');
      }
      setState(() {
        username = datauser[0]['username'];
      });
      SnackBar snackBar = SnackBar(
        content: Text(msg),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Login Page"),
        ),
        body: Stack(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 10.0),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Image.asset(
                'lib/models/images/263d53ed14ea33255b11d342a25c20d4.jpg',
                fit: BoxFit.fill,
              ),
            ),
            Center(
              child: Column(
                children: [
                  SizedBox(height: 200),
                  _usernameField(),
                  _passwordField(),
                  _loginButton(context),
                  _Register(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _usernameField() {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: TextFormField(
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black,
            fontSize: 20.0,
          ),
          controller: user,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white70,
            hintStyle: TextStyle(fontSize: 20.0, color: Colors.black),
            hintText: "Username",
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                borderSide: BorderSide(
                    color: (isLoginSuccess) ? Colors.blue : Colors.red)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                borderSide: BorderSide(color: Colors.green)),
          ),
        ));
  }

  Widget _passwordField() {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: TextFormField(
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20.0, color: Colors.black),
          controller: pass,
          obscureText: true,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white70,
            hintStyle: TextStyle(fontSize: 20.0, color: Colors.black),
            hintText: "Password",
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                borderSide: BorderSide(
                    color: (isLoginSuccess) ? Colors.blue : Colors.red)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                borderSide: BorderSide(color: Colors.green)),
          ),
        ));
  }

  Widget _loginButton(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      width: 200.0,
      height: 60.0,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: (isLoginSuccess) ? Colors.blue : Colors.red,
        ),
        // onPressed: () {
        //   String pesan = "";
        //   if (password == "dhimas") {
        //     setState(() {
        //       pesan = "Login Success";
        //       isLoginSuccess = true;
        //     });
        //     Navigator.push(context, MaterialPageRoute(builder: (context) => Firstpage()));
        //   } else {
        //     setState(() {
        //       pesan = "Login Failed";
        //       isLoginSuccess = false;
        //     });
        //   }
        //   SnackBar snackBar = SnackBar(
        //     content: Text(pesan),
        //   );
        //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
        // },
        onPressed: () {
          _login();
        },
        child: Text('Login'),
      ),
    );
  }

  Widget _Register(BuildContext context) {
    return Container(
        child: TextButton(
      child: Text('Create New Account'),
      onPressed: () {
        Navigator.pushReplacementNamed(context, '/Register');
      },
    ));
  }
}
