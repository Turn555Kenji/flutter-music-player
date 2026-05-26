import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

class PlaylistItem extends StatelessWidget {
  final int id;
  final String name;
  final String coverUrl;
  final String details;
  final void Function()? onPressed;

  const PlaylistItem({
    super.key,
    required this.id,
    required this.name,
    required this.coverUrl,
    required this.details,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            QueryArtworkWidget(
              id: id,
              type: ArtworkType.ALBUM,
              nullArtworkWidget: Container(
                width: 48,
                height: 48,
                color: Colors.grey,
                child: Icon(Icons.music_note),
              ),
              artworkWidth: 48,
              artworkHeight: 48,
              artworkFit: BoxFit.cover,
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
                    details,
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