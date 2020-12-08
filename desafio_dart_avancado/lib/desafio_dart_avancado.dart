import 'package:mysql1/mysql1.dart';
import 'package:desafio_dart_avancado/api/api_cidades.dart';
import 'package:desafio_dart_avancado/api/api_estados.dart';

Future<void> run() async {
  // Inicia a conexão com o MySQL
  var conn = await getConnection();

  // Cria as tabelas
  await createTables(conn);

  // Incrementa estados e cidades
  await incrementEstados(conn);

  // Fecha a conexão
  await conn.close();

  print('O processo foi concluído com sucesso.');
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
void createTables(MySqlConnection conn) async {
  // Cria a tabela de estados
  await conn.query('''CREATE TABLE estados (
                        id int primary key not null, 
                        estado varchar(100) not null, 
                        sigla varchar(2) not null);
                  ''');
  print("Tabela 'estados' criada.");

  // Cria a tabela de cidades
  await conn.query('''CREATE TABLE cidades (
                        id int primary key not null,
                        cidade varchar(100) not null,
                        estado_id int not null,
                        foreign key (estado_id) references estados(id));
                  ''');
  print("Tabela 'cidades' criada.");
}

// Função de incremento de estados
void incrementEstados(MySqlConnection conn) async {
  // Conecta com a API para pegar os estados
  var estados = await getEstados();

  // Adiciona os estados no banco
  await Future.forEach(estados, (e) async {
    // Insert de estados
    await conn.query('INSERT INTO estados (id, estado, sigla) VALUES (?, ?, ?)',
        [e.id, e.nome, e.sigla]);
    print('Estado ${e.nome} foi adicionado');

    await incrementCidades(conn, e.id);
    print('Todas as cidades do estado ${e.nome} foram adicionadas');
  });
}

// Função de incremento de cidades
void incrementCidades(MySqlConnection conn, int estado_id) async {
  // Conecta com a API para pegar as cidades
  var cidades = await getCidades(estado_id);

  // Adiciona as cidades no banco
  await Future.forEach(cidades, (c) async {
    // Insert de cidades
    await conn.query(
        'INSERT INTO cidades (id, cidade, estado_id) VALUES (?, ?, ?)',
        [c.id, c.nome, estado_id]);
  });
}
