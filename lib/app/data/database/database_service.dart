import 'package:music_player/app/data/database/database_helper.dart';

class DatabaseService {
  final DatabaseHelper _helper = DatabaseHelper();

  // ─── Users ───────────────────────────────────────────

  Future<int> insertUser(String email, String password) async {
    final db = await _helper.database;
    return await db.insert('Users', {
      'email': email,
      'password': password,
      'created_at': DateTime.now().toIso8601String(),
    });
  }

  Future<Map<String, dynamic>?> getUserByEmail(String email) async {
    final db = await _helper.database;
    final result = await db.query(
      'Users',
      where: 'email = ?',
      whereArgs: [email],
    );
    return result.isNotEmpty ? result.first : null;
  }

  // ─── Playlists ────────────────────────────────────────

  Future<int> insertPlaylist(int userId, String name, String? description, String? coverUrl) async {
    final db = await _helper.database;
    return await db.insert('Playlists', {
      'user_id': userId,
      'name': name,
      'description': description,
      'cover_url': coverUrl,
      'created_at': DateTime.now().toIso8601String(),
    });
  }

  Future<List<Map<String, dynamic>>> getPlaylists(int userId) async {
    final db = await _helper.database;
    return await db.query(
      'Playlists',
      where: 'user_id = ?',
      whereArgs: [userId],
    );
  }

  Future<void> updatePlaylist(int id, String name, String? description) async {
    final db = await _helper.database;
    await db.update(
      'Playlists',
      {
        'name': name,
        'description': description,
      },
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> deletePlaylist(int id) async {
    final db = await _helper.database;
    await db.delete(
      'Playlists',
      where: 'id = ?',
      whereArgs: [id],
    );
    // also delete all songs in the playlist
    await db.delete(
      'PlaylistSongs',
      where: 'playlist_id = ?',
      whereArgs: [id],
    );
  }

  // ─── PlaylistSongs ────────────────────────────────────

  Future<void> insertPlaylistSong(int playlistId, String songPath, int position) async {
    final db = await _helper.database;
    await db.insert('PlaylistSongs', {
      'playlist_id': playlistId,
      'song_path': songPath,
      'position': position,
    });
  }

  Future<List<Map<String, dynamic>>> getPlaylistSongs(int playlistId) async {
    final db = await _helper.database;
    return await db.query(
      'PlaylistSongs',
      where: 'playlist_id = ?',
      whereArgs: [playlistId],
      orderBy: 'position ASC',
    );
  }

  Future<void> deletePlaylistSongs(int playlistId) async {
    final db = await _helper.database;
    await db.delete(
      'PlaylistSongs',
      where: 'playlist_id = ?',
      whereArgs: [playlistId],
    );
  }
}