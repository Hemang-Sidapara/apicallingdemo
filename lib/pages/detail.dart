
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../models/retrieve_model.dart';

class Detail extends StatelessWidget {
  const Detail(BuildContext context, {Key? key, required this.nowplayingModel, required this.index}) : super(key: key);

  final List<Results> nowplayingModel;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: <Color>[Color(0xFF87cca5), Color(0xFF66c6b5), Color(0xFF3bbeca), Color(0xFF1db8d7)],
            ),
          ),
        ),
        title: Text("${nowplayingModel[index].title.toString()} (${nowplayingModel[index].releaseDate.toString().split('-')[0]})"),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: CachedNetworkImage(
                  imageUrl: 'https://image.tmdb.org/t/p/w500${nowplayingModel[index].posterPath}',
                  height: 350,
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                  progressIndicatorBuilder: (context, url, progress) => Center(
                    child: CircularProgressIndicator(
                      value: progress.progress,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Overview:',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                nowplayingModel[index].overview.toString(),
                style: const TextStyle(
                  fontSize: 17,
                  fontStyle: FontStyle.italic,
                ),softWrap: true,
                overflow: TextOverflow.fade,
              )
            ],
          ),
        ),
      ),
    );
  }
}
