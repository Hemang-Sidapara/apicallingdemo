// ignore_for_file: file_names

import 'package:apicallingdemo/pages/NowPlaying.dart';
import 'package:apicallingdemo/pages/Popular.dart';
import 'package:apicallingdemo/pages/TopRated.dart';
import 'package:apicallingdemo/pages/Upcoming.dart';
import 'package:apicallingdemo/provider/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeProvider>(
      create: (context) => HomeProvider(),
      child: Consumer<HomeProvider>(
        builder: (context, provider, child) {
          return Scaffold(
            body: SafeArea(
              child: IndexedStack(
                index: provider.tabIndex,
                children: const [
                  Popular(),
                  NowPlaying(),
                  Upcoming(),
                  TopRated(),
                ],
              ),
            ),
            bottomNavigationBar: BottomNavigationBar(
              onTap: provider.changeTabIndex,
              currentIndex: provider.tabIndex,
              items: const [
                BottomNavigationBarItem(
                  backgroundColor: Color(0xFF87cca5),
                  icon: Icon(Icons.star),
                  label: 'Popular',
                ),
                BottomNavigationBarItem(
                  backgroundColor: Color(0xFF66c6b5),
                  icon: Icon(Icons.play_arrow),
                  label: 'Now Playing',
                ),
                BottomNavigationBarItem(
                  backgroundColor: Color(0xFF3bbeca),
                  icon: Icon(Icons.upcoming),
                  label: 'Upcoming',
                ),
                BottomNavigationBarItem(
                  backgroundColor: Color(0xFF1db8d7),
                  icon: Icon(Icons.favorite),
                  label: 'Top Rated',
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
