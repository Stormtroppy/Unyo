import 'package:flutter/material.dart';

class EpisodeButton extends StatelessWidget {
  const EpisodeButton({super.key, required this.episodeNumber, required this.onTap, required this.latestEpisode});

  final num episodeNumber;
  final int latestEpisode;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: latestEpisode >= episodeNumber ? onTap : null,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Divider(
            height: 0,
            thickness: 2,
            color: const Color.fromARGB(255, 34, 33, 34),
            endIndent: MediaQuery.of(context).size.width * 0.05,
            indent: MediaQuery.of(context).size.width * 0.05,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.03, vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Episode $episodeNumber",
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
                Text(
                  latestEpisode >= episodeNumber ? "Released" : "Not yet released" ,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: latestEpisode >= episodeNumber ? FontWeight.bold : FontWeight.normal,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
