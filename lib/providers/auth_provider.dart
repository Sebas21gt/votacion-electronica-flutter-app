// ignore_for_file: inference_failure_on_function_invocation, use_build_context_synchronously, avoid_dynamic_calls

import 'dart:convert';

import 'package:app_vote/ui/main/global.dart';
import 'package:app_vote/ui/main/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:routemaster/routemaster.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthNotifier extends StateNotifier<Map<String, String?>> {
  AuthNotifier() : super({'token': null, 'selectedRole': null}) {
    _loadToken();
  }

  Future<void> login(
    String username,
    String password,
    BuildContext context,
  ) async {
    const url = '${GlobalConfig.baseUrl}/auth/login';
    print('Login request to: $url');
    try {
      print('Username: $username, Password: $password');
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'username': username, 'password': password}),
      );

      print('Entra aquiii');

      if (response.statusCode == 201) {
        final data = jsonDecode(response.body);
        final token = data['access_token'];
        await _storeToken(token as String);
        state = {'token': token, 'selectedRole': null};
        await _validateRoleAndNavigate(token, context);
      } else {
        _showError(
            context, 'Credenciales incorrectas. Por favor intente de nuevo.');
      }
    } catch (e) {
      _showError(
          context, 'Error al iniciar sesión. Por favor intente de nuevo.');
    }
  }

  Future<void> _storeToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('jwt', token);
  }

  Future<void> _validateRoleAndNavigate(
    String token,
    BuildContext context,
  ) async {
    final decodedToken = JwtDecoder.decode(token);
    final roles = decodedToken['roles'] as List<dynamic>? ?? [];

    if (roles.contains(GlobalConfig.studentRoleId) &&
        roles.contains(GlobalConfig.delegateRoleId)) {
      _showRoleSelectionDialog(context, roles);
    } else if (roles.contains(GlobalConfig.studentRoleId)) {
      state = {'token': token, 'selectedRole': GlobalConfig.studentRoleId};
      print('Token: $token');
      print('Student role selected');
      Routemaster.of(context).replace(RoutePaths.studentMenu);
    } else if (roles.contains(GlobalConfig.delegateRoleId)) {
      state = {'token': token, 'selectedRole': GlobalConfig.delegateRoleId};
      print('Token: $token');
      print('Delegate role selected');
      Routemaster.of(context).replace(RoutePaths.delegateMenu);
    } else {
      Routemaster.of(context).replace(RoutePaths.login);
    }
  }

  Future<void> _loadToken() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('jwt');
    final onboardingShown = prefs.getBool('onboardingShown') ?? false;

    if (!onboardingShown) {
      state = {'token': null, 'selectedRole': null};
      return;
    }

    if (token != null && !JwtDecoder.isExpired(token)) {
      state = {'token': token, 'selectedRole': null};
    }
  }

  Future<void> logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('jwt');
    state = {'token': null, 'selectedRole': null};
    Routemaster.of(context).replace(RoutePaths.login);
  }

  void _showError(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  void _showRoleSelectionDialog(BuildContext context, List<dynamic> roles) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Seleccione un Rol'),
          content: const Text(
              'Tiene múltiples roles. Seleccione uno para continuar.'),
          actions: [
            if (roles.contains(GlobalConfig.studentRoleId))
              TextButton(
                onPressed: () {
                  state = {
                    'token': state['token'],
                    'selectedRole': GlobalConfig.studentRoleId,
                  };
                  Navigator.pop(context);
                  Routemaster.of(context).replace(RoutePaths.studentMenu);
                },
                child: const Text('Estudiante'),
              ),
            if (roles.contains(GlobalConfig.delegateRoleId))
              TextButton(
                onPressed: () {
                  state = {
                    'token': state['token'],
                    'selectedRole': GlobalConfig.delegateRoleId,
                  };
                  Navigator.pop(context);
                  Routemaster.of(context).replace(RoutePaths.delegateMenu);
                },
                child: const Text('Delegado'),
              ),
          ],
        );
      },
    );
  }

  Future<void> completeOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onboardingShown', true);
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, Map<String, String?>>(
  (ref) => AuthNotifier(),
);

final passwordVisibilityProvider =
    StateNotifierProvider<PasswordVisibilityNotifier, bool>(
  (ref) => PasswordVisibilityNotifier(),
);

class PasswordVisibilityNotifier extends StateNotifier<bool> {
  PasswordVisibilityNotifier() : super(true);

  void toggleVisibility() {
    state = !state;
  }
}
