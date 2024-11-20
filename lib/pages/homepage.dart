import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:responsi_124220126/pages/detailresto.dart';
import 'package:responsi_124220126/pages/loginpage.dart';

import 'package:shared_preferences/shared_preferences.dart';

class homepage extends StatefulWidget {
  const homepage({super.key});

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  int bottomnavselect = 0;
  late SharedPreferences logindata;
  Future<List<dynamic>> fetchlistresto() async {
    final apiresto =
        await Dio().get('https://restaurant-api.dicoding.dev/list');

    if (apiresto.statusCode == 200) {
      return apiresto.data['restaurants'];
    } else {
      throw Exception('Bad request');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchlistresto().then((data) {
      setState(() {
        listresto = data;
      });
    });
    initial();
  }

  void initial() async {
    logindata = await SharedPreferences.getInstance();
  }

  List<dynamic> listresto = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List Restoran'),
        centerTitle: true,
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: new Icon(Icons.logout, color: Colors.black),
            onPressed: () {
              logindata.setBool('login', true);
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => loginpage(
                            username: '',
                            password: '',
                          )));
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
            child: SingleChildScrollView(
          child: Column(
            children: listresto.map((resto) {
              return Card(
                child: Column(
                  children: [
                    Image.network(
                      'https://restaurant-api.dicoding.dev/images/large/${resto['pictureId']}',
                      width: double.infinity,
                      height: 200,
                    ),
                    SizedBox(width: 50),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => detailresto(id: resto['id']),
                          ),
                        );
                      },
                      child: Text('${resto['name']}',
                          style: TextStyle(fontWeight: FontWeight.bold),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2),
                    ),
                    IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  detailresto(id: resto['id']),
                            ),
                          );
                        },
                        icon: Icon(Icons.arrow_forward)),
                  ],
                ),
              );
            }).toList(),
          ),
        )),
      ),
    );
  }
}
