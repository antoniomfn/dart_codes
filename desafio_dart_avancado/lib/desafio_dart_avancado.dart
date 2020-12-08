import 'package:mysql1/mysql1.dart';
import 'package:desafio_dart_avancado/api/api_cidades.dart';
import 'package:desafio_dart_avancado/api/api_estados.dart';

void run() async {
  // Inicia a conexão com o MySQL
  var conn = await getConnection();

  // Cria as tabelas
  await createTables(conn);

  // Inicia a função de incremento
  await increment(conn);
}

Future<MySqlConnection> getConnection() async {
  var settings = ConnectionSettings(
      host: 'localhost',
      port: 3306,
      user: 'root',
      password: 'root',
      db: 'ibge');
  return await MySqlConnection.connect(settings);
}

// Função de criar tabelas
void createTables(MySqlConnection connection) async {
  await connection.query('''CREATE TABLE IF NOT EXISTS estados (
                        id int primary key not null, 
                        estado varchar(100) not null, 
                        sigla varchar(2) not null);
                   ''');
  await connection.query('''CREATE TABLE IF NOT EXISTS cidades (
                        id int primary key not null,
                        cidade varchar(100) not null,
                        estado_id int not null,
                        foreign key (estado_id) references estados(id));
                   ''');

  print('Tabelas criadas com sucesso.');
}

// Função de incremento de estados
void increment(MySqlConnection conn) async {
  // Conecta com a API para pegar os estados
  var estados = await getEstados();
  // Adiciona os estados no banco
  estados.forEach((e) async {
    // Insert de estados
    await conn.query('INSERT INTO estados (id, estado, sigla) VALUES (?, ?, ?)',
        [e.id, e.nome, e.sigla]);
    // Conecta com a API para pegar as cidades
    var cidades = await getCidades(e.id);
    cidades.forEach((c) {
      // Insert de cidades
      conn.query('INSERT INTO cidades (id, cidade, estado_id) VALUES (?, ?, ?)',
          [c.id, c.nome, e.id]);
    });
    print('Todas as cidades do estado ${e.nome} foram adicionadas');
  });
}
