import 'package:app_vote/providers/auth_provider.dart';
import 'package:app_vote/ui/main/routes.dart';
import 'package:app_vote/ui/main/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    final token = authState['token'];
    final selectedRole = authState['selectedRole'];

    return MaterialApp.router(
      routerDelegate: RoutemasterDelegate(
        routesBuilder: (context) {
          if (token != null) {
            if (selectedRole != null) {
              return authenticatedRoutes(selectedRole);
            } else {
              return authRoutes;
            }
          }
          return authRoutes;
        },
      ),
      routeInformationParser: const RoutemasterParser(),
      debugShowCheckedModeBanner: false,
      theme: _buildThemeData(),
    );
  }

  ThemeData _buildThemeData() {
    return ThemeData(
      brightness: Brightness.light,
      fontFamily: textTheme,
      scaffoldBackgroundColor: backgroundColor,
      colorScheme: ColorScheme.fromSeed(
        seedColor: secondary,
        primary: primary,
        secondary: secondary,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: primary,
        foregroundColor: Colors.white,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        elevation: 10.0,
      ),
      canvasColor: Colors.white,
      appBarTheme: const AppBarTheme(
        titleTextStyle: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 20.0,
          fontFamily: textTheme,
        ),
        color: primary,
        surfaceTintColor: primary,
        centerTitle: false,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      dialogTheme: const DialogTheme(
        surfaceTintColor: Colors.white,
      ),
      datePickerTheme: const DatePickerThemeData(
        surfaceTintColor: Colors.white,
      ),
      useMaterial3: true,
      tabBarTheme: const TabBarTheme(
        labelColor: Colors.white,
        labelStyle: TextStyle(
          fontWeight: FontWeight.w600,
          fontFamily: textTheme,
        ),
        unselectedLabelColor: textSecondary,
        unselectedLabelStyle: TextStyle(
          fontWeight: FontWeight.normal,
          fontFamily: textTheme,
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        tabAlignment: TabAlignment.start,
        dividerHeight: 0.0,
      ),
      snackBarTheme: const SnackBarThemeData(
        contentTextStyle: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 16.0,
          fontFamily: textTheme,
        ),
      ),
    );
  }
}
