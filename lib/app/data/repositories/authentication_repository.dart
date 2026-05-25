import 'package:music_player/app/data/database/database_service.dart';

class AuthRepository {
  final DatabaseService _databaseService = DatabaseService();

  int? _currentUserId;

  int? get currentUserId => _currentUserId;
  bool get isLoggedIn => _currentUserId != null;

  Future<bool> login(String username, String password) async {
    final user = await _databaseService.getUserByName(username);

    if (user == null) return false;
    if (user['password'] != password) return false;

    _currentUserId = user['id'] as int;
    return true;
  }

  Future<bool> register(String username, String password) async {
    final existing = await _databaseService.getUserByName(username);
    if (existing != null) return false;

    final id = await _databaseService.insertUser(username, password);
    _currentUserId = id;
    return true;
  }

  void logout() {
    _currentUserId = null;
  }
}