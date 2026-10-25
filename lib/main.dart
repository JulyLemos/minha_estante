import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'telaLista.dart';

void main() async {
  // Precisa ser chamado antes de qualquer uso do Firebase.
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    MaterialApp(
      title: 'Minha Estante',
      home: TelaLista(),
    ),
  );
}
