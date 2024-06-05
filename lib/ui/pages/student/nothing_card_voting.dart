import 'package:app_vote/ui/main/styles.dart';
import 'package:flutter/material.dart';

class NotYetVotedPage extends StatelessWidget {
  const NotYetVotedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Carnet de Sufragio'),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.how_to_vote,
              size: 100,
              color: primary,
            ),
            SizedBox(height: 20),
            Text(
              'Aún no has votado',
              style: TextStyle(
                fontSize: 24,
                color: primary,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Text(
              'Por favor, vota en las elecciones para obtener tu carnet de sufragio.',
              style: TextStyle(fontSize: 16, color: textColor),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
