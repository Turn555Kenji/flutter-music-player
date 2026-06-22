import 'package:flutter/material.dart';
import 'package:music_player/app/data/repositories/authentication_repository.dart';

class AuthViewmodel extends ChangeNotifier {
  final AuthRepository authRepository;

  bool isCheckingSession = true;
  bool isLoading = false;
  String? errorMessage;

  AuthViewmodel({required this.authRepository});

  int? get currentUserId => authRepository.currentUserId;
  bool get isLoggedIn => authRepository.isLoggedIn;

  Future<bool> login(String username, String password) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    final success = await authRepository.login(username, password);

    if (!success) {
      errorMessage = 'Invalid username or password';
    }

    isLoading = false;
    notifyListeners();
    return success;
  }

  Future<bool> register(String username, String password) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    final success = await authRepository.register(username, password);

    if (!success) {
      errorMessage = 'Username already taken';
    }

    isLoading = false;
    notifyListeners();
    return success;
  }

  Future<void> checkSession() async {
    isCheckingSession = true;
    notifyListeners();

    await authRepository.checkSession();

    isCheckingSession = false;
    notifyListeners();
  }

  Future<void> logout() async {
    await authRepository.logout();
    notifyListeners();
  }
}