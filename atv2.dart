// N1-E2 - BBS Dart Console
// Complete apenas os trechos marcados com TODO.
// O programa deve funcionar em Dart puro, sem bibliotecas externas.
// Não é necessário ler dados do teclado: a navegação é simulada no main().

class Mensagem {
  final int id;
  final String area;
  final String titulo;
  final String autor;
  final String conteudo;
  final int visualizacoes;
  final bool nova;

  const Mensagem({
    required this.id,
    required this.area,
    required this.titulo,
    required this.autor,
    required this.conteudo,
    required this.visualizacoes,
    this.nova = false,
  });
}

class Bbs {
  final String nome;
  final String sysop;
  final int velocidadeModem;
  final List<Mensagem> mensagens;

  const Bbs({
    required this.nome,
    required this.sysop,
    required this.velocidadeModem,
    required this.mensagens,
  });

  // TODO 1 (FEITO):
  // Retorne a quantidade total de mensagens cadastradas na BBS.
  int get totalMensagens => (this.mensagens.length);

  // TODO 2 (FEITO):
  // Some o número de visualizações de todas as mensagens.
  // O valor deve ser calculado a partir da lista "mensagens".
  int get totalVisualizacoes => (this.mensagens.fold(
    0, (total, msg) => total + msg.visualizacoes
  ));

  // TODO 3 (FEITO):
  // Conte quantas mensagens possuem nova == true.
  int get mensagensNovas => (this.mensagens.where((m) => m.nova)).toList().length;

  // TODO 4 (FEITO):
  // Retorne uma lista contendo os nomes das áreas existentes,
  // sem repetir nomes. Ex.: ['GERAL', 'GAMES', 'TECNOLOGIA'].
  List<String> get areas => (this.mensagens.map((m) => m.area)).toSet().toList();

  // TODO 5 (FEITO):
  // Retorne apenas as mensagens pertencentes à área informada.
  // A comparação deve ignorar maiúsculas/minúsculas.
  List<Mensagem> mensagensDaArea(String nomeArea) => (this.mensagens.where(
    (m) => m.area.trim().toLowerCase() == nomeArea.toLowerCase()).toList()
  );

  // TODO 6 (FEITO:
  // Procure uma mensagem pelo id.
  // Retorne a mensagem encontrada ou null se o id não existir.
  Mensagem? buscarMensagem(int id) => (this.mensagens.firstWhere((m) => m.id == id));
}

void imprimirCabecalho(Bbs bbs) {
  // TODO 7:
  // Imprima um cabeçalho semelhante a:
  //
  // ==========================================
  //            BYTE LINE BBS
  // ==========================================
  // SysOp: Morgan
  // Modem: 14400 bps
  // Mensagens: 6 | Novas: 3
  //

  print("===============================");
  print("         BYTE LINE BBS         ");
  print("===============================");
  print("SysOp: Morgan");
  print('Mensagens: ${bbs.totalMensagens} | Novas: ${bbs.mensagensNovas}\n');

}

void imprimirMenu(Bbs bbs) {
  // TODO 8:
  // Imprima "ÁREAS DISPONÍVEIS" e liste todas as áreas.
  // Ao lado de cada área, mostre quantas mensagens ela possui.
  //
  // Exemplo:
  // [1] GERAL       - 2 mensagens
  // [2] GAMES       - 2 mensagens
  print("ÁREAS DISPONÍVEIS");
  print('[1] GERAL - ${bbs.mensagensDaArea("GERAL").length} mensagens');
  print('[2] GAMES - ${bbs.mensagensDaArea("GAMES").length} mensagens');
  print('[3] TECNOLOGIA - ${bbs.mensagensDaArea("TECNOLOGIA").length} mensagens');
  print('[4] DOWNLOADS - ${bbs.mensagensDaArea("DOWNLOADS").length} mensagens\n');
}

