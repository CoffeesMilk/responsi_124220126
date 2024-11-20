import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:responsi_124220126/models/boxes.dart';
import 'package:responsi_124220126/pages/detailresto.dart';
import 'package:shared_preferences/shared_preferences.dart';

class favresto extends StatefulWidget {
  const favresto({super.key});

  @override
  State<favresto> createState() => _favrestoState();
}

class _favrestoState extends State<favresto> {
  late SharedPreferences logindata;
  Future<Map<String, dynamic>> fetchdetail() async {
    final box = await Hive.openBox(HiveBoxex.user);
    final response = await Dio()
        .get('https://restaurant-api.dicoding.dev/detail/${box.get('id')}');

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

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    fetchfavorite();
  }

  void fetchfavorite() async {
    final box = await Hive.openBox(HiveBoxex.user);
    final currentuser = box.get(logindata.getString('username'));
    if (currentuser != null) {
      List<dynamic> favoriterestaurants = [];
      for (String id in currentuser.like) {
        final response =
            await Dio().get('https://restaurant-api.dicoding.dev/detail/$id');
        if (response.statusCode == 200) {
          favoriterestaurants.add(response.data['restaurant']);
        }
      }
      setState(() {
        listrestofav = favoriterestaurants;
      });
    }
  }

  Map<String, dynamic> detail = {};
  List<dynamic> listrestofav = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite Restoran'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
            child: SingleChildScrollView(
          child: Column(
            children: listrestofav.map((resto) {
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
