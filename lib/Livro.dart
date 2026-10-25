class Livro {
  // No Firestore, o id e uma String gerada pelo proprio banco
  // (antes, no SQLite, era um int AUTOINCREMENT).
  String? id;
  String titulo;
  String autor;
  int ano;

  Livro(this.titulo, this.autor, this.ano, {this.id});

  // O id NAO vai dentro do Map: no Firestore ele e o nome do documento.
  Map<String, dynamic> toMap() {
    return {
      'titulo': titulo,
      'autor': autor,
      'ano': ano,
    };
  }

  // Recebe os dados do documento e tambem o id do documento.
  static Livro fromMap(Map<String, dynamic> map, String id) {
    return Livro(
      map['titulo'],
      map['autor'],
      (map['ano'] as num).toInt(),
      id: id,
    );
  }
}
