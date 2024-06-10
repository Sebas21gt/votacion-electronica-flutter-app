// ignore_for_file: use_build_context_synchronously

import 'package:app_vote/domain/entiti/student.model.dart';
import 'package:app_vote/providers/student_provider.dart';
import 'package:app_vote/ui/main/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';

class StudentDataEnablePage extends ConsumerWidget {
  const StudentDataEnablePage({
    required this.student,
    super.key,
  });
  final StudentModel student;
  // final String userId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final careers = student.careers.join(', ');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Habilitar Estudiante'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Nombres: ${student.fullname}',
                    style: _infoStyle,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Carnet Identidad: ${student.ciNumber}',
                    style: _infoStyle,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Carnet Universitario: ${student.collegeNumber}',
                    style: _infoStyle,
                  ),
                  const SizedBox(height: 8),
                  Text('Carrera: $careers', style: _infoStyle),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Text('Estado: ', style: _infoStyle),
                      if (student.isHabilitated)
                        const Chip(
                          label: Text(
                            'Habilitado',
                            style: TextStyle(color: Colors.white),
                          ),
                          backgroundColor: Colors.green,
                        )
                      else
                        const Chip(
                          label: Text(
                            'No Habilitado',
                            style: TextStyle(color: Colors.white),
                          ),
                          backgroundColor: Colors.red,
                        ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.cancel),
                  label: const Text('CANCELAR'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightBlueAccent,
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () async {
                    print('Habilitar estudiante ${student.userId}');
                    await ref
                        .read(studentProvider.notifier)
                        .enableStudent(student.userId);
                    Routemaster.of(context).push(RoutePaths.delegateMenu);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Estudiante habilitado correctamente'),
                        backgroundColor: Colors.green,
                      ),
                    );
                  },
                  icon: const Icon(Icons.check_circle),
                  label: const Text('HABILITAR'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  TextStyle get _infoStyle => const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      );
}
