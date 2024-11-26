import 'package:cloud_firestore/cloud_firestore.dart';

class VehicleService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Método para excluir um veículo
  Future<void> deleteVehicle(String vehicleId) async {
    try {
      await _db.collection('veiculos').doc(vehicleId).delete();
    } catch (e) {
      print('Erro ao excluir veículo: $e');
      throw e;
    }
  }

  // Outros métodos, como getUserVehicles(), etc.
}
