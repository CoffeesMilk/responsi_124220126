import 'package:flutter/material.dart';
import 'package:responsi_124220126/models/boxes.dart';
import 'package:responsi_124220126/pages/homepage.dart';
import 'package:responsi_124220126/pages/registerpage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';

class loginpage extends StatefulWidget {
  loginpage({super.key});

  @override
  State<loginpage> createState() => _loginpageState();
}

class _loginpageState extends State<loginpage> {
  bool visible = true;
  late SharedPreferences logindata;
  late bool newuser;
  String username_controler = '';
  String password_controler = '';
  @override
  void initState() {
    super.initState();
    check_if_already_login();
  }

  void check_if_already_login() async {
    logindata = await SharedPreferences.getInstance();
    newuser = (logindata.getBool('login') ?? true);
    if (newuser == false) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => homepage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin:
                  EdgeInsetsDirectional.symmetric(horizontal: 20, vertical: 10),
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
              ),
            ),
            Container(
              margin:
                  EdgeInsetsDirectional.symmetric(horizontal: 20, vertical: 10),
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
                  label: Container(
                    width: 100,
                    child: Row(
                      children: [
                        Icon(Icons.lock),
                        Text('Password'),
                      ],
                    ),
                  ),
                  contentPadding: EdgeInsets.all(8.0),
                  border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8.0))),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                    child: ElevatedButton(
                        onPressed: () {
                          login();
                        },
                        child: Text('Login'))),
                Container(
                    padding: EdgeInsets.symmetric(horizontal: 50),
                    child: TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => registerpage()));
                        },
                        child: Text('Register'))),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void login() async {
    final box = await Hive.openBox(HiveBoxex.user);
    final user = box.values.firstWhere(
        (user) =>
            user.username == username_controler &&
            user.password == password_controler,
        orElse: () => null);

    if (user != null) {
      logindata.setString('username', user.username);
      logindata.setBool('login', false);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => homepage()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Invalid username or password')),
      );
    }
  }
}
