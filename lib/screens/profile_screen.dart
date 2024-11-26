import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileScreen extends StatelessWidget {
  final User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Perfil')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Nome: ${user?.displayName ?? 'Não definido'}'),
            Text('Email: ${user?.email}'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // TODO: Implementar atualização de perfil
              },
              child: Text('Atualizar Dados'),
            ),
          ],
        ),
      ),
    );
  }
}
