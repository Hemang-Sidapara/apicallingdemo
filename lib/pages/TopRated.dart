// ignore_for_file: file_names

import 'package:apicallingdemo/models/retrieve_model.dart';
import 'package:apicallingdemo/pages/detail.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class TopRated extends StatelessWidget {
  const TopRated({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Top Rated'),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: <Color>[Color(0xFF87cca5), Color(0xFF66c6b5), Color(0xFF3bbeca), Color(0xFF1db8d7)],
            ),
          ),
        ),
      ),
      body: FutureBuilder<dynamic>(
        future: getUser(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Results> posts = snapshot.data;
            return ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return Detail(
                            context,
                            nowplayingModel: posts,
                            index: index,
                          );
                        },
                      ),
                    );
                  },
                  child: Card(
                    elevation: 4,
                    child: Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.all(5),
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
                                  posts[index].title.toString(),
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
                                  posts[index].overview.toString(),
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
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            if (snapshot.error.toString().trim().contains('SocketException')) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return Text(
                snapshot.error.toString(),
                style: const TextStyle(fontSize: 16),
              );
            }
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

Future<List<Results>?> getUser() async {
  const url = 'https://api.themoviedb.org/3/movie/top_rated?api_key=4cfe6fa1a4e1f45fbffc0c62df06ba87&language=en-US&page=1';
  Response response = await get(Uri.parse(url));

  var jsonUser = response.body;
  final popular = retrieveModelFromJson(jsonUser);
  return popular.results;
}
