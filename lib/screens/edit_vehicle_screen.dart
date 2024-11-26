import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditVehicleScreen extends StatefulWidget {
  final String vehicleId;

  EditVehicleScreen({required this.vehicleId});

  @override
  _EditVehicleScreenState createState() => _EditVehicleScreenState();
}

class _EditVehicleScreenState extends State<EditVehicleScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _nome, _modelo, _ano, _placa;

  @override
  void initState() {
    super.initState();
    // Carregar os dados do veículo ao iniciar a tela
    _loadVehicleData();
  }

  void _loadVehicleData() async {
    final vehicleDoc = await FirebaseFirestore.instance
        .collection('vehicles')
        .doc(widget.vehicleId)
        .get();

    if (vehicleDoc.exists) {
      setState(() {
        _nome = vehicleDoc['nome'];
        _modelo = vehicleDoc['modelo'];
        _ano = vehicleDoc['ano'];
        _placa = vehicleDoc['placa'];
      });
    }
  }

  void _saveChanges() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      // Atualiza o veículo no Firestore
      await FirebaseFirestore.instance
          .collection('vehicles')
          .doc(widget.vehicleId)
          .update({
        'nome': _nome,
        'modelo': _modelo,
        'ano': _ano,
        'placa': _placa,
      });

      Navigator.pop(context); // Volta para a tela anterior
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Editar Veículo')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: _nome,
                decoration: InputDecoration(labelText: 'Nome'),
                onSaved: (value) => _nome = value,
              ),
              TextFormField(
                initialValue: _modelo,
                decoration: InputDecoration(labelText: 'Modelo'),
                onSaved: (value) => _modelo = value,
              ),
              TextFormField(
                initialValue: _ano,
                decoration: InputDecoration(labelText: 'Ano'),
                onSaved: (value) => _ano = value,
              ),
              TextFormField(
                initialValue: _placa,
                decoration: InputDecoration(labelText: 'Placa'),
                onSaved: (value) => _placa = value,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveChanges,
                child: Text('Salvar Alterações'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
