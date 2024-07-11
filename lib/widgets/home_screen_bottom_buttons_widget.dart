import 'package:flutter/material.dart';
import 'package:unyo/screens/screens.dart';
import 'package:unyo/widgets/widgets.dart';

class HomeScreenBottomButtonsWidget extends StatelessWidget {
  const HomeScreenBottomButtonsWidget(
      {super.key, required this.adjustedHeight, required this.adjustedWidth, required this.episodesWatched, this.minutesWatched, required this.userStatsNull, required this.getUserCharts});

  final double adjustedWidth;
  final double adjustedHeight;
  final int? episodesWatched;
  final int? minutesWatched;
  final bool userStatsNull;
  final List<Widget> Function() getUserCharts;  

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              AnimeButton(
                text: "Anime List",
                onTap: () {
                  //animeListScreen
                  goTo(3);
                },
                width: adjustedWidth,
                height: adjustedHeight,
                horizontalAllignment: false,
              ),
              const SizedBox(
                height: 30,
              ),
              AnimeButton(
                text: "Manga List",
                onTap: () {
                  //mangaListScreen
                  goTo(4);
                },
                width: adjustedWidth,
                height: adjustedHeight,
                horizontalAllignment: false,
              ),
              const SizedBox(
                height: 30,
              ),
              AnimeButton(
                text: "Calendar",
                onTap: () {
                  //calendarScreen
                  goTo(5);
                },
                width: adjustedWidth,
                height: adjustedHeight,
                horizontalAllignment: false,
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: adjustedWidth * 0.05),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      "Episodes Watched: ${episodesWatched ?? -1}",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Hours Watched: ${(minutesWatched! ~/ 60)}",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              userStatsNull 
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [...getUserCharts()],
                    )
                  : const SizedBox(),
            ],
          ),
        ),
      ],
    );
  }
}
