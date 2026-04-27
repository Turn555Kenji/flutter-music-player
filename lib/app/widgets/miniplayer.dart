import 'package:flutter/material.dart';

class MiniPlayer extends StatelessWidget {
  final bool isPlaying;
  final Duration currTime;
  final Duration totalTime;
  final VoidCallback onPlayPause;
  final VoidCallback onNext;
  final VoidCallback onPrevious;
  final VoidCallback onTap;

  const MiniPlayer({
    super.key,
    required this.isPlaying,
    required this.currTime,
    required this.totalTime,
    required this.onPlayPause,
    required this.onNext,
    required this.onPrevious,
    required this.onTap,
  });

  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    final progress = totalTime.inSeconds > 0
        ? currTime.inSeconds / totalTime.inSeconds
        : 0.0;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: Colors.grey[900],
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [

            LinearProgressIndicator(
              value: progress,
              minHeight: 3,
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(Icons.skip_previous),
                    onPressed: onPrevious,
                  ),

                  IconButton(
                    icon: Icon(
                      isPlaying ? Icons.pause : Icons.play_arrow,
                    ),
                    onPressed: onPlayPause,
                  ),

                  IconButton(
                    icon: Icon(Icons.skip_next),
                    onPressed: onNext,
                  ),

                  Text(
                    _formatDuration(currTime),
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}