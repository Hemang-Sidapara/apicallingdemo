import 'dart:convert';
import 'package:apicallingdemo/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:cached_network_image/cached_network_image.dart';

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
          title: const Text('The MovieDB'),
        ),
        body: const HttpScreen(),
      ),
    );
  }
}

class HttpScreen extends StatefulWidget {
  const HttpScreen({Key? key}) : super(key: key);

  @override
  State<HttpScreen> createState() => _HttpScreenState();
}

class _HttpScreenState extends State<HttpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder<dynamic>(
          future: getUser(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Result> posts = snapshot.data;
              return ListView.builder(
                itemCount: posts.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 4,
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.all(5),
                          height: 220,
                          width: 146,
                          child: CachedNetworkImage(
                            imageUrl: 'https://image.tmdb.org/t/p/w500${posts[index].posterPath}',
                            errorWidget: (context, url, error) => const Icon(Icons.error),
                            progressIndicatorBuilder: (context, url, progress) => Center(
                              child: CircularProgressIndicator(
                                value: progress.progress,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 10),
                          child: Column(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(bottom: 10),
                                width: 200,
                                child: Text(
                                  posts[index].title,
                                  overflow: TextOverflow.fade,
                                  maxLines: 2,
                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 200,
                                child: Text(
                                  posts[index].overview,
                                  overflow: TextOverflow.fade,
                                  maxLines: 7,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Text(
                snapshot.error.toString(),
                style: const TextStyle(fontSize: 16),
              );
            }
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}

Future<List<Result>> getUser() async {
  const url = 'https://api.themoviedb.org/3/movie/popular?api_key=b45cce70bce060e172f3dd4d7f839c55&language=en-US';
  Response response = await get(Uri.parse(url));

  var jsonUser = response.body;
  var data = jsonUser;
  final user = userFromJson(data);
  return user.results;
}
