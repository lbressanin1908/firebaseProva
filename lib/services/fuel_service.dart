import 'package:cloud_firestore/cloud_firestore.dart';

class FuelService {
  final CollectionReference _fuelCollection =
      FirebaseFirestore.instance.collection('fuel_entries');

  Future<void> addFuelEntry(
      String userId, String date, double liters, int mileage) async {
    await _fuelCollection.add({
      'userId': userId,
      'date': date,
      'liters': liters,
      'mileage': mileage,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  Stream<QuerySnapshot> getUserFuelHistory(String userId) {
    return _fuelCollection.where('userId', isEqualTo: userId).snapshots();
  }
}
