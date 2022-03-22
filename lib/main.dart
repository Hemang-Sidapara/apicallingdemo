import 'dart:convert';
import 'package:apicallingdemo/models/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

void main() => runApp(const MyApp());

late ScrollController controller;

var modellist;

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Material App Bar'),
        ),
        body: const HttpScreen(),
      ),
    );
  }
}

class HttpScreen extends StatelessWidget {
  const HttpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder<dynamic>(
          future: getUser(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List posts = snapshot.data;
              print(posts);
              return ListView.builder(
                itemCount: posts.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 4,
                    child: ListTile(
                      title: Text(
                        posts[index]['poster_path'],
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(''),
                    ),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Text(snapshot.error.toString(), style: const TextStyle(fontSize: 16),);
            }
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}


Future<dynamic> getUser() async {
  const url = 'https://api.themoviedb.org/3/discover/movie?sort_by=popularity.desc&api_key=4cfe6fa1a4e1f45fbffc0c62df06ba87&page=1';
  Response response = await get(Uri.parse(url));

  var jsonUser = jsonDecode(response.body);
  var data = jsonUser['results'];
  return data;

}