void imprimirArea(Bbs bbs, String area) {
  // TODO 9:
  // Liste as mensagens da área recebida.
  // Para cada mensagem, mostre:
  // ID, indicador [NOVO] quando nova == true, título, autor e visualizações.
  //
  // Exemplo:
  // #03 [NOVO] Doom: dicas para o episódio 1
  //     por: Raven | visualizações: 42
  print('=== ÁREA: ${area} ===');
  final mensagensDaArea = bbs.mensagensDaArea(area);

  for (Mensagem m in mensagensDaArea) {
    final titulo = m.nova 
      ? '[NOVO] ${m.titulo}' 
      : m.titulo;

    print('#${m.id} ${titulo}');
    print('   por: ${m.autor} | visualizações: ${m.visualizacoes}');
  }
}

void imprimirMensagem(Bbs bbs, int id) {
  // TODO 10:
  // Use buscarMensagem(id).
  // Se não existir, imprima "Mensagem não encontrada."
  // Se existir, imprima os dados e o conteúdo da mensagem.
  final msg = bbs.buscarMensagem(id);
  if (msg == null) {
    print("Mensagem não encontrada");
    return;
  }

  print('Título: ${msg.titulo}');
  print('Autor: ${msg.autor}');
  print('Área: ${msg.area}');
  print('Visualizações: ${msg.visualizacoes}');
  print('----------------------------------------------');
  print(msg.conteudo);
}

void imprimirEstatisticas(Bbs bbs) {
  // TODO 11:
  // Mostre:
  // - quantidade de áreas
  // - total de mensagens
  // - mensagens novas
  // - total de visualizações
  //
  // Todos os valores devem ser calculados.

  print('Áreas: ${bbs.areas.length}');
  print('Mensagens: ${bbs.totalMensagens}');
  print('Mensagens novas: ${bbs.mensagensNovas}');
  print('Mensagens novas: ${bbs.totalVisualizacoes}');
}

void main() {
  final mensagens = <Mensagem>[
    Mensagem(
      id: 1,
      area: 'GERAL',
      titulo: 'Bem-vindos à Byte Line BBS',
      autor: 'Morgan',
      conteudo:
          'A BBS está oficialmente no ar. Leia as regras e aproveite as áreas.',
      visualizacoes: 85,
      nova: false,
    ),
    Mensagem(
      id: 2,
      area: 'GERAL',
      titulo: 'Horário de manutenção',
      autor: 'Morgan',
      conteudo:
          'No domingo, entre 02:00 e 03:00, o sistema ficará indisponível.',
      visualizacoes: 31,
      nova: true,
    ),
    Mensagem(
      id: 3,
      area: 'GAMES',
      titulo: 'Doom: dicas para o episódio 1',
      autor: 'Raven',
      conteudo:
          'Procure paredes com texturas diferentes. Algumas escondem áreas secretas.',
      visualizacoes: 42,
      nova: true,
    ),
    Mensagem(
      id: 4,
      area: 'GAMES',
      titulo: 'SimCity 2000 - estratégias iniciais',
      autor: 'Vector',
      conteudo:
          'Comece pequeno, controle os gastos e não expanda a cidade rápido demais.',
      visualizacoes: 64,
      nova: false,
    ),
    Mensagem(
      id: 5,
      area: 'TECNOLOGIA',
      titulo: 'Vale a pena trocar para modem 14400?',
      autor: 'ByteKid',
      conteudo:
          'A diferença é perceptível em arquivos maiores, mas depende da qualidade da linha.',
      visualizacoes: 53,
      nova: true,
    ),
    Mensagem(
      id: 6,
      area: 'DOWNLOADS',
      titulo: 'Novo pacote de ANSI art',
      autor: 'Neon',
      conteudo:
          'Adicionei um pacote com telas ANSI para quem mantém BBS própria.',
      visualizacoes: 27,
      nova: false,
    ),
  ];

  final bbs = Bbs(
    nome: 'BYTE LINE BBS',
    sysop: 'Morgan',
    velocidadeModem: 14400,
    mensagens: mensagens,
  );

  // A navegação abaixo é simulada.
  // Não altere esta sequência.
  print('Discando...');
  print('CONNECT ${bbs.velocidadeModem}');
  print('');

  imprimirCabecalho(bbs);

  print('');
  imprimirMenu(bbs);

  print('');
  imprimirArea(bbs, 'GAMES');

  print('');
  imprimirMensagem(bbs, 4);

  print('');
  imprimirEstatisticas(bbs);

  print('');
  print('NO CARRIER');
}
