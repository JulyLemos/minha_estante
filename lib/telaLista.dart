import 'package:flutter/material.dart';
import 'Livro.dart';
import 'firestore_service.dart';
import 'telaCadastro.dart';
import 'telaDetalhe.dart';

class TelaLista extends StatefulWidget {
  @override
  State createState() => TelaListaState();
}

class TelaListaState extends State<TelaLista> {
  final FirestoreService _bancoNuvem = FirestoreService();

  List<Livro> _livros = [];

  // Acessar a nuvem demora um pouco, entao mostramos um indicador de carga.
  bool _carregando = true;

  @override
  void initState() {
    super.initState();
    _carregarLivros();
  }

  void _mostraErro(String mensagem) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(mensagem)),
    );
  }

  void _carregarLivros() async {
    try {
      List<Livro> lista = await _bancoNuvem.listarTodos();
      if (!mounted) return;
      setState(() {
        _livros = lista;
        _carregando = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _carregando = false;
      });
      _mostraErro('Nao foi possivel carregar os livros: $e');
    }
  }

  void _abreTelaCadastro(BuildContext context) async {
    var resultado = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return TelaCadastro();
        },
      ),
    );

    if (resultado is Livro) {
      try {
        await _bancoNuvem.inserir(resultado);
        _carregarLivros();
      } catch (e) {
        _mostraErro('Nao foi possivel salvar o livro: $e');
      }
    }
  }

  void _abreTelaDetalhe(BuildContext context, Livro livro) async {
    var resultado = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return TelaDetalhe(livro);
        },
      ),
    );

    if (resultado == true) {
      try {
        await _bancoNuvem.excluir(livro.id!);
        _carregarLivros();
      } catch (e) {
        _mostraErro('Nao foi possivel excluir o livro: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Minha Estante'),
      ),
      body: _carregando
          ? Center(child: CircularProgressIndicator())
          : _livros.isEmpty
              ? Center(
                  child: Text(
                    'Nenhum livro cadastrado.\nToque no botao + para adicionar.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18),
                  ),
                )
              : ListView.builder(
                  padding: EdgeInsets.all(10),
                  itemCount: _livros.length,
                  itemBuilder: (BuildContext _context, int i) {
                    return _buildRow(_livros[i]);
                  },
                ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          _abreTelaCadastro(context);
        },
      ),
    );
  }

  Widget _buildRow(Livro livro) {
    return Card(
      color: Colors.teal[50],
      child: ListTile(
        title: Text(
          livro.titulo,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        subtitle: Text('${livro.autor} - ${livro.ano}'),
        onTap: () {
          _abreTelaDetalhe(context, livro);
        },
      ),
    );
  }
}
