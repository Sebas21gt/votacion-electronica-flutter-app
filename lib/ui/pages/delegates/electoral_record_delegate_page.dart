import 'package:flutter/material.dart';

class ElectoralRecordDelegatePage extends StatelessWidget {
  const ElectoralRecordDelegatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Acta de Escrutinio'),
      ),
      body: const Center(
        child: Text('Pantalla de Acta de Escrutinio'),
      ),
    );
  }
}
