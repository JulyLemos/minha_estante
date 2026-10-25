import 'package:flutter/material.dart';
import 'Livro.dart';


class TelaDetalhe extends StatelessWidget {
  final Livro livro;

  TelaDetalhe(this.livro);

  Future<bool> _confirmaExclusao(BuildContext context) async {
    bool? resposta = await showDialog<bool>(
      context: context,
      builder: (BuildContext contextoDialogo) {
        return AlertDialog(
          title: Text('Confirma exclusao?'),
          content: Text('Deseja excluir o livro "${livro.titulo}" ?'),
          actions: [
            TextButton(
              child: Text('NAO'),
              onPressed: () {
                Navigator.pop(contextoDialogo, false);
              },
            ),
            TextButton(
              child: Text('SIM'),
              onPressed: () {
                Navigator.pop(contextoDialogo, true);
              },
            ),
          ],
        );
      },
    );
    return resposta ?? false;
  }

  @override
  Widget build(BuildContext context) {
    TextStyle estiloRotulo = TextStyle(fontSize: 14, color: Colors.grey);
    TextStyle estiloValor = TextStyle(fontSize: 22);

    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhes do Livro'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('TITULO:', style: estiloRotulo),
            Text(livro.titulo, style: estiloValor),
            SizedBox(height: 16),
            Text('AUTOR:', style: estiloRotulo),
            Text(livro.autor, style: estiloValor),
            SizedBox(height: 16),
            Text('ANO:', style: estiloRotulo),
            Text(livro.ano.toString(), style: estiloValor),
            Spacer(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: Text('EXCLUIR', style: TextStyle(color: Colors.white)),
              onPressed: () async {
                bool confirmou = await _confirmaExclusao(context);
                if (confirmou) {
                  Navigator.pop(context, true);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}