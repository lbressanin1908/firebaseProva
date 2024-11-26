import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/fuel_service.dart';

class FuelHistoryScreen extends StatelessWidget {
  final FuelService _fuelService = FuelService();

  @override
  Widget build(BuildContext context) {
    final String userId = FirebaseAuth.instance.currentUser!.uid;

    return Scaffold(
      appBar: AppBar(title: Text('Histórico de Abastecimentos')),
      body: StreamBuilder<QuerySnapshot>(
        stream: _fuelService.getUserFuelHistory(userId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('Nenhum abastecimento registrado.'));
          }

          final fuelEntries = snapshot.data!.docs;

          return ListView.builder(
            itemCount: fuelEntries.length,
            itemBuilder: (context, index) {
              final fuel = fuelEntries[index];
              return ListTile(
                title: Text('Data: ${fuel['date']}'),
                subtitle: Text(
                    'Litros: ${fuel['liters']} | Quilometragem: ${fuel['mileage']}'),
              );
            },
          );
        },
      ),
    );
  }
}
