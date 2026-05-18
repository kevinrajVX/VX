import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthState {
  const AuthState({this.username, this.isAuthenticated = false});

  final String? username;
  final bool isAuthenticated;
}

class AuthNotifier extends Notifier<AuthState> {
  @override
  AuthState build() => const AuthState();

  Future<bool> login(String username, String password) async {
    // Always reset the existing session before authenticating with new
    // credentials. Without this reset, a session under one username would
    // block connecting under a different username.
    state = const AuthState();

    await Future.delayed(const Duration(milliseconds: 600));

    if (username.trim().isEmpty || password.trim().isEmpty) {
      return false;
    }

    state = AuthState(username: username.trim(), isAuthenticated: true);
    return true;
  }

  void logout() {
    state = const AuthState();
  }
}

final authProvider =
    NotifierProvider<AuthNotifier, AuthState>(AuthNotifier.new);
