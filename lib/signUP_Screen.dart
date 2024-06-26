import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'package:myapp/userModel.dart';


class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  Future<void> _signup() async {
    final username = _usernameController.text;
    final password = _passwordController.text;
    final email = _emailController.text;

    var bytes = utf8.encode(password);
    var hashedPassword = sha256.convert(bytes).toString();

    final userBox = Hive.box<User>('users');
    userBox.add(User()
      ..username = username
      ..password = hashedPassword
      ..email = email);

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 248, 217, 37),
      appBar: AppBar(
        title: Text('Signup'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: <Widget>[
              TextField(
                controller: _usernameController,
                decoration: InputDecoration(labelText: 'User Name',
                focusedBorder: OutlineInputBorder(
                  borderSide:const BorderSide(
                    color: Color.fromARGB(255, 134, 134, 134),
                    width: 2.0,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide:const BorderSide(
                    color: Colors.grey,
                    width: 2.0,
                  ),
                  borderRadius: BorderRadius.circular(10.0)
                )
                ),
              ),
              SizedBox(height: 10,),
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: 'Password',
                
                focusedBorder: OutlineInputBorder(
                  borderSide:const BorderSide(
                    color: Color.fromARGB(255, 134, 134, 134),
                    width: 2.0,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide:const BorderSide(
                    color: Colors.grey,
                    width: 2.0,
                  ),
                  borderRadius: BorderRadius.circular(10.0)
                )
                ),
                obscureText: true,
                
              ),
              SizedBox(height: 10,),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email',
                focusedBorder: OutlineInputBorder(
                  borderSide:const BorderSide(
                    color: Color.fromARGB(255, 134, 134, 134),
                    width: 2.0,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide:const BorderSide(
                    color: Colors.grey,
                    width: 2.0,
                  ),
                  borderRadius: BorderRadius.circular(10.0)
                )
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _signup,
                child: Text('Signup'),
              ),
              SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Already have an account? Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

