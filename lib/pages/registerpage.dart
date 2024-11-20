import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:responsi_124220126/pages/loginpage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:responsi_124220126/models/boxes.dart';
import 'package:responsi_124220126/models/user.dart';

class registerpage extends StatefulWidget {
  registerpage({super.key});

  @override
  State<registerpage> createState() => _registerpageState();
}

class _registerpageState extends State<registerpage> {
  bool visible = true;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late String username;
  late String password;
  late String username_controler;
  late String password_controler;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsetsDirectional.symmetric(
                    horizontal: 20, vertical: 10),
                child: TextFormField(
                  onChanged: (value) {
                    username_controler = value;
                  },
                  decoration: InputDecoration(
                    label: Container(
                      width: 100,
                      child: Row(
                        children: [
                          Icon(Icons.person),
                          Text('username'),
                        ],
                      ),
                    ),
                    filled: true,
                    contentPadding: EdgeInsets.all(8.0),
                    border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0))),
                  ),
                  validator: (String? value) {
                    if (value == null || value.trim().length == 0) {
                      return "username tidak boleh kosong";
                    }
                    return null;
                  },
                ),
              ),
              Container(
                margin: EdgeInsetsDirectional.symmetric(
                    horizontal: 20, vertical: 10),
                child: TextFormField(
                  onChanged: (value) {
                    password_controler = value;
                  },
                  obscureText: visible,
                  decoration: InputDecoration(
                    suffix: IconButton(
                        onPressed: () {
                          setState(() {
                            visible = !visible;
                          });
                        },
                        icon: visible
                            ? Icon(Icons.visibility_off)
                            : Icon(Icons.visibility)),
                    filled: true,
                    contentPadding: EdgeInsets.all(8.0),
                    label: Container(
                      width: 100,
                      child: Row(
                        children: [
                          Icon(Icons.lock),
                          Text('Password'),
                        ],
                      ),
                    ),
                    border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0))),
                  ),
                  validator: (String? value) {
                    if (value == null || value.trim().length == 0) {
                      return "password tidak boleh kosong";
                    }
                    return null;
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                      child: ElevatedButton(
                          onPressed: () {
                            validated();
                            debugPrint('username: $username_controler');
                            debugPrint('password: $password_controler');
                          },
                          child: Text('Register'))),
                  Container(
                      padding: EdgeInsets.symmetric(horizontal: 50),
                      child: TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => loginpage()));
                          },
                          child: Text('Login'))),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void register() async {
    final box = await Hive.openBox(HiveBoxex.user);
    box.add(user(username: username_controler, password: password_controler));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Register berhasil')),
    );
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => loginpage()));
  }

  validated() {
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      register();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Data harus diisi semua')),
      );
      return;
    }
  }
}
