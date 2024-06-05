import 'package:flutter/material.dart';

class ResultVotingPage extends StatelessWidget {
  const ResultVotingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Resultado de votación'),
      ),
      body: const Center(
        child: Text(
          'Resultado de votación',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
