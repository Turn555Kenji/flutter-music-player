import 'package:flutter/material.dart';
import 'dart:io';

class MusicItem extends StatelessWidget {
  final int id;
  final String name;
  final String artist;
  final Duration duration;
  final String? coverUrl;
  final void Function()? onPressed;

  const MusicItem({
    super.key,
    required this.id,
    required this.name,
    required this.artist,
    required this.duration,
    this.onPressed,
    this.coverUrl,
  });

  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: coverUrl != null && coverUrl!.isNotEmpty
                ? Image.file(File(coverUrl!), width: 48, height: 48, fit: BoxFit.cover)
                : Container(width: 48, height: 48, color: Colors.grey, child: Icon(Icons.music_note)),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    artist,
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
            Text(_formatDuration(duration)),
          ],
        ),
      ),
    );
  }
}