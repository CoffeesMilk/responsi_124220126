import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:responsi_124220126/models/boxes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:responsi_124220126/models/user.dart';

class detailresto extends StatefulWidget {
  final String id;
  detailresto({super.key, required this.id});

  @override
  State<detailresto> createState() => _detailrestoState();
}

class _detailrestoState extends State<detailresto> {
  bool favorite = false;
  late SharedPreferences logindata;
  Future<Map<String, dynamic>> fetchdetail() async {
    final response = await Dio()
        .get('https://restaurant-api.dicoding.dev/detail/${widget.id}');

    if (response.statusCode == 200) {
      return response.data['restaurant'] as Map<String, dynamic>;
    } else {
      throw Exception('Bad request');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchdetail().then((data) {
      setState(() {
        detail = data;
      });
    });
    initial();
  }

  void initial() async {
    logindata = await SharedPreferences.getInstance();
  }

  Map<String, dynamic> detail = {};
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Restoran'),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(15),
                child: Image.network(
                  'https://restaurant-api.dicoding.dev/images/large/${detail['pictureId']}',
                  width: double.infinity,
                  height: 200,
                ),
              ),
              Container(
                child: Text(
                  '${detail['name']}',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  textAlign: TextAlign.center,
                ),
              ),
              Text('Daerah : ${detail['city']}'),
              Text('Alamat : ${detail['address']}'),
              Text('Rating : ${detail['rating']}'),
              Container(
                padding: EdgeInsets.all(15),
                child: Text(
                  '${detail['description']}',
                ),
              ),
              FutureBuilder(
                future: Hive.openBox(HiveBoxex.user),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    final box = snapshot.data as Box;
                    final currentuser =
                        box.get(logindata.getString('username'));
                    if (currentuser != null &&
                        currentuser.like.contains(widget.id)) {
                      favorite = true;
                    }
                    return IconButton(
                      onPressed: () {
                        setState(() {
                          favorite = !favorite;
                          if (favorite) {
                            addfav();
                          } else {
                            removefav();
                          }
                        });
                      },
                      icon: favorite
                          ? Icon(Icons.favorite)
                          : Icon(Icons.favorite_border),
                    );
                  } else {
                    return CircularProgressIndicator();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void addfav() async {
    final box = await Hive.openBox(HiveBoxex.user);
    final currentuser = box.get(logindata.getString('username'));
    if (currentuser != null) {
      currentuser.like.add(widget.id);
    } else {
      box.put(logindata.getString('username'), user(like: [widget.id]));
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Menambahkan ke favorit')),
    );
  }

  void removefav() async {
    final box = await Hive.openBox(HiveBoxex.user);
    final currentuser = box.get(logindata.getString('username'));
    if (currentuser != null) {
      currentuser.like.remove(widget.id);
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Menghapus dari favorit')),
    );
  }
}
