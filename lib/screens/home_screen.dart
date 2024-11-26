import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tela Inicial'),
        // Ações podem ser adicionadas aqui
      ),
      drawer: Drawer(
        // Adicionando um Drawer para navegação
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Bem-vindo!',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: Text('Home'),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/home');
              },
            ),
            ListTile(
              title: Text('Meus Veículos'),
              onTap: () {
                Navigator.pushNamed(context, '/meus-veiculos');
              },
            ),
            ListTile(
              title: Text('Adicionar Veículo'),
              onTap: () {
                Navigator.pushNamed(context, '/adicionar-veiculo');
              },
            ),
            ListTile(
              title: Text('Logout'),
              onTap: () {
                // Aqui você pode implementar a função de logout
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Bem-vindo à Tela Inicial!',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/meus-veiculos');
              },
              child: Text('Ver Meus Veículos'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/adicionar-veiculo');
              },
              child: Text('Adicionar Novo Veículo'),
            ),
          ],
        ),
      ),
    );
  }
}
