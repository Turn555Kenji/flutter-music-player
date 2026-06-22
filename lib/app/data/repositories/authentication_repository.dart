import 'package:music_player/app/data/database/database_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepository {
  final DatabaseService _databaseService = DatabaseService();
  static const _userIdKey = 'userId';

  int? _currentUserId;

  int? get currentUserId => _currentUserId;
  bool get isLoggedIn => _currentUserId != null;

  Future<bool> login(String username, String password) async {
    final user = await _databaseService.getUserByName(username);

    if (user == null) return false;
    if (user['password'] != password) return false;

    _currentUserId = user['id'] as int;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_userIdKey, _currentUserId!);
    return true;
  }

  Future<bool> register(String username, String password) async {
    final existing = await _databaseService.getUserByName(username);
    if (existing != null) return false;

    final id = await _databaseService.insertUser(username, password);
    _currentUserId = id;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_userIdKey, _currentUserId!);
    return true;
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userIdKey);
    _currentUserId = null;
  }

  Future<bool> checkSession() async {
    final prefs = await SharedPreferences.getInstance();
    final savedId = prefs.getInt(_userIdKey);
    if (savedId != null) {
      _currentUserId = savedId;
      return true;
    }
    return false;
  }
}