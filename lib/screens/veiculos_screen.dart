import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/veiculo_service.dart';
import 'edit_vehicle_screen.dart'; // Tela de edição
import '../widget/app_drawer.dart';

final _vehicleService = VehicleService();

class VehicleScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userId = FirebaseAuth.instance.currentUser!.uid;

    return Scaffold(
      appBar: AppBar(
        title: Text('Meus Veículos'),
      ),
      drawer: AppDrawer(),
      body: StreamBuilder<QuerySnapshot>(
        stream: _vehicleService.getUserVehicles(userId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('Nenhum veículo cadastrado.'));
          }
          final vehicles = snapshot.data!.docs;

          return ListView.builder(
            itemCount: vehicles.length,
            itemBuilder: (context, index) {
              final vehicle = vehicles[index];
              return ListTile(
                title: Text(vehicle['nome']),
                subtitle: Text('${vehicle['modelo']} - ${vehicle['ano']}'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Botão de Editar
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        // Navega para a tela de edição, passando o ID do veículo
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditVehicleScreen(
                              vehicleId: vehicle.id, // Passando o ID do veículo
                            ),
                          ),
                        );
                      },
                    ),
                    // Botão de Excluir
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () async {
                        // Confirmação antes de excluir
                        bool confirmDelete = await showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Excluir Veículo'),
                                  content: Text(
                                      'Tem certeza que deseja excluir este veículo?'),
                                  actions: <Widget>[
                                    TextButton(
                                      child: Text('Cancelar'),
                                      onPressed: () {
                                        Navigator.of(context)
                                            .pop(false); // Não excluir
                                      },
                                    ),
                                    TextButton(
                                      child: Text('Excluir'),
                                      onPressed: () {
                                        Navigator.of(context)
                                            .pop(true); // Excluir
                                      },
                                    ),
                                  ],
                                );
                              },
                            ) ??
                            false;

                        // Se confirmar a exclusão, chama o serviço de exclusão
                        if (confirmDelete) {
                          await _vehicleService.deleteVehicle(vehicle.id);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text('Veículo excluído com sucesso!')),
                          );
                        }
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/adicionar-veiculo');
        },
        child: Icon(Icons.add),
        tooltip: 'Adicionar Veículo',
      ),
    );
  }
}
