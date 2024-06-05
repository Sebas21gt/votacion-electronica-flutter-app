import 'package:flutter/material.dart';

class NoAccessPage extends StatelessWidget {
  const NoAccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('No tienes acceso a esta página'),
    );
  }
}