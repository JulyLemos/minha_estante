import 'package:cloud_firestore/cloud_firestore.dart';
import 'Livro.dart';

//
// Classe que concentra o acesso ao banco na nuvem (Cloud Firestore).
// Substitui o antigo DatabaseHelper (SQLite). Os metodos tem os mesmos
// nomes de antes: inserir, listarTodos e excluir.
//
// Estrutura no Firestore:
//   colecao "livros"
//     └── documento (id gerado automaticamente)
//           ├── titulo : String
//           ├── autor  : String
//           └── ano    : int
//
class FirestoreService {
  // instancia unica (mesmo padrao Singleton de antes)
  static final FirestoreService _instancia = FirestoreService._interna();
  factory FirestoreService() => _instancia;
  FirestoreService._interna();

  // Referencia para a colecao "livros" la na nuvem.
  final CollectionReference<Map<String, dynamic>> _colecao =
      FirebaseFirestore.instance.collection('livros');

  // INSERE um novo livro. Retorna o id gerado pelo Firestore.
  Future<String> inserir(Livro livro) async {
    DocumentReference<Map<String, dynamic>> doc =
        await _colecao.add(livro.toMap());
    return doc.id;
  }

  // LISTA todos os livros gravados na nuvem.
  Future<List<Livro>> listarTodos() async {
    QuerySnapshot<Map<String, dynamic>> resultado = await _colecao.get();
    // Transforma cada documento num objeto Livro:
    List<Livro> lista =
        resultado.docs.map((doc) => Livro.fromMap(doc.data(), doc.id)).toList();
    // O Firestore nao garante ordem de insercao, entao ordenamos por titulo.
    lista.sort(
        (a, b) => a.titulo.toLowerCase().compareTo(b.titulo.toLowerCase()));
    return lista;
  }

  // EXCLUI o livro que tem o id passado.
  Future<void> excluir(String id) async {
    await _colecao.doc(id).delete();
  }
}
