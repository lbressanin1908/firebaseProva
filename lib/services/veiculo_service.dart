import 'package:cloud_firestore/cloud_firestore.dart';

class VehicleService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final CollectionReference _vehiclesCollection =
      FirebaseFirestore.instance.collection('vehicles');

  Future<void> addVehicle(String userId, String nome, String modelo, String ano,
      String placa) async {
    await _vehiclesCollection.add({
      'userId': userId,
      'nome': nome,
      'modelo': modelo,
      'ano': ano,
      'placa': placa,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  Stream<QuerySnapshot> getUserVehicles(String userId) {
    return _vehiclesCollection.where('userId', isEqualTo: userId).snapshots();
  }

  Future<void> deleteVehicle(String vehicleId) async {
    try {
      await _vehiclesCollection.doc(vehicleId).delete();
    } catch (e) {
      print('Erro ao excluir veículo: $e');
      throw e;
    }
  }
}
