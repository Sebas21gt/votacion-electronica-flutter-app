import 'package:app_vote/ui/main/styles.dart';
import 'package:flutter/material.dart';

class AlreadyVotePage extends StatelessWidget {
  const AlreadyVotePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Votación'),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.how_to_vote,
              size: 100,
              color: Colors.red,
            ),
            SizedBox(height: 20),
            Text(
              'Usted ya voto',
              style: TextStyle(
                fontSize: 24,
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Text(
              'Gracias por participar en las elecciones. Tu voto han sido registrado.',
              style: TextStyle(fontSize: 16, color: textColor),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
