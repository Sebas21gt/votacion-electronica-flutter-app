import 'package:app_vote/ui/main/styles.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Vote',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        fontFamily: textTheme.fontFamily,
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
          color: primary,
          surfaceTintColor: primary,
          centerTitle: false,
        ),
        dialogTheme: const DialogTheme(
          surfaceTintColor: Colors.white,
        ),
        datePickerTheme: const DatePickerThemeData(
          surfaceTintColor: Colors.white,
        ),
        useMaterial3: true,
        tabBarTheme: TabBarTheme(
          labelColor: Colors.white,
          labelStyle: TextStyle(
            fontWeight: FontWeight.w600,
            fontFamily: textTheme.fontFamily,
          ),
          unselectedLabelColor: textSecondary,
          unselectedLabelStyle: TextStyle(
            fontWeight: FontWeight.normal,
            fontFamily: textTheme.fontFamily,
          ),
          indicatorSize: TabBarIndicatorSize.tab,
          tabAlignment: TabAlignment.start,
          dividerHeight: 0.0,
          // indicator: const BubbleTabIndicator(
          //   indicatorHeight: 35.0,
          //   indicatorColor: primary,
          //   tabBarIndicatorSize: TabBarIndicatorSize.tab,
          //   insets: EdgeInsets.zero,
          // ),
        ),
        snackBarTheme: SnackBarThemeData(
          contentTextStyle: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16.0,
            fontFamily: textTheme.fontFamily,
          ),
        ),
        filledButtonTheme: FilledButtonThemeData(
          style: ButtonStyle(
            // padding: paddingButton,
            textStyle: textStyleButton,
            foregroundColor: const MaterialStatePropertyAll(Colors.white),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            // padding: paddingButton,
            textStyle: textStyleButton,
            foregroundColor: const MaterialStatePropertyAll(primary),
          ),
        ),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Material App Bar'),
        ),
        body: const Center(
          child: Text('Hello World'),
        ),
      ),
    );
  }
}
