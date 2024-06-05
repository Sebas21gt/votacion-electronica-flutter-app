import 'package:flutter/material.dart';

class VotingTableDelegatePage extends StatelessWidget {
  const VotingTableDelegatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mesa de Sufragio'),
      ),
      body: const Center(
        child: Text('Pantalla de Mesa de Sufragio'),
      ),
    );
  }
}
