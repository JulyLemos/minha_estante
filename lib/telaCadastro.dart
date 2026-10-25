import 'package:flutter/material.dart';
import 'Livro.dart';

class TelaCadastro extends StatefulWidget {
  @override
  State createState() => TelaCadastroState();
}

class TelaCadastroState extends State<TelaCadastro> {
  TextEditingController tcTitulo = TextEditingController();
  TextEditingController tcAutor = TextEditingController();
  TextEditingController tcAno = TextEditingController();

  InputDecoration decora(String rotulo) {
    return InputDecoration(
      labelText: rotulo,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(6.0)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Novo Livro'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: TextField(
                controller: tcTitulo,
                decoration: decora('Titulo'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: TextField(
                controller: tcAutor,
                decoration: decora('Autor'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: TextField(
                controller: tcAno,
                keyboardType: TextInputType.number,
                decoration: decora('Ano de publicacao'),
              ),
            ),
            ElevatedButton(
              child: Text('SALVAR'),
              onPressed: () {
                if (tcTitulo.text.isEmpty ||
                    tcAutor.text.isEmpty ||
                    tcAno.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Preencha todos os campos!')),
                  );
                  return;
                }
                Livro novoLivro = Livro(
                  tcTitulo.text,
                  tcAutor.text,
                  int.parse(tcAno.text),
                );
                Navigator.pop(context, novoLivro);
              },
            ),
            SizedBox(height: 10),
            ElevatedButton(
              child: Text('CANCELAR'),
              onPressed: () {
                Navigator.pop(context, null);
              },
            ),
          ],
        ),
      ),
    );
  }
}