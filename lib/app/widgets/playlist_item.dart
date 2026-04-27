import 'package:flutter/material.dart';

class PlaylistItem extends StatelessWidget {
  final String name;
  final String coverUrl;
  final String details;
  final void Function()? onPressed;

  const PlaylistItem({
    super.key,
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
            Container( //change to cover
              width: 48,
              height: 48,
              color: Colors.grey,
              child: Icon(Icons.music_note)
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
              )
            )
          ],
        )
      )
    );
  }
}
