void main(List<String> args) {
  var pacientes = [
    'Rodrigo Rahman|35|desenvolvedor|SP',
    'Manoel Silva|12|estudante|MG',
    'Joaquim Rahman|18|estudante|SP',
    'Fernando Verne|35|estudante|MG',
    'Gustavo Silva|40|estudante|MG',
    'Sandra Silva|40|estudante|MG',
    'Regina Verne|35|estudante|MG',
    'João Rahman|55|Jornalista|SP',
  ];
  
  // Baseado no array acima monte um relatório onde mostre
  
  int totalMaisVinte = 0;
  List<String> familias = List();
  List<String> nomes = List();
  
  for (var p in pacientes) {
    var dados = p.split('|');
    if (int.tryParse(dados[1]) > 20) {
      totalMaisVinte++;
    }
    
    nomes.add(dados[0]);
    familias.add(dados[0].split(' ')[1]);
  }
  
  familias = familias.toSet().toList();
  
  // Apresente a quantidade de pacientes com mais de 20 anos

  print('Há $totalMaisVinte pacientes com mais de 20 anos.');
  
  // Agrupar os pacientes por familia(considerar o sobrenome) apresentar por familia.
  
  for (var f in familias) {
    print('\nFamilia $f');
    for (var n in nomes) {
      if (n.contains(f)) {
        print(n.split(' ')[0]);
      }
    }
  }
}
