main(List<String> args) {
  var pessoas = [
    'Rodrigo Rahman|35|Masculino',
    'Jose|56|Masculino',
    'Joaquim|84|Masculino',
    'Rodrigo Rahman|35|Masculino',
    'Maria|88|Feminino',
    'Helena|24|Feminino',
    'Leonardo|5|Masculino',
    'Laura Maria|29|Feminino',
    'Joaquim|72|Masculino',
    'Helena|24|Feminino',
    'Guilherme|15|Masculino',
    'Manuela|85|Masculino',
    'Leonardo|5|Masculino',
    'Helena|24|Feminino',
    'Laura|29|Feminino',
  ];
  
  // Baseado na lista acima.
  // 1 - Remover os duplicados
 
  pessoas = pessoas.toSet().toList();

  // 2 - Me mostre a quantidade de pessoas do sexo Masculino e Feminino
  
  int m = pessoas.where((e) => e.split('|')[2] == 'Masculino').fold(0, (a, b) => a += 1);
  int f = pessoas.where((e) => e.split('|')[2] == 'Feminino').fold(0, (a, b) => a += 1);
  
  print('Há $m pessoas do sexo Masculino.');
  print('Há $f pessoas do sexo Feminino.');
  
  // 3 - Filtrar e deixar a lista somente com pessoas maiores de 18 anos 
  //     e mostre a quantidade de pessoas com mais de 18 anos também separado por sexo
  
  pessoas.removeWhere((e) => int.tryParse(e.split('|')[1]) < 18);
  
  m = pessoas.where((e) => e.split('|')[2] == 'Masculino').fold(0, (a, b) => a += 1);
  f = pessoas.where((e) => e.split('|')[2] == 'Feminino').fold(0, (a, b) => a += 1);
  
  print('\nHá $m pessoas do sexo Masculino com mais de 18 anos.');
  print('Há $f pessoas do sexo Feminino com mais de 18 anos.');
  
  // 4 - Encontre a pessoa mais velha.
  
  pessoas.sort((a, b) => b.split('|')[1].compareTo(a.split('|')[1]));
  
  print('\nA pessoas mais velha é ${pessoas.first.split('|')[0]} com ${pessoas.first.split('|')[1]} anos.');
}
